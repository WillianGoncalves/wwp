class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_group

  def current_group
    @current_group ||= current_user&.last_group
  end

  def after_sign_in_path_for(user)
    return groups_path if user.last_group.nil?
    group_path(user.last_group)
  end

  def require_group_admin(group)
    return if current_user.is_admin_of?(group)

    respond_to do |format|
      format.html do
        flash[:alert] = I18n.t('messages.admin_required')
        redirect_to root_path
      end

      format.json do
        render json: { message: I18n.t('messages.admin_required') }, status: :bad_request
      end
    end
  end

  def require_group_member(group)
    return if current_user.is_member_of?(group)

    respond_to do |format|
      format.html do
        flash[:alert] = I18n.t('messages.member_required')
        redirect_to root_path
      end

      format.json do
        render json: { message: I18n.t('messages.member_required') }, status: :bad_request
      end
    end
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar])
  end
end
