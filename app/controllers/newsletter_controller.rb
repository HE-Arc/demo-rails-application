class NewsletterController < ApplicationController
  def subscribe
    sub = Subscription.with_deleted.find_by_email(params[:email])

    if sub.nil?
      sub = Subscription.create(params.permit(:email))
      if sub.id.nil?
        flash.alert = "Cannot subscribe using `#{params[:email]}`."
        return redirect_to :back
      end
    else
      if sub.deleted?
        sub.restore
      else
        flash.alert = "Cannot subscribe, this email `#{params[:email]}` is probably already in."
        return redirect_to :back
      end
    end

    SubscriptionMailer.confirm(sub).deliver_now

    flash.notice = "Thanks for your subscription #{params[:email]}!"
    redirect_to :back
  end

  def confirm
    raise NotImplementedError
  end
end
