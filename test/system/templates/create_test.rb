require "application_system_test_case"

module Templates
  class CreateSystemTest < ApplicationSystemTestCase
    test "valid form" do
      category = create(:category)
      _other_category = create(:category)
      account = create(:account)
      _other_account = create(:account)

      visit_templates_page

      assert_css "h1", text: t("views.templates.new.page_title")

      fill_in field(Template, :title), with: "Wage"
      choose t("income")
      select account.title, from: field(Template, :account_id)
      select category.title, from: field(Template, :category_id)
      fill_in field(Template, :amount_cents), with: "2000_00"
      fill_in field(Template, :note), with: "Lumon"

      click_button submit_text(Template)

      assert_current_path templates_path
      assert_css ".alert-success", text: t("templates.create.success")
      assert_css "li", text: "Wage"
      assert_css "li", text: "Lumon"
      assert_css "li", text: account.title
      assert_css "li", text: category.title
      assert_css "li", text: Money.new(200000).format(sign_positive: true)
    end

    test "invalid form" do
      visit_templates_page

      fill_in field(Template, :title), with: ""

      click_button submit_text(Template)

      assert_current_path new_template_path
      assert_field field(Template, :title), with: ""
      assert_css "span", text: t("errors.messages.blank").upcase_first
    end

    private

    def visit_templates_page
      visit root_path(as: create(:user))

      click_link t("components.layouts.menu_items.templates")

      click_link t("views.templates.index.new_template")
    end
  end
end
