# DSLとデフォルトタスクの読み込み
require 'capistrano/setup'
require 'capistrano/deploy'

# Git関連のプラグイン
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Railsのデプロイに必要なプラグインを追加
require 'capistrano/rbenv'            # rbenv（Rubyのバージョン管理）を使用する場合
require 'capistrano/bundler'          # bundle installを自動化
require 'capistrano/rails/assets'     # assets:precompileを自動化
require 'capistrano/rails/migrations' # db:migrateを自動化
require 'capistrano3/unicorn'         # Unicornの再起動を自動化

# カスタムタスクの読み込み
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
