# config.ru
require_relative 'app'
require 'rack/jwt'
require 'rack/deflater' 

use Rack::Static,
  urls: ["/openapi.yaml", "/docs", "/AUTHORS"],
  root: ".",
  header_rules: [
    ["/openapi.yaml", { 'cache-control' => 'no-store, no-cache, must-revalidate, max-age=0' }],
    ["/AUTHORS", { 'cache-control' => 'public, max-age=86400' }]
]

use Rack::JWT::Auth,
  secret: 'mi_clave_secreta',
  options: { algorithm: 'HS256' },
  exclude: ['/auth', '/openapi.yaml', '/favicon.ico', '/docs', '/AUTHORS']

use Rack::Deflater

Thread.new do
  loop do
    sleep 1
    now = Time.now.utc

    ProductStore.all_status_pending.each do |product|
      created_at = Time.parse(product[:fecha_creacion])
      if (now - created_at) >= 5
        product[:estado] = 'CREATED'
        puts "Producto ##{product[:id]} actualizado a CREATED"
      end
    end
  end
end

#use Rack::Lint
run App.new