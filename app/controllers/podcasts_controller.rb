class PodcastsController < AdminController
  before_action :set_podcast, only: %i[ show edit update destroy ]
  before_action :authorized_admin, except: [ :current, :update ]
  
  # GET /podcasts or /podcasts.json
  def index
    @podcasts = Podcast.all
  end

  # GET /podcasts/1 or /podcasts/1.json
  def show
  end

  # GET /podcasts/new
  def new
    @podcast = Podcast.new
  end

  # GET /podcasts/1/edit
  def edit
  end

  def current
    unless current_role == 'manager'
      raise ApplicationController::NotAuthorized
    end
    @podcast = current_podcast
    render :edit
  end

  # POST /podcasts or /podcasts.json
  def create
    @podcast = Podcast.new(podcast_params)

    respond_to do |format|
      if @podcast.save
        format.html { redirect_to podcast_url(@podcast), notice: I18n.t("model_created", model: Podcast) }
        format.json { render :show, status: :created, location: @podcast }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /podcasts/1 or /podcasts/1.json
  def update
    unless current_user.is_admin? || (current_role == 'manager' && current_podcast == @podcast)
      format.html { render :new, status: :access_denied }
      format.json { render json: {'access': 'denied'}, status: :access_denied }
    end
    if current_user.is_admin?
      redirect = podcast_url(@podcast)
    else
      redirect = current_podcast_path
    end
    respond_to do |format|
      if @podcast.update(podcast_params)
        format.html { redirect_to redirect, notice: I18n.t("model_updated", model: Podcast) }
        format.json { render :show, status: :ok, location: @podcast }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /podcasts/1 or /podcasts/1.json
  def destroy
    @podcast.destroy

    respond_to do |format|
      format.html { redirect_to podcasts_url, notice: I18n.t("model_destroyed", model: Podcast) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_podcast
      @podcast = Podcast.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def podcast_params
      params.require(:podcast).permit(:name, :shortname, :website, :copyright, :max_recordings, :author, :email, :description, :language, :keywords, :image_file, :explicit, :category)
    end
end
