class Item < ActiveRecord::Base
  belongs_to :event

  validates :event_id, presence: :true
  validates :name, presence: :true

  def whos_bringing_it
    if bringer && bringer != ''
      bringer
    else
      'No on has claimed this item'
    end
  end
end
