# -*- encoding : utf-8 -*-
require 'test_helper'

class ImporterTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  setup do
    @address_book = AddressBook.new
  end

  test "xls import should succeed" do
    assert_difference('Contact.count', 8) do
      Importer.do_import(File.join(File.dirname(File.expand_path(__FILE__)),"proedm.xls"), @address_book)
    end

    contacts = Contact.where(:name=>"刘德华")

    assert_equal "刘德华", contacts[0].name
    assert_equal "上海市", contacts[0].city

  end

end


