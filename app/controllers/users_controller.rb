class UsersController < AdminController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authorized_admin, except: [ :me, :update ]
  
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/me
  def me
    @user = current_user
    render :edit
  end

  
  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url(), notice: I18n.t("model_created", model: User) }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    unless current_user.is_admin? or @user == current_user
      format.html { render :new, status: :access_denied }
      format.json { render json: {'access': 'denied'}, status: :access_denied }
    end
    
    if current_user.is_admin?
      redirect = users_url()
    else
      redirect = profile_path
    end
    
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to redirect, notice:I18n.t("model_updated", model: User) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: I18n.t("model_destroyed", model: User) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      permitted = [:email, :password, :password_confirmation, :full_name, :notifications]
      if current_user.is_admin
        permitted += [:is_admin]
      end
      params.require(:user).permit(permitted)
    end
end
