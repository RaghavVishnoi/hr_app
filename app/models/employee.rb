class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :skills

  belongs_to :role
  has_many :events, class_name: "Event", foreign_key: "employee_id_id"
  has_many :switch_days, class_name: "SwitchDay", foreign_key: "employee_id"
  has_many :exams, through: :teams
  has_many :results
  has_many :issues, class_name: "Issue", foreign_key: "creator_id"
  has_many :responses
  has_many :employee_usage_logs
  has_many :trackers, class_name: "Tracker", foreign_key: "employee_id"
  has_many :leave_requests

  belongs_to :role
  has_many :teams, through: :team_members
  has_many :team_members
  has_many :documents, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_one :project_team_member, dependent: :destroy

  has_many :signatures, dependent: :destroy
  has_many :emp_benefit_docs, dependent: :destroy
  has_many :disclosures, dependent: :destroy

  has_many :review_categories, class_name: "PerfReviewCatg", foreign_key: "employee_id"
  has_many :answers, class_name: "QuesAnsw", foreign_key: "employee_id"

  # has_one :project_team, through: :project_team_members
  # has_many :project_team_members

  scope :employees, -> { joins(:role).where(roles: { role: "employee" }) }
  scope :team_managers, -> { joins(:role).where(roles: { role: "team_manager" }) }
  scope :team_leaders, -> { joins(:role).where(roles: { role: "team_leader" }) }

  scope :team_members, -> { joins(:role).where(roles: { role: "team_member" }) }
  scope :hr, -> { joins(:role).where(roles: { role: "hr" }) }
  scope :president, -> { joins(:role).where(roles: { role: "president" }) }
  scope :team_exams, -> { }

  scope :members, -> { joins(:role).where("roles.role in (?)", ["employee", "team_manager", "team_leader"]) }
  

  def self.not_added()
    includes(:project_team_member).where(project_team_members: { employee_id: nil } )
  end

  def user_role
    role.role
  end

  def president?
    user_role == 'president'
  end

  def hr?
    user_role == "hr"
  end

  def team_manager?
    user_role == "team_manager"
  end

  def team_leader?
    user_role == "team_leader"
  end

  def employee?
    user_role == "employee"
  end

  def name
    if first_name.present? || last_name.present?
      "#{first_name} #{last_name}"
    else
      email
    end
  end

  def covers
    Employee.where("role_id = ?", self.role.id)
  end

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << ["Employee", "Exam", "Attemted?"]

      all.each do |user|
        user.exams.each do |exam|
          csv << [ "#{user.fullname}", "#{exam.title}", "#{exam.is_attemted_by(user)}" ]
        end
      end
    end
  end

  def any_reviews_pending?
    reviews_pending.present?
  end

  def reviews_pending
    PerfReviewReviewer.where(reviewer_id: self.id, flag: false)
  end

  def reviews_pending_for
    arr = Array.new
    reviews_pending.each do |review_pending|
      arr << review_pending.perf_review_request.reviewee_id
    end
    arr.map { |id| Employee.find(id).email }
  end

end
