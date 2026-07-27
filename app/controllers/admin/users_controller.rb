module Admin
  class UsersController < BaseController
    before_action :require_admin
    before_action :set_user, only: [ :edit, :update, :destroy ]

    def index
      @users = User.order(:email_address)
    end

    def new
      @user = User.new(role: "content_manager")
    end

    def create
      @user = User.new(user_params)
      if @user.password.blank?
        @user.errors.add(:password, "can't be blank")
        flash.now[:alert] = @user.errors.full_messages.to_sentence
        render :new, status: :unprocessable_entity
      elsif @user.save
        redirect_to admin_users_path, notice: "User #{@user.email_address} created as #{User::ROLES[@user.role].split(" — ").first}."
      else
        flash.now[:alert] = @user.errors.full_messages.to_sentence
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      attrs = user_params
      # Blank password fields mean "keep the current password".
      attrs = attrs.except(:password) if attrs[:password].blank?

      if @user.last_admin? && attrs[:role].present? && attrs[:role] != "admin"
        flash.now[:alert] = "#{@user.email_address} is the only admin — assign another admin before changing this role."
        render :edit, status: :unprocessable_entity
      elsif @user.update(attrs)
        changed_pw = attrs.key?(:password)
        redirect_to admin_users_path,
          notice: "User #{@user.email_address} saved#{changed_pw ? " — password reset" : ""}."
      else
        flash.now[:alert] = @user.errors.full_messages.to_sentence
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @user == current_user
        redirect_to admin_users_path, alert: "You can't delete your own account while signed in."
      elsif @user.last_admin?
        redirect_to admin_users_path, alert: "#{@user.email_address} is the only admin and can't be deleted."
      else
        @user.destroy
        redirect_to admin_users_path, notice: "User #{@user.email_address} deleted."
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email_address, :password, :role)
    end
  end
end
