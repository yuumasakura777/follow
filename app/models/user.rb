class User < ApplicationRecord

  has_many :posts, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :following


  #フォロワーの取り出し(1対多)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  #フォロワーの取り出し
  has_many :followers, through: :passive_relationships, source: :follower

  has_secure_password

  validates :name, presence:true
  validates :email, presence:true
  validates :password, presence:true

  # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(following_id: other_user.id)
  end

  # ユーザーをアンフォローする
  def unfollow(other_user)
    active_relationships.find_by(following_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

end
