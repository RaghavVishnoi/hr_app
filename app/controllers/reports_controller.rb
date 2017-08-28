require "csv"

class ReportsController < ApplicationController
  def index
  end

  def team_comparision
  end

  def employee_report
  end

  def employee_report_show
    @project_id = params[:report][:project_id]
    @selected_start_date =  params[:start_date][:start_date].to_date.beginning_of_day if params[:start_date][:start_date].present?
    @selected_end_date =  params[:end_date][:end_date].to_date.end_of_day if params[:end_date][:end_date].present?
    @project = Project.find(@project_id)
    @project_team_id = @project.assigned_to
    @project_team = ProjectTeam.find(@project_team_id)
    @project_team_members = @project_team.project_team_members

    respond_to do |format|
      format.js 
    end

  end

  def team_highest_score
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Exam & Team')
    data_table.new_column('number', 'Highest Marks')

    data_table.add_rows(Result.all.group_by(&:exam_id).count)

    Result.where("created_at > ?", 1.years.ago).group_by(&:exam_id).map { |id, results| results.max_by(&:correct_ans) }.each_with_index do |result, index|
      data_table.set_cell(index, 0, "#{result.exam.title} from Team  #{result.exam.team.name}")
      data_table.set_cell(index, 1, result.correct_ans)
    end

    opts   = { :width => 400, :height => 240, :title => 'Exams With highest Score', :hAxis => { :title => 'Exam with Team', :titleTextStyle => { :color => '#3377dd' } }, colors: ['#1B9E77', '#D95F02'], vAxis: { title: "Score", :titleTextStyle => { :color => '#44dd88' } } }
    @chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)    
  end

  def attemted_vs_passed
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Exam & Team')
    data_table.new_column('number', 'Attemted Employees')
    data_table.new_column('number', 'Passed Employees')
    data_table.add_rows(Result.all.group_by(&:exam_id).count)

    Exam.joins(:results).where("results.created_at > ?", 1.years.ago).where.not(results: {exam_id: nil}).uniq.each_with_index do |exam, index|
      data_table.set_cell(index, 0, "#{exam.title} From Team #{exam.team.name}")
      data_table.set_cell(index, 1, exam.results.count)
      data_table.set_cell(index, 2, exam.results.select{ |result| (result.correct_ans >= exam.cut_off_marks.to_f) }.count )
    end

    opts   = { :width => 400, :height => 240, :title => 'Attemted Employees vs Passed Employees', :legend => 'bottom', colors: ["#4285F4", "#169D75"], hAxis: { title: "Exam with Team", :titleTextStyle => { :color => '#3388ff' } }, vAxis: { title: "Employees", :titleTextStyle => { :color => '#44dd88' }  }  }
    @chart = GoogleVisualr::Interactive::LineChart.new(data_table, opts)
  end

  def result_list
    # @employees = employee.students.joins([results: :exam], :responses, :teams).group("employees.id")
    # employee.students.includes(:exams, :results).where.not(results: {exam_id: nil}).zip
    # employee.students.includes(:exams, :results).where(results: {exam_id: nil})
    @employees = Employee.employees.eager_load(:exams, :results)
  end

  def show_exam_attempte
    @response = Response.eager_load(:question, :employee).where("employees.id = ? and correct_ans = false", params[:employee_id]).group("response.exam_id")
    @employee = employee.find(params[:employee_id])
    @responses = Response.where(employee_id: params[:employee_id], correct_ans: false)
    # @questions = Question.eager_load(:responses).select("responses.*").where("responses.correct_ans = false and responses.employee_id = ?", params[:employee_id])
  end

  def export_to_csv
    @employees = Employee.employees.eager_load(:exams, :results)

    respond_to do |format|
      format.csv { send_data @employees.to_csv, filename: "employees-attempts-#{Date.today}.csv" }
    end
  end

end
