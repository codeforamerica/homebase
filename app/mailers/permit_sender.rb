class PermitSender < ActionMailer::Base
  default from: "donotreply@homebasefix.com"

  # send the permit email to San Antonio Gov, pass in the user object that contains the user's email address
  def send_permit_application(user)
    @permit = permit
    mail( :to => @permit.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end
end
