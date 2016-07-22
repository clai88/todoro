require_relative "test_helper"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def setup
  end

  def teardown
  end

  def app
    App
  end

  def test_has_a_root_route
    response = get "/"
    assert response.ok?
  end

  def test_homepage_loads
    response = get "/"
    assert_includes response.body, "Welcome to Todo list"

    assert_includes response.body, "these are your list"
  end

  def test_can_create_list
    skip
    g = List.new(name: "groceries")
    response = get "/lists"

    assert response.ok?

    assert_includes response.body, "groceries"
  end
end
