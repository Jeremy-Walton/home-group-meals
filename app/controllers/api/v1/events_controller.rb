class Api::V1::EventsController < Api::V1::BaseController
  def index
    render(json: Event.all.to_json)
  end

  def show
    event = Event.find(params[:id])
    items = JSON.parse(event.items.to_json).each do |item|
      item[:event_name] = event.name
    end
    render(json: items)
  end
end
