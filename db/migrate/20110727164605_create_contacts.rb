class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :area
      t.string :province
      t.string :city
      t.string :company
      t.string :industry
      t.string :name
      t.string :gender
      t.string :department
      t.string :position
      t.string :area_code
      t.string :phone
      t.string :ext
      t.string :fax
      t.string :email
      t.string :mobile
      t.string :address
      t.string :zipcode
      t.string :employee_number

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
