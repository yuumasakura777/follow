class User < ApplicationRecord

  has_many :posts, dependent: :destroy

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  has_secure_password

  validates :name, presence:true
  validates :email, presence:true
  validates :password, presence:true

  # フォローしようとしているユーザーが自分自身ではないか検証
  def follow(other_user)
    unless self==other_user
      relationship=self.relationships.find_by(follow_id: other_user.id)
    end
  end

  # フォローがあればアンフォロー
  def unfollow(other_user)
    relationship=self.relationships.find_by(follow_id: other_user.id)
    relationships.destroy if relationship
  end

  # other_userが含まれているかどうか(含まれている場合true、含まれていない場合false)
  def following?(other_user)
    self.followings.include?(other_user)
  end

end
