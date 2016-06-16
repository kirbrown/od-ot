class Notifier < ApplicationMailer

  def password_reset(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>",
         subject: 'Reset your password in Od-ot.')
  end

  def todo_list(todo_list, destination)
    @user = todo_list.user
    @todo_list = todo_list
    mail(to: "#{@user.first_name} #{@user.last_name} <#{destination}>",
         subject: "#{@user.first_name} #{@user.last_name} sent you a todo list from Od-ot.")
  end

end
