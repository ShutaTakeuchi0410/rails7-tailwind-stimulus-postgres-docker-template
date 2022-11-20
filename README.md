# Rails7 x TailwindCSS x PostgreSQLのDockerテンプレート

```
バックエンド：　　Ruby on Rails 7
フロントエンド：　TailwindCSS & Stimulus.js
データベース：　　PostgreSQL
```

## 構築方法

### 1. テンプレートリポジトリを取得
```bash
$ mkdir YOUR_REPOSITORY_NAME
$ cd YOUR_REPOSITORY_NAME
$ git clone git@github.com:ShutaTakeuchi0410/rails7-tailwindcss-postgres-docker-template.git .
$ rm -rf .git/
```

### 2. Railsを作成
```bash
$ docker-compose run web rails new . --force --database=postgresql --css tailwind
```

### 3. データベースを作成
##### 1. `database.yml`を編集
1. 以下のコードに書き換える  
（test用のDBは作成しないようにコメントアウトしている）
2. データベース名を指定する  
（development > database > APP_NAME_development）

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

##### 2. 作成＆マイグレーションのコマンドを実行
```
$ docker-compose run --rm web rails db:create
$ docker-compose run --rm web rails db:migrate
```

### 4. `Procfile.dev`を編集
以下のコードに書き換える
```
web: bin/rails server -p 3000 -b "0.0.0.0"
css: bin/rails tailwindcss:watch
```

### 5. アプリを起動
```
$ docker-compose up
```