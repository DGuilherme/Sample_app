class Micropost < ApplicationRecord
  belongs_to :user
<<<<<<< HEAD
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
=======
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
>>>>>>> f9bea67d04cef1c6b899876c439cbc707f5fef61
end
