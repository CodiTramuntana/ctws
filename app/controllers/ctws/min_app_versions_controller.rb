module Ctws
  class MinAppVersionsController < CtwsController
    before_action :set_min_app_version, only: [:show, :update, :destroy]

    # GET /min_app_version
    def min_app_version     
      json_response MinAppVersion.group(:platform)
    end
    
    # GET /min_app_versions
    def index
      json_response MinAppVersion.all
    end

    # GET /min_app_versions/1
    def show
      json_response @min_app_version
    end

    # POST /min_app_versions
    def create
      @min_app_version = MinAppVersion.create!(min_app_version_params)
      json_response @min_app_version, :created
    end

    # PATCH/PUT /min_app_versions/1
    def update
      @min_app_version.update(min_app_version_params)
      head :no_content
    end

    # DELETE /min_app_versions/1
    def destroy
      @min_app_version.destroy
      head :no_content
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_min_app_version
        @min_app_version = MinAppVersion.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def min_app_version_params
        params.require(:min_app_version).permit(:codename, :description, :platform, :min_version, :store_uri)
      end
  end
end

