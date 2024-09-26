class Group < ApplicationRecord
    
    belongs_to :user
    has_many :group_users, dependent: :destroy
    
    validates :name, presence: true, uniqueness: true
    validates :introduction, presence: true
    validates :name, length: {in: 2..20}
    validates :introduction, length: {in: 2..200}
    
end
