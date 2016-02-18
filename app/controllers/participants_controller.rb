class ParticipantsController < ApplicationController

  def index
    @participants = Participant.all 
  end

  def new   
  end

  def create
    begin
      Participant.import(params[:file])
      flash[:success] = "Phone Numbers imported"
      redirect_to participants_path
    rescue
      flash[:danger] = "Invalid CSV file format"
      render :new 
    end
  end

  def edit
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
    if @participant.update_attributes(participant_params)
      flash[:success] = "Successful Update"
      redirect_to participants_path
    else
      flash[:danger] = "#{@participant.errors.full_messages.to_sentence}"
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
