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
  has_many :responses
  belongs_to :role
  has_many :teams, through: :team_members
  has_many :team_members

  has_many :leave, as: :applicable

  scope :employees, -> { joins(:role).where(roles: { role: "employees" }) }
  scope :team_exams, -> { }

  def user_role
    role.role
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
