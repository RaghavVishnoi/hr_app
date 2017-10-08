class LeaveResponsesController < ApplicationController
  before_action :set_leave_response, only: [:show, :edit, :update, :destroy]

  # GET /leave_responses
  # GET /leave_responses.json
  def index
    @leave_responses = LeaveResponse.all
  end

  # GET /leave_responses/1
  # GET /leave_responses/1.json
  def show
  end

  # GET /leave_responses/new
  def new
    @leave_response = LeaveResponse.new
  end

  # GET /leave_responses/1/edit
  def edit
  end

  # POST /leave_responses
  # POST /leave_responses.json
  def create
    @leave_response = LeaveResponse.new(leave_response_params)

    respond_to do |format|
      if @leave_response.save
        format.html { redirect_to @leave_response, notice: 'Leave response was successfully created.' }
        format.json { render :show, status: :created, location: @leave_response }
      else
        format.html { render :new }
        format.json { render json: @leave_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leave_responses/1
  # PATCH/PUT /leave_responses/1.json
  def update
    respond_to do |format|
      if @leave_response.update(leave_response_params)
        format.html { redirect_to @leave_response, notice: 'Leave response was successfully updated.' }
        format.json { render :show, status: :ok, location: @leave_response }
      else
        format.html { render :edit }
        format.json { render json: @leave_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leave_responses/1
  # DELETE /leave_responses/1.json
  def destroy
    @leave_response.destroy
    respond_to do |format|
      format.html { redirect_to leave_responses_url, notice: 'Leave response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave_response
      @leave_response = LeaveResponse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leave_response_params
      params.fetch(:leave_response, {})
    end
end
