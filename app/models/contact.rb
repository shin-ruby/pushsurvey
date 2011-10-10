#coding:utf-8
class Contact < ActiveRecord::Base

  belongs_to :address_book, :counter_cache => true

  ALIAS_NAMES = {"区域" => "area","省份"=>"province","城市"=>"city","单位名称" => "company","所属行业" => "level1_industry",
    "行业二级" => "level2_industry", "联系人" => "name","性别" => "gender", "部门" => "department","职位" => "position",
    "区号" => "area_code", "电话" => "phone", "分机" => "ext", "传真"=> "fax","EMAIL" => "email", "手机" => "mobile",
    "地址" => "address", "邮编" => "zipcode", "员工人数" => "employee_number", "pc数" => "pc_number"}

  AREAS = %w(东区 中区 南区 西南 西北 北区)



  #validates :name, :address, :email, :area, :presence => true
  #validates :area, :inclusion => AREAS
  def self.find_alias_name(id)
    result = ALIAS_NAMES[id.downcase] if id
    result ||= id.downcase if id
  end

  def friendly_name
    if firstname.present? || lastname.present?
      "#{firstname} #{lastname}"
    else
      name
    end
  end

end
