require 'test_helper'

class NewsletterControllerTest < ActionController::TestCase
  include ActiveJob::TestHelper

  test 'subscription of new user succeeds' do
    assert_enqueued_jobs 1 do
      post :subscribe, params: { email: 'john.john@example.org' }
    end

    assert_not_nil flash[:notice]
    assert_nil flash[:alert]
    assert_redirected_to '/'

    assert_not_nil Subscription.find_by_email('john.john@example.org')
  end

  test 'subscription of empty email fails' do
    assert_enqueued_jobs 0 do
      post :subscribe, params: { email: '' }
    end

    assert_nil flash[:notice]
    assert_not_nil flash[:alert]
    assert_redirected_to '/'
  end

  test 'subscription of existing user fails' do
    assert_enqueued_jobs 0 do
      post :subscribe, params: { email: subscriptions(:one).email }
    end

    assert_nil flash[:notice]
    assert_not_nil flash[:alert]
    assert_redirected_to '/'
  end

  test 'subscription of deleted user succeeds' do
    subscriptions(:two).soft_delete

    assert_enqueued_jobs 1 do
      post :subscribe, params: { email: subscriptions(:two).email }
    end

    assert_not_nil flash[:notice]
    assert_nil flash[:alert]
    assert_redirected_to '/'

    assert_not Subscription.find(subscriptions(:two).id).deleted?
  end

end
