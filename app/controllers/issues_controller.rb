class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.all
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    unless user_signed_in?
      redirect_to new_user_session_path
    end
    @issue = Issue.new(stop_onestop_id: params[:stop_id], line_onestop_id: params[:line_id])
  end

  # GET /report/a
  def new_a
    file = JSON.parse File.read('lib/assets/issue_static_data.json')
    @location_types = file["location_types"]
    @lines = file["train_lines"]
    @issue_types = file["issue_types"]
    @directions = file["directions"]
    @issue = Issue.new()
  end

  # GET /report/a
  def new_b1
    file = JSON.parse File.read('lib/assets/issue_static_data.json')
    @location_types = file["location_types"]
    @lines = file["train_lines"]
    @issue_types = file["issue_types"]
    @directions = file["directions"]
    @issue = Issue.new()
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)
    if current_user
      @issue.user = current_user
    end

    respond_to do |format|
      if @issue.save
        format.html { redirect_to root_path, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_a
    @issue = Issue.new(issue_params_ab)

    if current_user
      @issue.user_id = current_user.id
    end

    respond_to do |format|
      if verify_recaptcha(model: @issue) && @issue.save
        format.html { redirect_to root_path, notice: 'Issue was successfully submitted.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { redirect_to root_path, notice: 'Captcha failure: Issue was not successfully submitted.' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_b1
    @issue = Issue.create(issue_params_ab)

    if current_user
      @issue.user_id = current_user.id
    end

    respond_to do |format|
      if verify_recaptcha(model: @issue) && @issue.save
        format.html { redirect_to root_path, notice: 'Issue was successfully submitted. Dev note: page two coming soon.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { redirect_to root_path, notice: 'Captcha failure: Issue was not successfully submitted.' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to root_path, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:types, :stop_onestop_id, :line_onestop_id, :description)
    end

    def issue_params_ab
      params.require(:issue).permit(:location_type, :line_onestop_id, :direction, :vehicle_id, :reported_at, :issue_type, :description, :notified, :alt_transport, :cta_contact, :user_id)
    end
end
