class Subscription < ActiveRecord::Base
  acts_as_paranoid
  validates :email, presence: true, uniqueness: true

  rails_admin do
    list do
      scopes [nil, 'deleted']
    end
  end
end
