ActiveRecord::Schema.define do
  create_table(:photos, force: true) do |t|
    t.string :name
    t.string :file
  end
end
