# -*- encoding : utf-8 -*-
class ConfirmationController < ApplicationController
  def confirmation
    if params[:from] == "address_book" && params[:bucket] #== "file1.pushsurvey.com"
      @address_book = AddressBook.find(params[:id])
      @address_book.attributes = params
      @address_book.save!
      CsvImporter.new(@address_book, :s3_key=>params[:key]).delay.import
    end


  end

  def back

    if params[:from] == "push"
       redirect_to root_url
    elsif params[:from] == "address_book"
       redirect_to address_books_path
    else #default
      redirect_to root_url
    end
  end

end
