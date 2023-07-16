class Article < ApplicationRecord
  before_save :generate_slug

  validates :title, :description, :body, presence: true
  validates :title, uniqueness: true, on: :create

  belongs_to :user 
  has_and_belongs_to_many :users


  def as_json(options = {}, current_user = nil)
    super(options.merge(except: [:id, :user_id])).merge({
      author: user,
      favorited: (users.include? current_user),
      favoritesCount: users.count,
      tagList: tags.pluck(:name)
    })
  end

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
