# frozen_string_lieral: true

# Client represents a client entity with an id, name, and email.
class Client
  attr_reader :id, :name, :email

  def initialize(id, name, email)
    @id = id
    @name = name
    @email = email
  end

  def full_name_with_email
    "#{name} (#{email})"
  end
end
