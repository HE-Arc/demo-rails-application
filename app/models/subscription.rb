class Subscription < ActiveRecord::Base
  has_soft_deletion default_scope: true

  validates :email, presence: true, uniqueness: true

  #rails_admin do
  #  list do
  #    scopes [nil, 'deleted']
  #  end
  #end
end
