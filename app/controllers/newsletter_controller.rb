class NewsletterController < ApplicationController
  def subscribe
    Subscription.with_deleted do
      @sub = Subscription.find_by_email(params[:email])
    end

    unless @sub
      @sub = Subscription.create(params.permit(:email))
      unless @sub.id?
        flash.alert = "Cannot subscribe using `#{params[:email]}`."
        return redirect_back(fallback_location: :root)
      end
    else
      if @sub.deleted?
        @sub.soft_undelete!
      else
        flash.alert = "Cannot subscribe, this email `#{params[:email]}` is probably already in."
        return redirect_back(fallback_location: :root)
      end
    end

    SubscriptionMailer.confirm(@sub).deliver_later

    flash.notice = "Thanks for your subscription #{params[:email]}!"
    redirect_back(fallback_location: :root)
  end

  def confirm
    raise NotImplementedError
  end
end
