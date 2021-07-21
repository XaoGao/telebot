Sequel.migration do
  up do
    create_table(:vacations) do
      primary_key :id
      foreign_key :user_id, :users
      DateTime :from
      DateTime :by

      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:vacations)
  end
end
