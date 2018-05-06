require 'test_helper'

class SalonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @salon = salons(:one)
  end

  test "should get index" do
    get salons_url
    assert_response :success
  end

  test "should get new" do
    get new_salon_url
    assert_response :success
  end

  test "should create salon" do
    assert_difference('Salon.count') do
      post salons_url, params: { salon: { address: @salon.address, image: @salon.image, name: @salon.name, tel: @salon.tel, user_id: @salon.user_id } }
    end

    assert_redirected_to salon_url(Salon.last)
  end

  test "should show salon" do
    get salon_url(@salon)
    assert_response :success
  end

  test "should get edit" do
    get edit_salon_url(@salon)
    assert_response :success
  end

  test "should update salon" do
    patch salon_url(@salon), params: { salon: { address: @salon.address, image: @salon.image, name: @salon.name, tel: @salon.tel, user_id: @salon.user_id } }
    assert_redirected_to salon_url(@salon)
  end

  test "should destroy salon" do
    assert_difference('Salon.count', -1) do
      delete salon_url(@salon)
    end

    assert_redirected_to salons_url
  end
end
