module ApplicationHelper
  def sweet_alert_title(symbol)
    return 'Success' if symbol == :success
    return 'Info' if symbol == :info
    return 'Error' if symbol == :error
    return 'Input' if symbol == :input
    'Warning'
  end

  def cart_button(item, user)
  	if user.try(:client?) && item.user_id != user.try(:id)
			if !item.already_chosen? && item.status != 'sold'
				link_to 'Add To Cart', add_to_cart_path(id: item.id), method: 'POST',
            		class: 'btn btn-primary pull-right'
			elsif @item.possible_buyer == current_user
				link_to 'Delete From Cart', delete_from_cart_path(id: item.id), method: 'POST',
            		class: 'btn btn-primary pull-right'
			else
				button_tag type: 'button', 
									 class: "btn btn-sm btn-warning pull-right disabled_button" do
				  'Unavailable'
				end
			end
		end
  end
end
