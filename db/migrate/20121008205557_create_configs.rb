class CreateConfigs < ActiveRecord::Migration
  def change
    create_table(:support_configs, :id => false) do |t|
      t.string(:name)
      t.string(:key)
      t.text(:value)
    end
  end
end
