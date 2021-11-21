# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String   :first_name
      String   :last_name
      String   :username
      Integer  :chat_id
      DateTime :date_of_birth
      String   :action

      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:users)
  end
end
