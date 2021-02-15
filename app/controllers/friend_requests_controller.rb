class FriendRequestsController < ApplicationController
    def create
      request = current_user.sent_friend_requests.build(
                                                  requestee_id: params[:user_id]
                                                  )
      if request.save
        flash.notice = 'Friend Request sent'
      else
        flash.notice = 'We done messed up'
      end
  
      if params[:path] == "/users"
        back = users_path
      else
        back = user_path(params[:user_id])
      end
      redirect_to back
    end
  
    def destroy
      friend_request = FriendRequest.find_by(id: params[:id])
      friend_request.decline
      redirect_to request.referrer
    end
  end