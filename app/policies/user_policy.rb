class UserPolicy < ApplicationPolicy
  def owner?
    user == record
  end
end
