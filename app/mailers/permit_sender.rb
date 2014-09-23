class PermitSender < ActionMailer::Base
  default from: "donotreply@homebasefix.com"
  layout 'email' # use views/layouts/email.html.erb as the base layout

  # send the permit email to San Antonio Gov, pass in the user object that contains the user's email address
  def send_permit_application(permit, permit_needs, unique_key)
    @permit = permit
    @permit_needs = permit_needs
    @unique_key = unique_key

    mail( :to => @permit.email,
    :cc => 'sanantonio@codeforamerica.org',
    :subject => 'New permit application has been generated',
    :template_path => 'permit_sender',
    :template_name => 'send_permit_application' )

    mail.attachments['permit.pdf'] = PermitBinaryDetail.find_by filename: "#{unique_key}.pdf"
  end
end