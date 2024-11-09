# frozen_string_literal: true

class Client::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def after_sign_in_path_for(resource)
    client_homepage_index_path
  end

  def new
    cookies[:promoter] = params[:promoter]
    super
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      redirect_to client_homepage_index_path
    else
      clean_up_passwords resource
      set_minimum_password_length
      if resource.errors.any?
        flash[:alert] = resource.errors.full_messages.to_sentence
      end
      
      redirect_to edit_client_user_registration_path
    end
  end
  
  protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :parent_id])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone, :username, :image])
  end
end
