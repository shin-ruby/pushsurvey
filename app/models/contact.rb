class Contact < ActiveRecord::Base
  AREAS = %w(东区 中区 南区 西南 西北 北区)

  validates :name, :address, :email, :area, :presence => true
  validates :area, :inclusion => AREAS

end
