class PermitSender < ActionMailer::Base
  default from: "donotreply@homebasefix.com"
  layout 'email' # use views/layouts/email.html.erb as the base layout

  # send the permit email to San Antonio Gov, pass in the user object that contains the user's email address
  def send_permit_application(permit, permit_needs)
    @permit = permit
    @permit_needs = permit_needs

    mail( :to => @permit.email,
    :subject => 'This is a test email, this is a test',
    :template_path => 'permit_sender',
    :template_name => 'send_permit_application' )
  end
end
