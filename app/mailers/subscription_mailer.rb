class SubscriptionMailer < ApplicationMailer
  def confirm(subscription)
    @email = subscription.email
    @url = url_for(controller: :newsletter,
                   action: :confirm,
                   id: subscription.id,
                   email: subscription.email)
    @subject = 'Subscription to Admin'

    mail to: @email, subject: @subject
  end
end
