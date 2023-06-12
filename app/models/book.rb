class Book < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_desc, -> {order(star: :desc)}


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def self.looks(search,werd)
   if search =="perfect_match"
    @books = Book.where("title LIKE?","#{werd}")
     elsif search == "forward_match"
      @books = Book.where("title LIKE?","%#{werd}")
     elsif search == "backword_match"
      @books = Book.where("title LIKE?","#{werd}%")
     elsif search == "partial_match"
      @books = Book.where("title LIKE?","%#{werd}%")
    else
     @books = Book.all
   end
  end

  def self.tag_looks(werd)
   @books = Book.where("tag LIKE?","#{werd}")
  end

end
