class CreateForecasts < ActiveRecord::Migration[7.2]
  def change
    create_table :forecasts do |t|
      t.string :zipcode
      t.integer :todays_temp
      t.integer :high_temp
      t.integer :low_temp

      t.timestamps
    end
    add_index :forecasts, :zipcode, unique: true
  end
end
