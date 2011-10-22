class ConfirmationController < ApplicationController
  def confirmation
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
