class Micropost < ActiveRecord::Base
  after_save :update_groonga_index

  private

  def update_groonga_index
    MicropostIndex.update_from(self)
  end
end
