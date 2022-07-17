require "rails_helper"

RSpec. describe "User visits orders index page", type: :feature do
  scenario "he sees a table of orders sorted by date of duration" do
    # Capybara.current_driver =  :selenium_chrome_headless
    # create_list(:order, 5) do |u, i|
    #   u.created_at = (i.minutes.ago)
    # end

    5.times do |i|
      travel_to((10 - i).minutes.ago) { create(:order) }
    end

    visit admin_orders_path
    # save_and_open_screenshot
    first = page.find(:xpath, ".//table/tbody/tr[1]/td[@data-role='created_at']").text.to_datetime.to_i
    last = page.find(:xpath, ".//table/tbody/tr[5]/td[@data-role='created_at']").text.to_datetime.to_i
    # p '========================',first, last
    # expect(page.find(:xpath, ".//table/tbody/tr[1]/td[@data-role='created_at']")).to be
    expect(first).to be > last
  end

end
