# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# 自作JSを追加
pin "item_price", to: "item_price.js"
# 【追加】card.jsというファイルを「card」という名前で使うことをRailsに登録する
pin "card", to: "card.js"