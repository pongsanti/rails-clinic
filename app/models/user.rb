class User < ActiveRecord::Base

  ROLES = %i[operator doctor manager admin]

  ID_PREFIX = "U"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :exams, foreign_key: 'examiner_id'
  belongs_to :client, inverse_of: :users

  #scope
  class << self

    def for_client(client)
      where("client_id = ?", client).order("id")
    end

  end

  #Roles
  def roles=(roles)
    roles = [*roles].map { |r| r.to_sym }
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def has_role?(role)
    roles.include?(role)
  end

  def operator?
    has_role? User::ROLES[0]
  end

  def doctor?
    has_role? User::ROLES[1]
  end

  def manager?
    has_role? User::ROLES[2]
  end

  def admin?
    has_role? User::ROLES[3]
  end

  #devise custom check if user's got client yet
  def active_for_authentication?
    super && self.client.present?
  end

  def inactive_message
    self.client.present? ? super : :no_client
  end

end
