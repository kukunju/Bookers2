class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }


  has_many :books, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #（親）する人follower→中間relationship→される人followed　　フォローするUser側から見たされるUserとの関係
  has_many :follower_relationships,class_name:"Relationship", foreign_key: :follower_id, dependent: :destroy
  #中間を使って「followed」モデルのUser（された側）を集めることを「followers」と定義する 自分がフォローした人を集める
  has_many :follows, through: :follower_relationships, source: :followed


  #（親）される人followerd→中間relationship→する人follower　　フォローされるUser側から見たするUserとの関係
  has_many :followed_relationships,class_name:"Relationship", foreign_key: :followed_id, dependent: :destroy
  #中間を使って「follower」モデルのUser（した側）を集めることを「followerds」と定義する　自分をフォローしてる人を集める
  has_many :followers, through: :followed_relationships, source: :follower



  def get_profile_image(width, height)
   unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_profile_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def followed_by?(user)
   followed_relationships.find_by(follower_id: user.id).present?
  end

  def self.looks(search,werd)
   if search =="perfect_match"
    @users = User.where("name LIKE?","#{werd}")
   elsif search == "forward_match"
    @users = User.where("name LIKE?","%#{werd}")
   elsif search == "backword_match"
    @users = User.where("name LIKE?","#{werd}%")
   elsif search == "partial_match"
    @users = User.where("name LIKE?","%#{werd}%")
  else
    @users = User.all
  end
 end

end
