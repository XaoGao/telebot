class Item < Sequel::Model(DB)
  def validate
    super
    validates_presence [:name, :desc, :price, :image]
    validates_unique [:name, :desc, :price, :image]
  end
end
