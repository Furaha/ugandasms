class ParticipantsController < ApplicationController

  def index
    @participants = Participant.all 
  end

  def new   
  end

  def create
    begin
      Participant.import(params[:file])
      redirect_to participants_path, notice: "Phone Numbers imported."
    rescue
      render :new , notice: "Invalid CSV file format."
    end
  end

  def edit
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
    if @participant.update_attributes(participant_params)
      redirect_to participants_path
    else
      render :new
    end
  end

  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy
    redirect_to participants_path
  end

  private

  def participant_params
    params.require(:participant).permit(:number)
  end
end
