# Author: Loi Huynh

# Senior Technical Recruiter: Tyler Mills

# Date: 4/7/22

defmodule HomeworkTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case

  # Start hound session and destroy when tests are run
  hound_session()

  test "Add/Remove Elements: Add Elements button should be visible" do
    navigate_to "https://the-internet.herokuapp.com"
    find_element(:link_text, "Add/Remove Elements") |> click()
    element = find_element(:class, "example")
    assert visible_text(element) == "Add Element"
  end

  test "Able to select Dropdown List Option 2" do
    navigate_to "https://the-internet.herokuapp.com"
    find_element(:link_text, "Dropdown") |> click()
    find_element(:id, "dropdown") |> click()
    find_element(:css,  "option[value='1']") |> click()
  end

  test "Display invalid username message" do
    navigate_to "https://the-internet.herokuapp.com"
    find_element(:link_text, "Form Authentication") |> click()
    input_into_field({:id, "username"}, "LoiHuynh")
    input_into_field({:id, "password"}, "secret")
    find_element(:css,  "button[type='submit']") |> click()
    assert element_displayed?({:class, "error"})

    path = take_screenshot("login-error.png")
    assert File.exists?(path)
  end

  test "Type the TAB key and get result" do
    navigate_to "https://the-internet.herokuapp.com"
    find_element(:link_text, "Key Presses") |> click()
    find_element(:id, "target") |> click()
    send_keys(:tab)

    element = find_element(:id, "result")
    assert visible_text(element) == "You entered: TAB"
  end
end
