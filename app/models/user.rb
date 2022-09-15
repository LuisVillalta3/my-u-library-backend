class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
  # 
  belongs_to :role
  #
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: true }, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
end
