class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :skills

  belongs_to :role

  has_many :exams, through: :teams
  has_many :results
  has_many :issues, class_name: "Issue", foreign_key: "creator_id"
  has_many :responses
  belongs_to :role
  has_many :teams, through: :team_members
  has_many :team_members
  has_many :leave, as: :applicable
  has_many :documents, :dependent => :destroy

  scope :employees, -> { joins(:role).where(roles: { role: "employee" }) }
  scope :team_members, -> { joins(:role).where(roles: { role: "team_member" }) }
  scope :hr, -> { joins(:role).where(roles: { role: "hr" }) }
  scope :president, -> { joins(:role).where(roles: { role: "president" }) }

  scope :team_exams, -> { }

  def user_role
    role.role
  end

  def president?
    user_role == 'president'
  end

  def hr?
    user_role == "hr"
  end

  def team_leader?
    user_role == "team_leader"
  end

  def employee?
    user_role == "employee"
  end

  def name
    "#{first_name} #{last_name}"
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
end
