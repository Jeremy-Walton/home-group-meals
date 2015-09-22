class Item < ActiveRecord::Base
  belongs_to :event

  validates :event_id, presence: :true
  validates :name, presence: :true

  def whos_bringing_it
    if bringer
      user = User.find(bringer)
      user.username || user.email
    else
      'No on has claimed this item'
    end
  end
end
