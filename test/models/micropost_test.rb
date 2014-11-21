require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  include DatabaseConfiguration

  setup do
    @content = 'test'
    @micropost = FactoryGirl.build(:micropost, content: @content)
  end

  test 'should update index form saved micropost' do
    @micropost.save!

    assert do
      MicropostIndex.microposts[@micropost.id.to_s].content == @content
    end
  end
end
