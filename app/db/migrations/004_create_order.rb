# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:orders) do
      primary_key :id
      foreign_key :user_id, :users
      foreign_key :item_id, :items

      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:orders)
  end
end
