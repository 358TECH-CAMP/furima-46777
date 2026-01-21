# Capistranoのバージョンを固定
lock "3.17.3"

# アプリケーション名
set :application, "furima-46777"

# GitHubのリポジトリURL（SSH形式）
set :repo_url, "git@github.com:358TECH-CAMP/furima-46777.git"

set :branch, "main"
# 共有ディレクトリの設定（デプロイ後も中身を維持するフォルダ）
# これにより、デプロイのたびにログや画像が消えるのを防ぎます
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Rubyのバージョン管理（rbenv）の設定
set :rbenv_type, :user
set :rbenv_ruby, '3.2.0' 

# SSH接続の設定（鍵の場所を指定）
set :ssh_options, {
  auth_methods: ['publickey'],
  keys: ['~/.ssh/furima-key.pem'] 
}

# 保存する過去バージョンの数（最新から5つ分）
set :keep_releases, 5

# デプロイ後にUnicornを再起動する設定
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end