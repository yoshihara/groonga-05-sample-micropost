require 'test_helper'

class MicropostIndexTest < ActiveSupport::TestCase
  include DatabaseConfiguration

  setup do
    @micropost = FactoryGirl.build(:micropost, content: "test")
  end

  sub_test_case ".update_from" do
    test "should update form saved micropost" do
      @micropost.save!
      MicropostIndex.update_from(@micropost)

      assert do
        MicropostIndex.microposts[@micropost.id.to_s].content == @micropost.content
      end
    end
  end
end
