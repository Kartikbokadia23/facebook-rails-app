class FriendshipsController < ApplicationController
    def create
      @friend_request = FriendRequest.find_by(id: params[:friend_request])
      @friend_request.accept
      redirect_to request.referrer
    end
  
    def destroy
      friendship = Friendship.where('user_id = ? AND
                                      friend_id = ?',
                                      current_user.id, params[:id])[0]
      if friendship.destroy
        redirect_to root_url
      else
        redirect_to root_url
      end
    end
  
  end