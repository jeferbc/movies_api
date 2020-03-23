Sequel.migration do
  change do
    create_table(:presentations) do
      primary_key :id
      Date :day, null: false
      Integer :movie_id, foreign_key: true
    end
  end
end
