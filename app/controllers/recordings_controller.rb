class RecordingsController < ApplicationController
  before_action :set_recording, only: %i[ show edit update destroy ]

  # GET /recordings or /recordings.json
  def index
    @recordings = current_podcast.recordings
  end

  # GET /recordings/1 or /recordings/1.json
  def show
  end

  # GET /recordings/new
  def new
    @recording = Recording.new
    @recording.recorded_at = Time.now()
  end

  # GET /recordings/1/edit
  def edit
  end

  # POST /recordings or /recordings.json
  def create
    @recording = Recording.new(recording_params)
    @recording.podcast_id = current_podcast.id
    
    respond_to do |format|
      if @recording.save
        format.html { redirect_to recording_url(@recording), notice: I18n.t("model_created", model: Recording) }
        format.json { render :show, status: :created, location: @recording }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordings/1 or /recordings/1.json
  def update
    respond_to do |format|
      if @recording.update(recording_params)
        format.html { redirect_to recording_url(@recording), notice: I18n.t("model_updated", model: Recording) }
        format.json { render :show, status: :ok, location: @recording }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordings/1 or /recordings/1.json
  def destroy
    @recording.destroy

    respond_to do |format|
      format.html { redirect_to recordings_url, notice: I18n.t("model_destroyed", model: Recording) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recording
      @recording = Recording.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recording_params
      params.require(:recording).permit(:speaker, :theme, :recorded_at, :published, :description, :audio_file)
    end
end
