class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.acceptance_mail.subject
  #
  def acceptance_mail(user, job)
    @user = user
    @job = job

    mail to: user.email, subject: "Job Interview for #{@job.cname}"
  end
end
