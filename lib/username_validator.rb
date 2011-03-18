class UsernameValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if value[/master/i]
      object.errors[attribute] << (options[:message] || "Username cannot include master")
    end
  end
end