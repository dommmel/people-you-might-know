class Friendship < ActiveRecord::Base
  belongs_to :friend, :class_name => 'User'
  belongs_to :user
end
