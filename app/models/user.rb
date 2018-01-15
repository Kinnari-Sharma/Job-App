class User < ApplicationRecord

  before_save { self.email = email.downcase }
  has_many :applieds, dependent: :destroy

  has_many :jobs, dependent: :destroy
  has_many :conversations, foreign_key: :sender_id, dependent: :destroy
  has_many :conversations, foreign_key: :recipent_id, dependent: :destroy
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name,  presence: true, length: { maximum: 50 }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  has_attached_file :resume
  validates_attachment :resume, size: { in: 0..5.megabytes }
  do_not_validate_attachment_file_type :resume

  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  class << self
    def from_omniauth(auth_hash)
      if user = find_by(uid: auth_hash["uid"]) or user = find_by(email: auth_hash["info"]["email"])
        return user
      else
        user = find_or_create_by(uid: auth_hash["uid"])
        user.name = auth_hash["info"]["name"]
        user.email = auth_hash['info']['email']
        user.password = "foobar"
        user.save!
        user
      end
    end
  end

end
