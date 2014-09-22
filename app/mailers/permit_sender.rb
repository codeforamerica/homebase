class PermitSender < ActionMailer::Base
  default from: "donotreply@homebasefix.com"

  # send the permit email to San Antonio Gov, pass in the user object that contains the user's email address
  def send_permit_application(permit)
    @permit = permit
    mail( :to => @permit.email,
    :subject => 'This is a test email, this is a test' )
  end
end
