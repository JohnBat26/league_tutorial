class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :update, :destroy]

  before_filter :intercept_html_requests

  layout false

  respond_to :json

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
    render json: @teams
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    render json: @team
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    if @team.save
      render json: @team, status: :created, location: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    if @team.update_attributes(params[:team])
      head :no_content
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    head :no_content
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:club_id, :name, :captain, :date_created)
  end

  def intercept_html_requests
    redirect_to('/') if request.format == Mime::HTML
  end

end
