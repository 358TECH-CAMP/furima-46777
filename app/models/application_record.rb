class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # ここを以下のように書き換えてください
  self.abstract_class = true
  begin
    ActiveRecord::Base.connection_config[:adapter] == 'mysql2' ? (ActiveRecord::Schema.default_string_length = 191) : nil
  rescue StandardError
    nil
  end
end
