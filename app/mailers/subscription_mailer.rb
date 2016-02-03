class SubscriptionMailer < ApplicationMailer
  def confirm(subscription)
    @user = subscription
    @url = url_for(controller: :newsletter,
                   action: :confirm,
                   id: subscription.id,
                   email: subscription.email)
    @subject = 'Subscription to Admin'

    mail to: subscription.email, subject: @subject
  end
end
