require 'test_helper'

class ImporterTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "xlxs import should succeed" do
    assert_difference('Contact.count') do
      Importer.do_import(File.join(File.dirname(File.expand_path(__FILE__)),"proedmDB.xlsx"), nil)
    end

    contacts = Contact.where(:name=>"邵登科")

    assert_equal "邵登科", contacts[0].name
    assert_equal "上海市", contacts[0].province
    assert_equal "上海市", contacts[0].city
  end

  #test "xlsx Book1 import should succeed" do
  #  assert_difference('Contact.count') do
  #    Importer.do_import(File.join(File.dirname(File.expand_path(__FILE__)),"Book1.xlsx"))
  #  end
  #
  #  contacts = Contact.where(:name=>"邵登科")
  #
  #  assert_equal "邵登科", contacts[0].name
  #  assert_equal "上海市", contacts[0].province
  #  assert_equal "上海市", contacts[0].city
  #end

  test "xls import should succeed" do
    assert_difference('Contact.count', 8) do
      Importer.do_import(File.join(File.dirname(File.expand_path(__FILE__)),"proedm.xls"), nil)
    end

    contacts = Contact.where(:name=>"刘德华")

    assert_equal "刘德华", contacts[0].name
    assert_equal "上海市", contacts[0].city

  end

end


