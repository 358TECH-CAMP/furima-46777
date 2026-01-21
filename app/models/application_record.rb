class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # 以下の1行を追加します
  ActiveRecord::Schema.default_string_length = 191
end
