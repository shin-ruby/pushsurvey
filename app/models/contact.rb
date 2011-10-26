#coding:utf-8
class Contact < ActiveRecord::Base
  attr_accessor :validation_step
  acts_as_audited
  belongs_to :address_book, :counter_cache => true

  ALIAS_NAMES = {"区域" => "area", "省份"=>"province", "城市"=>"city", "单位名称" => "company", "所属行业" => "level1_industry",
                 "行业二级" => "level2_industry", "联系人" => "name", "性别" => "gender", "部门" => "department", "职位" => "position",
                 "区号" => "area_code", "电话" => "phone", "分机" => "ext", "传真"=> "fax", "手机" => "mobile",
                 "地址" => "address", "邮编" => "zipcode", "员工人数" => "employee_number", "pc数" => "pc_number",
                 "EMAIL" => "email", "Email" => "email", "Name" => "name", "NAME" => "name", "First Name" => "firstname", "Last Name"=>"lastname",
                 "First name" => "firstname", "Last name"=>"lastname", "Firstname" => "firstname", "Lastname"=>"lastname"}

  AREAS = %w(东区 中区 南区 西南 西北 北区)



  validates_format_of :email, :with => EMAIL_REGEX , :if => lambda {  validation_step.nil? || validation_step == "format"}

  validates_uniqueness_of :email, :scope => :address_book_id, :if => lambda {  validation_step.nil? || validation_step == "uniqueness"}



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
