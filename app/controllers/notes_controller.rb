class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    respond_to do |format|
      format.js { @note = Note.find(params[:id]) }
    end
  end

  # GET /notes/new

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = current_user.notes.create()
    @note.color = "purple"
    respond_to do |format|
      if @note.save
        format.html { redirect_to :root }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        # debugger
        format.js { @note = Note.find(params[:id]) }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    respond_to do |format|
      if @note.destroy
        format.html { redirect_to :root }
      end
    end
  end

  def change_color
    @note = Note.find(params[:id])
    @color = params[:color]
    @note.update_attribute(:color, @color)
    @note.save
    respond_to do |format|
      format.js 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:title, :description, :group, :user_id, :color)
    end
end
