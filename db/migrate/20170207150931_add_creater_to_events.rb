class AddCreaterToEvents < ActiveRecord::Migration[5.0]
  def change
	add_column :events, :creator, :string
  end
end
