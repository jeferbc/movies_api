Sequel.migration do
  change do
    create_table(:reservations) do
      primary_key :id
      String :username, null: false
      Integer :presentation_id, foreign_key: true
    end
  end
end
