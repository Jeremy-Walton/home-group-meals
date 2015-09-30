class EventsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @events = Event.all.order(:created_at).reverse
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.events.build

    respond_to do |format|
      format.html { redirect_to events_path }
      format.js { render 'event_modal' }
    end
  end

  def edit
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html { redirect_to events_path }
      format.js { render 'event_modal'}
    end
  end

  def create
    @event = current_user.events.build params_for_event

    respond_to do |format|
      if @event.save
        flash.notice = "#{@event.name} Saved"
        format.js { render inline: "location.reload();" }
      else
        format.js { render 'event_errors' }
      end
    end
  end

  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes params_for_event
        flash.notice = "#{@event.name} Saved"
        format.js { render inline: "location.reload();" }
      else
        format.js { render 'modal_errors' }
      end
    end
  end

  def destroy
    event = Event.find(params[:id])

    if event.user == current_user
      event.destroy
      redirect_to events_path, notice: "Successfully deleted #{event.name}"
    else
      redirect_to events_path, notice: "You do not have permission to delete this event"
    end
  end

  private

  def params_for_event
    params.require(:event).permit(:user_id, :name, :description, :date)
  end
end
