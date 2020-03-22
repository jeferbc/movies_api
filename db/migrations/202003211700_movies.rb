# TODO: add timestamps
Sequel.migration do
  change do
    create_table(:movies) do
      primary_key :id
      String :name, null: false
      String :description, null: false
      String :url_image, null: false
    end
  end
end
