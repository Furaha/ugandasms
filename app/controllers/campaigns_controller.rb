class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      save_or_update_questions(@campaign)
      flash[:success] = "The Campaign has been Successfully created"
      redirect_to campaigns_path
    else
      flash[:danger] = "#{@campaign.errors.full_messages.to_sentence}"
      render :new 
    end   
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update_attributes(campaign_params)
      save_or_update_questions(@campaign)
      flash[:success] = "The Campaign has been Successfully updated"
      redirect_to campaigns_path
    else
      flash[:danger] = "#{@campaign.errors.full_messages.to_sentence}"
      render :edit
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy
    redirect_to campaigns_path
  end
  
  private

  def save_or_update_questions(campaign)
    @data = YAML.load_file(campaign.file.path)
    campaign.questions.destroy_all
    @data.each do |question|
      question.each do |question_title, option_array|
        @question = Question.create(campaign_id: @campaign.id, title: question_title)
        option_array.each do |option_value|
          Option.create(question_id: @question.id, title: option_value)
        end
      end
    end
  end

  def campaign_params
    params[:campaign][:file].content_type = MIME::Types.type_for(params[:campaign][:file].original_filename).first.content_type if (params[:campaign][:file]).present?
    params.require(:campaign).permit(:file, :title)
  end
end
