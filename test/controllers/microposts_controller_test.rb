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
    post :create, micropost: { content: 'test' }

    assert { Micropost.count == 1 }

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

      assert { Micropost.count == 0 }

      assert_redirected_to microposts_path
    end
  end
end
