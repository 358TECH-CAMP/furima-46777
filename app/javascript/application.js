// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "item_price"
// 【追加】importmapで登録した「card」を読み込んで、実際にブラウザで実行させる
import "card"