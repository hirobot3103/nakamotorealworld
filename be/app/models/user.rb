class User < ApplicationRecord
  require 'securerandom'

  # パスワード管理されたデータ作成
  has_secure_password
  
  validates :username, :email, :password, presence: true
  validates :email, :username, uniqueness: true, on: :create
  has_many :articles, dependent: :destroy

  def as_json(options = {})
    super(options.merge(only: [:email, :username, :bio, :image]))
  end
end
