# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :wmi_property do |f|
  f.wmi_class_id 1
  f.name "MyString"
  f.type "MyString"
end