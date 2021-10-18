class HomeController < ApplicationController
  def index
    
  end

  def search
    respond_to do |format|
      format.js {
        if params.has_key?(:user_id)
          @user = User.find(params[:user_id])
          @products = @user.products.search_filter(params[:product_category_id])
        else
          @products = Product.search_filter(params[:product_category_id])
        end
      }
      format.html {
        @categories = Category.all
        if params[:q].blank? and params[:location].blank?
          @products = Product.all.paginate(page: params[:page], per_page: 20)
        else
          @products = Product.search(params[:q], params[:location]).paginate(page: params[:page], per_page: 20)
        end
        # @products = User.where(city_id:(params[:city_id])).collect(&:@products).flatten
        @product_categories = ProductCategory.all
        # @product_types = ProductType.all
      }
    end
  end

  def subscribe_user
    @user = SubscriberEmail.create!(email: params["email"])
    flash[:success] = "Email Subscribed sucessfully!"
    render :json => @user
  end

  def update_user
    @user = User.find_by_id(params[:format])
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:error] = "Password not matched!"
      redirect_back(fallback_location: root_path)
    else
      @user.update(password: params[:user][:password])
      flash[:success] = "Password Changed sucessfully!"
      redirect_to new_user_session_path
    end
  end

  def send_email_user
    @user = User.find_by_email(params[:user][:email])
    if @user.present?
      UserMailer.welcome_reset_password_instructions(@user).deliver
      flash[:success] = "Please check your email you will recieve the password reset link."
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "Please check your email you will recieve the password reset link."
      redirect_back(fallback_location: root_path)
    end
  end

end
