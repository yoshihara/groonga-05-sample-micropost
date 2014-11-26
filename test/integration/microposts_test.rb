class MicropostsTest < ActionDispatch::IntegrationTest
  include DatabaseConfiguration

  setup do
    @content = "This is micropost!!!"
    @micropost = FactoryGirl.create(:micropost, content: @content)
  end

  sub_test_case "index" do
    setup do
      visit microposts_path
    end

    test "should show micropost content" do
      assert { page.has_text?(@content) }
    end

    test "should include link for edit" do
      assert { page.has_css?( "a[@href='#{micropost_path(@micropost)}']" ) }
    end
  end

  sub_test_case "edit" do
    setup do
      visit edit_micropost_path(@micropost)
    end

    test "should update the micropost" do
      updated_content = "#{@content} Tiny post!!!"
      fill_in "micropost[content]", with: updated_content
      find("input[type='submit']").click

      within "#microposts" do
        assert { page.has_text?(updated_content) }
      end
    end
  end

  sub_test_case "destroy" do
    setup do
      visit microposts_path
    end

    test "should update the micropost" do
      click_link 'Destroy'

      within "#microposts" do
        assert { all(".content").empty? }
      end
    end
  end

  sub_test_case "search" do
    setup do
      @hit_content = "hitted"
      @hit_micropost = FactoryGirl.create(:micropost, content: @hit_content)
      visit search_microposts_path(q: "hitted")
    end

    test "should show micropost content" do
      assert { page.all(".content").map(&:text) == [@hit_content] }
    end
  end
end
