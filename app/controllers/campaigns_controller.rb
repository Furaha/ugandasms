class CampaignsController < ApplicationController
  def index
  end

  def new
  	@campaign = Campaign.new
  end

  def create
  	@campaign = Campaign.new(campaign_params)
  	if @campaign.save
  		redirect_to campaigns_path
  	else
  		redirect_to new_campaign_path
  	end  	
  end
  
  private

  def campaign_params
  	params[:campaign][:file].content_type = MIME::Types.type_for(params[:campaign][:file].original_filename).first.content_type
    params.require(:campaign).permit(:file, :title)
  end
end
