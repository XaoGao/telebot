# frozen_string_literal: true

class Item < Sequel::Model(DB)
  def validate
    super
    validates_presence %i[name desc price image]
    validates_unique %i[name desc price image]
  end

  def path_to_image
    File.join(ROOT_PATH, 'assets', 'images', image)
  end

  def info
    "#{name}: #{desc}"
  end

  def price_info
    "Купить #{price} рублей"
  end
end
