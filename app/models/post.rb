class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments

  validates :title, presence: true
  validates :body, presence: true
  validate :must_have_at_least_one_tag


  private

  def must_have_at_least_one_tag
    errors.add(:tags, "must have at least one tag") if tags.empty?
  end
end
