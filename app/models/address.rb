class Address < ApplicationRecord
  belongs_to :order # これを追記
end
