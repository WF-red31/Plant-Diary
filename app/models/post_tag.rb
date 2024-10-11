class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag
  
  after_destroy :check_post
  
  private
  
  def check_post
    self.tag
    if self.tag.post_tags.size <= 0
      self.tag.destroy
    end
  end
end
