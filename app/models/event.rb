class Event < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :user_id, presence: :true
  validates :name, presence: :true
  validates :date, presence: :true
  validates :description, presence: :true
end
