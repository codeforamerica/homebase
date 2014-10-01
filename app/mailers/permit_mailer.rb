class PermitMailer < ActionMailer::Base
  default from: "donotreply@homebasefix.com"
  layout 'email' # use views/layouts/email.html.erb as the base layout

  # send the permit email to San Antonio Gov, pass in the user object that contains the user's email address
  def send_permit_application(permit, permit_needs, unique_key)
    @permit = permit
    @permit_needs = permit_needs
    @unique_key = unique_key

    permit_binary_detail = PermitBinaryDetail.find_by filename: "#{unique_key}.pdf"
    mail.attachments['permit.pdf'] = {  :mime_type => permit_binary_detail.content_type,
                                        :content => permit_binary_detail.binary.data }

    mail( :to => @permit.email,
    #:cc => 'sanantonio@codeforamerica.org',
    :subject => I18n.t('mailers.permit_mailer.subject'),
    :template_path => 'permit_mailer',
    :template_name => 'send_permit_application' )
                                    
  end
end
