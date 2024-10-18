class Post < ApplicationRecord
  attribute :tag_names, :string
  
  has_one_attached :image
  belongs_to :user
  has_many :post_groups, dependent: :destroy
  has_many :groups, through: :post_groups
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  
  validates :title, presence: true
  validates :title, length: {in: 2..20}
  validates :body, presence: true
  validates :body, length: {in: 2..200}
  validates :date, presence: true
  
  after_find :set_tag_names
  after_save :update_post_tags
  
  def get_image(width, height)
      unless image.attached?
          file_path = Rails.root.join('app/assets/images/no_image.jpg')
          image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      image.variant(resize_to_limit: [width, height])
      image
  end 
  
  private
  
  def set_tag_names
    self.tag_names = self.tags.pluck(:name).join(", ")
  end
  
  def update_post_tags
    tag_names = self.tags.pluck(:name)
    post_tag_names = self.tag_names.gsub(/[[:space:]]/, "").split(",")
    new_tag_names = post_tag_names - tag_names
    old_tag_names = tag_names - post_tag_names
    
    new_tags = new_tag_names.map { |name| Tag.find_or_create_by(name: name) }
    new_tags.each { |tag| self.post_tags.create(tag_id: tag.id) }
    
    old_tag_names.each do |name| 
      tag = Tag.find_by(name: name)
      post_tag = self.post_tags.find_by(tag_id: tag.id)
      post_tag.destroy if post_tag
    end
  end
end
