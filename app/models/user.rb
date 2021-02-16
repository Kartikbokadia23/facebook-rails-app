class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :posts, dependent: :destroy

  has_many :received_friend_requests, 
            class_name: 'FriendRequest', 
            foreign_key: :requestee_id,
            dependent: :destroy

  has_many :sent_friend_requests, 
            class_name: 'FriendRequest', 
            foreign_key: :requester_id,
            dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy


  after_create :send_welcome_email

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
    #UserMailer.with(user: @user).welcome_email.deliver_now
  end
end
