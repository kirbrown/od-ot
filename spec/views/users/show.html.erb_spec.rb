require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "mystring@mail.com",
      :password => "MyString",
      :password_confirmation => "MyString"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First name:/)
    expect(rendered).to match(/Last name:/)
    expect(rendered).to match(/Email:/)
    expect(rendered).to match(/Password:/)
    expect(rendered).to match(/Password confirmation:/)
  end
end
