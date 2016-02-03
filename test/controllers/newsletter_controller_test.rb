require 'test_helper'

class NewsletterControllerTest < ActionController::TestCase
  include ActiveJob::TestHelper

  test 'subscription of new user succeeds' do
    assert_enqueued_jobs 1 do
      @request.headers['HTTP_REFERER'] = 'http://www.example.org/'
      post :subscribe, email: 'john.john@example.org'
    end

    assert_not_nil flash[:notice]
    assert_nil flash[:alert]
    assert_redirected_to :back

    assert_not_nil Subscription.find_by_email('john.john@example.org')
  end

  test 'subscription of empty email fails' do
    assert_enqueued_jobs 0 do
      @request.headers['HTTP_REFERER'] = 'http://www.example.org/'
      post :subscribe, email: ''
    end

    assert_nil flash[:notice]
    assert_not_nil flash[:alert]
    assert_redirected_to :back
  end

  test 'subscription of existing user fails' do
    assert_enqueued_jobs 0 do
      @request.headers['HTTP_REFERER'] = 'http://www.example.org/'
      post :subscribe, email: subscriptions(:one).email
    end

    assert_nil flash[:notice]
    assert_not_nil flash[:alert]
    assert_redirected_to :back
  end

  test 'subscription of deleted user succeeds' do
    subscriptions(:two).destroy

    assert_enqueued_jobs 1 do
      @request.headers['HTTP_REFERER'] = 'http://www.example.org/'
      post :subscribe, email: subscriptions(:two).email
    end

    assert_not_nil flash[:notice]
    assert_nil flash[:alert]
    assert_redirected_to :back

    assert_nil Subscription.find(subscriptions(:two).id).deleted_at
  end

end
