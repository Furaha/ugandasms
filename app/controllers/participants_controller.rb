class ParticipantsController < ApplicationController

  def index
    @participants = Participant.all 
  end

  def new   
  end

  def create
    begin
      Participant.import(params[:file])
      redirect_to participants_path, notice: "Products imported."
    rescue
      redirect_to participants_path, notice: "Invalid CSV file format."
    end
  end

  def edit
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
  end
end
