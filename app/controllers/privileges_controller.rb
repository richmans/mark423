class PrivilegesController < ApplicationController
  before_action :set_privilege, only: %i[ show edit update destroy ]
  before_action :set_podcast
 
  # GET /privileges or /privileges.json
  def index
    @privileges = @podcast.privileges
  end

  # GET /privileges/1 or /privileges/1.json
  def show
  end

  # GET /privileges/new
  def new
    @privilege = Privilege.new
  end

  # GET /privileges/1/edit
  def edit
  end

  # POST /privileges or /privileges.json
  def create
    @privilege = Privilege.new(privilege_params)

    respond_to do |format|
      if @privilege.save
        format.html { redirect_to podcast_privilege_url(@podcast, @privilege), notice: I18n.t("model_created", model: Privilege) }
        format.json { render :show, status: :created, location: @privilege }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @privilege.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /privileges/1 or /privileges/1.json
  def update
    respond_to do |format|
      if @privilege.update(privilege_params)
        format.html { redirect_to podcast_privilege_url(@podcast, @privilege), notice: I18n.t("model_updated", model: Privilege) }
        format.json { render :show, status: :ok, location: @privilege }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @privilege.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /privileges/1 or /privileges/1.json
  def destroy
    @privilege.destroy

    respond_to do |format|
      format.html { redirect_to podcast_privileges_url(@podcast), notice: I18n.t("model_destroyed", model: Privilege) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_privilege
      @privilege = Privilege.find(params[:id])
    end

    def set_podcast
      @podcast = Podcast.find(params[:podcast_id])
    end

    # Only allow a list of trusted parameters through.
    def privilege_params
      params.require(:privilege).permit(:user_id, :podcast_id, :role)
    end
end
