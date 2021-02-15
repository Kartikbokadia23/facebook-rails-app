module UsersHelper
    def friends
      current_user.friends.all
    end
    
    def find_request(user)
      FriendRequest.where('requester_id = ? AND
                     requestee_id = ?',
                      user.id, current_user.id)[0]
    end
  
    def sent_requests
      requests = FriendRequest.includes(:requestee).where('requester_id = ?',
                                     current_user.id)
      return [-1] if requests.nil?
      requests = requests.map { |r| r.requestee }
      requests
    end
  
    def received_requests
      requests = FriendRequest.includes(:requester).where('requestee_id = ?',
                                     current_user.id)
      return [-1] if requests.nil?
      requests = requests.map { |r| r.requester }
      requests
    end
  
    def friend_request_list
      requests = FriendRequest.includes(:requester).where(requestee_id: current_user.id).limit(5)
      requests
    end
  end