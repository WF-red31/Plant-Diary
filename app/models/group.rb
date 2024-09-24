class Group < ApplicationRecord
    
    belongs_to :user
    has_many :post
    
    validates :name, presence: true
    validates :introduction, presence: true
    validates :name, length: {in: 2..20}
    validates :introduction, length: {in: 2..200}
    
end
