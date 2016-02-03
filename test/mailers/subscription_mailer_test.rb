require 'test_helper'

class SubscriptionMailerTest < ActionMailer::TestCase
  test 'confirm' do
    email = SubscriptionMailer.confirm(subscriptions(:one)).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?

    assert_includes email.to, subscriptions(:one).email
  end
end
