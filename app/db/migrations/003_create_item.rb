Sequel.migration do
  up do
    create_table(:items) do
      primary_key :id

      String :name, null: false
      String :desc
      Float :price, null: false

      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:items)
  end
end
