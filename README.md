# Docker template for Rails7 x TailwindCSS x PostgreSQL

```
Backend:  Ruby on Rails 7
Frontend: TailwindCSS & Stimulus.js
Database: PostgreSQL
```

## Usage

### 1. Git Clone

```bash
$ mkdir YOUR_REPOSITORY_NAME
$ cd YOUR_REPOSITORY_NAME
$ git clone git@github.com:ShutaTakeuchi0410/rails7-tailwindcss-postgres-docker-template.git .
$ rm -rf .git/
```

### 2. Rails new

```bash
$ docker-compose run web rails new . --force --database=postgresql --css tailwind
```

### 3. Create Database

#### 1. Edit `database.yml`
1. Paste the following codes
2. Change database name (development > database > APP_NAME_development)

```bash
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <%= ENV["POSTGRES_USER"] %>
  password: <%= ENV["POSTGRES_PASSWORD"] %>
  host: db

development:
  <<: *default
  database: APP_NAME_development

# test:
#   <<: *default
#   database: APP_NAME_test

production:
  <<: *default
  url: <%= ENV['DATABASE_URL'] %>
```

#### 2. Create & Migrate
```
$ docker-compose run --rm web rails db:create
$ docker-compose run --rm web rails db:migrate
```

### 4. Edit `Procfile.dev`
Paste the following codes

```
web: bin/rails server -p 3000 -b "0.0.0.0"
css: bin/rails tailwindcss:watch
```

### 5. Start the app
```
$ docker-compose up
```