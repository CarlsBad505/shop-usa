class ApplicationMailer < ActionMailer::Base
  include SendGrid

  default from: 'from@courierusallc.com'
  layout 'mailer'
end
