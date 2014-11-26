require 'test_helper'

class MicropostIndexTest < ActiveSupport::TestCase
  include DatabaseConfiguration

  setup do
    @test_content = "test"
    @micropost = FactoryGirl.build(:micropost, content: @test_content)
  end

  sub_test_case ".update_from" do
    test "should update form saved micropost" do
      @micropost.save!
      MicropostIndex.update_from(@micropost)

      assert do
        MicropostIndex.microposts[@micropost.id.to_s].content == @test_content
      end
    end
  end

  sub_test_case ".search" do
    setup do
      @test_2_content = "test_2"
      @micropost.save
      @micropost2 = FactoryGirl.create(:micropost, content: @test_2_content)
    end

    test "one micropost should be hit" do
      microposts = MicropostIndex.search("test_2")
      assert do
        microposts.pluck(:content) == [@test_2_content]
      end
    end

    test "two microposts should be hit" do
      microposts = MicropostIndex.search("test")
      assert do
        microposts.pluck(:content) == [@test_content, @test_2_content]
      end
    end

    test "no micropost should be hit" do
      microposts = MicropostIndex.search("no_existed_content")
      assert do
        microposts.empty?
      end
    end

    test "all microposts should be hit by empty query" do
      microposts = MicropostIndex.search("")
      assert do
        microposts.pluck(:content) == [@test_content, @test_2_content]
      end
    end
  end
end
