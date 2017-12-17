# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/acceptance_mail
  def acceptance_mail
    user = User.third
    job = Job.find(51)
    UserMailer.acceptance_mail(user, job)
  end

end
