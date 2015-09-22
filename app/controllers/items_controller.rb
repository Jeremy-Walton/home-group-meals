class ItemsController < ApplicationController
    before_filter :setup_instance_variable

  def new
    @item = @event.items.build

    respond_to do |format|
      format.html { redirect_to [@event] }
      format.js { render 'item_modal' }
    end
  end

  def create
    @item = @event.items.build params_for_item

    respond_to do |format|
      if @item.save
        flash.notice = "#{@item.name} Saved"
        format.js { render inline: "location.reload();" }
      else
        format.js { render 'item_errors' }
      end
    end
  end

  def set_bringer
    @item = Item.find(params[:id])
    @item.update_attributes(bringer: current_user.id)

    if @item.save
      flash.notice = "#{@item.name} Saved"
    end
    redirect_to [@event]
  end

  def unset_bringer
    @item = Item.find(params[:id])
    @item.update_attributes(bringer: nil)

    if @item.save
      flash.notice = "#{@item.name} Saved"
    end
    redirect_to [@event]
  end

  def destroy
    item = Item.find(params[:id])

    if item.event.user == current_user
      item.destroy
      redirect_to [@event], notice: "Successfully deleted #{item.name}"
    else
      redirect_to [@event], notice: "You do not have permission to delete this item"
    end
  end

  private

  def params_for_item
    params.require(:item).permit(:event_id, :name)
  end

  def setup_instance_variable
    @event = Event.find(params[:event_id])
  end
end
