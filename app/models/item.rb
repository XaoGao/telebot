class Item < Sequel::Model(DB)
  plugin :timestamps, update_on_create: true
  plugin :validation_helpers

  def validate
    super
    validates_presence [:name, :desc, :price, :image]
    validates_unique [:name, :desc, :price, :image]
  end
end
