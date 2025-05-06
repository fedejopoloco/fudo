# Fudo

**Fudo** es una aplicación para la administración de productos, desarrollada en **Ruby** utilizando **Rack**, **JWT** y el servidor **WEBrick**. Esta app permite gestionar productos mediante una API simple, ideal para aprender sobre APIs en Ruby sin frameworks pesados.

---

## 🚀 Características

- API para crear, listar y buscar por id productos.
- Autenticación basada en JSON Web Tokens (JWT).
- Arquitectura modular utilizando Rack.
- Opcionalmente desplegable con Docker y Docker Compose.

---

## 📦 Requisitos previos

Antes de comenzar, asegúrate de tener instalado:

- [Git](https://git-scm.com/downloads)
- [Ruby](https://rubyinstaller.org/)
- [Bundler](https://bundler.io/)  
- [Docker Desktop (opcional)](https://www.docker.com/products/docker-desktop/)

---

## 📥 Instalación y puesta en marcha

Clona el repositorio: https://github.com/fedejopoloco/fudo
```bash
git clone https://github.com/fedejopoloco/fudo.git
cd fudo
```

## 🔧 Opción 1: Correr localmente con Ruby (sin Docker)

Instala las dependencias necesarias:

```bash
gem install rack -v 2.2.13
bundle install
```
Inicia la aplicación:

```bash
rackup
```

## 🐳 Opción 2: Usar Docker y Docker Compose
Requiere tener Docker y Docker Compose instalados.

Desde la raíz del proyecto, ejecuta:

```bash
docker-compose build
docker-compose up
```
## 📚 Endpoints disponibles

| Método | Ruta            | Descripción                      | Autenticación |
| ------ | --------------- | -------------------------------- | ------------- |
| POST   | `/login`        | Iniciar sesión y obtener token   | ❌ No          |
| GET    | `/products`     | Listar todos los productos       | ✅ Sí          |
| GET    | `/products/:id` | Obtener un producto por ID       | ✅ Sí          |
| POST   | `/products`     | Crear un nuevo producto          | ✅ Sí          |
| PUT    | `/products/:id` | Actualizar un producto existente | ✅ Sí          |
| DELETE | `/products/:id` | Eliminar un producto             | ✅ Sí          |


