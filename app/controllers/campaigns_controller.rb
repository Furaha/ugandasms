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
      @data = YAML.load_file(@campaign.file.path)
      @data.each do |question|
        question.each do |question_title, option_array|
          @question = Question.create(campaign_id: @campaign.id, title: question_title)
          option_array.each do |option_value|
            Option.create(question_id: @question.id, title: option_value)
          end
        end
      end
      redirect_to campaigns_path
    else
      redirect_to new_campaign_path
    end   
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private

  def campaign_params
    params[:campaign][:file].content_type = MIME::Types.type_for(params[:campaign][:file].original_filename).first.content_type
    params.require(:campaign).permit(:file, :title)
  end
end
