class Push < ActiveRecord::Base
  include UserResource

  belongs_to :design
  belongs_to :address_book

  def date_push_presenter
    if date_push
      result =  date_push
    else
      result = "Pending"
    end
  end

  def feedback_presenter
    feedback ||=  0.0
    (feedback * 100).to_s + "%"
  end
end
