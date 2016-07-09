require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  test "nominal case" do
    sub = Subscription.create(email: "john.john@example.org")

    assert_not_nil sub.id
    assert_nil sub.deleted_at
  end

  test "soft deletion" do
    sub = subscriptions(:one)

    assert_nil sub.deleted_at
    sub.soft_delete
    assert sub.deleted?
    assert_not_nil sub.deleted_at

    assert_nil Subscription.find_by_id(sub.id)
    Subscription.with_deleted do
      assert_not_nil Subscription.find_by_id(sub.id)
    end

    sub.soft_undelete!
    assert_nil sub.deleted_at
  end

  test "email is required" do
    sub = Subscription.create()

    assert_nil sub.id
  end

  test "email is unique" do
    sub = Subscription.create(email: subscriptions(:one).email)

    assert_nil sub.id
  end
end
