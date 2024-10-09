class Post < ApplicationRecord
    
    has_one_attached :image
    belongs_to :user
    has_many :post_groups, dependent: :destroy
    has_many :groups, through: :post_groups
    has_many :comments, dependent: :destroy
    has_many :post_tafs, dependent: :destroy
    has_many :tags, through: :post_tags
    
    validates :title, presence: true
    validates :title, length: {in: 2..20}
    validates :body, presence: true
    validates :body, length: {in: 2..200}
    validates :date, presence: true
    
    def get_image(width, height)
        unless image.attached?
            file_path = Rails.root.join('app/assets/images/no_image.jpg')
            image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        image.variant(resize_to_limit: [width, height]).processed
    end 
    
    def save_tags(savepost_tags)
      savepost_tags.each do |new_name|
        post_tag = Tag.find_or_create_by(name: new_name)
        self.tags << post_tag
      end
    end
    
end
