require 'rack'
require 'json'
require 'jwt'
require_relative 'product_store'

class App
  USERNAME = "admin"
  PASSWORD = "1234"
  SECRET_KEY = 'mi_clave_secreta'

  def call(env)
    req = Rack::Request.new(env)

    if req.post? && req.path == "/auth"
      begin
        data = JSON.parse(req.body.read)
        username = data["usuario"]
        password = data["contraseña"]

        if username == USERNAME && password == PASSWORD
          payload = { user: username, exp: Time.now.to_i + 3600 } # 1h de expiración
          token = JWT.encode(payload, SECRET_KEY, 'HS256')
          return json_response(200, { token: token })
        else
          return json_response(401, { error: "Credenciales inválidas" })
        end
      rescue JSON::ParserError
        return json_response(400, { error: "JSON inválido" })
      end
    end

    if req.post? && req.path == '/products'
      begin
        data = JSON.parse(req.body.read)
        name = data['nombre']

        if name.nil? || name.strip.empty?
          return json_response(400, { error: "El campo 'nombre' es requerido" })
        end

        product = ProductStore.create(name)
        json_response(201, product)

      rescue JSON::ParserError
        json_response(400, { error: "JSON inválido" })
      end
    elsif req.get? && req.path == '/products'
        return json_response(200, ProductStore.all)
    elsif req.get? && req.path =~ %r{^/products/(\d+)$}
      id = req.path.match(%r{^/products/(\d+)$})[1].to_i
      product = ProductStore.find_by_id(id)

      if product
        json_response(200, product)
      else
        json_response(404, { error: "Producto no encontrado" })
      end
    else
      json_response(404, { error: "Ruta no encontrada" })
    end
  end

  def json_response(status, data)
    headers = { 'content-type' => 'application/json' }
    [status, headers, [data.to_json]]
  end
end