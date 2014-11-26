require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase
  include DatabaseConfiguration

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:microposts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create new" do
    micropost_params = { content: 'test' }
    post :create, micropost: micropost_params

    assert { Micropost.exists?(micropost_params) }

    assert_redirected_to microposts_path
  end

  sub_test_case 'when a micropost already exists' do
    setup do
      @micropost = FactoryGirl.create(:micropost)
    end

    test "should get edit" do
      get :edit, id: @micropost
      assert_response :success
    end

    test "should update micropost" do
      patch :update, id: @micropost, micropost: { content: @micropost.content }
      assert_redirected_to microposts_path
    end

    test "should destroy micropost" do
      delete :destroy, id: @micropost

      assert { not Micropost.exists?(@micropost.id) }

      assert_redirected_to microposts_path
    end
  end

  test "should get search" do
    @micropost = FactoryGirl.create(:micropost, content: "content")

    get :search, q: "content"

    assert_response :success
    assert do
      assigns(:microposts) == [@micropost]
    end
  end
end
