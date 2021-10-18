class Admin::UsersController < AdminController
  # before_action :get_user, only: [:show, :edit, :update, :destroy]
  before_action :load_users, only: :index
  load_and_authorize_resource


  def index
    # @users = User.vendor
    # authorize! :index, @users
  end

  def new
    # @user = User.new
  end

  def create
    @user = User.new(user_params.merge(role: 1))
    if @user.save
      flash[:success] = "Vendor was successfully created"
      if current_user.is_admin?
        redirect_to admin_users_path
      else
        # @user.punch(request)
        redirect_to root_path
      end
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Vendor successfully Updated"
      if current_user.is_admin?
        redirect_to admin_users_path
      else
        redirect_to root_path
      end
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = "Vendor Successfully Deleted"
    redirect_to admin_users_path
  end
  private

    def load_users
      @users = User.accessible_by(current_ability)
    end

    def user_params
      params.required(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,
      :username,:contact_details, :category_id, :active, :city_id, :AAA)
    end

    def get_user
      @user = User.find(params[:id])
    end
end
