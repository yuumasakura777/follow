class Relationship <

  #active_relationshipsと対
  belongs_to :follower, class_name: "User"
  #passive_relationshipsと対
  belongs_to :following, class_name: "User"

  validates :user_id, presence: true
  validates :follow_id, presence: true
end
