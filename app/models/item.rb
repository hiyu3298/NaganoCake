class Item < ApplicationRecord
  attachment :image

  enum is_active: { on_sale: 0, off_sale: 1 }
end
