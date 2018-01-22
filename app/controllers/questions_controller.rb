class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    @exam = @question.exam
  end

  def start
    @exam = Exam.find(params[:exam_id])
    if current_employee.results.find_by(exam: @exam) 
      return redirect_to exams_path
    end
    
    @result = current_employee.results.build(exam: @exam)
    if @result.started_at.nil?
      @result.started_at = DateTime.now
      @result.completed_at = @result.started_at + @exam.time.minute 
    end
    @result.save!
    @questions = @exam.questions
    if @result.completed_at < DateTime.now
      flash[:alert] = "Exam Completed"
      redirect_to  exams_path 
    end
  end

  def complete
    @exam = Exam.find(params[:exam_id])
    @result = @exam.results.find_by(employee: current_employee)
    @result_update = @result.update_attributes(completed_at: Time.zone.parse(String(DateTime.now)))
    result_receivers = @result.exam.result_receivers
    if result_receivers.present?
      receivers = Employee.where(id: result_receivers.pluck(:receiver_id))
      ResultMailer.send_result(@result,receivers,current_employee).deliver_now
    end
    flash[:alert] = "Exam Completed"
  end

  def save_ans_by_teacher
    @question = Question.find(params[:q_id])
    @sr = Response.find_or_create_by(employee: params[:employee_id], question_id: @question.id)
    @sr.update!(correct_ans: true)
    response = Response.where(question_id: @question.id, employee_id: params[:employee_id])
    @exam = @question.exam
    @result = @exam.results.find_by(employee: params[:employee_id]).update(correct_ans: response.select {|ans| ans.correct_ans }.count, incorrect_ans: response.select {|ans| !ans.correct_ans }.count )
    
    respond_to do |format|
      format.js
    end
  end

  def save_ans
    @question = Question.find(params[:q_id])
    sr = Response.find_or_create_by(employee: current_employee, question_id: @question.id)
    sr.update!(correct_ans: (@question.answer == params[:answer]), answer: params[:answer])

    @exam = @question.exam

    if @exam.questions.last.id == @question.id
      response = current_employee.responses.joins(question: :exam).where("exam_id = ?", @exam)
      Result.find_by(employee_id: current_employee.id, exam_id: @exam.id).update(correct_ans: response.select {|ans| ans.correct_ans }.count, incorrect_ans: response.select {|ans| !ans.correct_ans }.count )
      @redirect = 'dashboard'
    end

    respond_to do |format|
      format.js
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    # params[:question][:options] = params[:question][:options].to_s
    @question = Question.new(question_params)
    @questions = @question.exam.questions
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.js 
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.js
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:exam_id, :question, :description, :question_type, :answer, options: params[:question][:options].keys)
    end
end
