class FriendRequest < ApplicationRecord
    belongs_to :requester, class_name: 'User'
    belongs_to :requestee, class_name: 'User'
  
    #validates :requestee, uniqueness: { scope: :requester }
  
    def self.accept
      requestee.friends << requester
      requester.friends << requestee
      self.destroy
    end
  
    def self.decline
      self.destroy
    end
end
