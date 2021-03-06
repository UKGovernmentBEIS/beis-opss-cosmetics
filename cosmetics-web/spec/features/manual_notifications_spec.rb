require "rails_helper"

RSpec.describe "Manual notifications", :with_stubbed_antivirus, type: :feature do
  let(:responsible_person) { create(:responsible_person_with_user, :with_a_contact_person) }
  let(:user) { responsible_person.responsible_person_users.first.user }

  before do
    sign_in_as_member_of_responsible_person(responsible_person, user)
  end

  scenario "Manual, exact ingredients, single item, with CMRS, no nanomaterials" do
    visit new_responsible_person_add_notification_path(responsible_person)

    expect_to_be_on__was_eu_notified_about_products_page
    expect_back_link_to_notifications_page
    answer_was_eu_notified_with "No"

    expect_to_be_on__are_you_likely_to_notify_eu_page
    expect_back_link_to_was_eu_notified_about_products_page
    answer_are_you_likely_to_notify_eu_with "No"

    expect_to_be_on__what_is_product_called_page
    expect_back_link_to_are_you_likely_to_notify_eu_page
    answer_product_name_with "SkinSoft tangerine shampoo"

    expect_to_be_on__internal_reference_page
    expect_back_link_to_what_is_product_called_page
    answer_do_you_want_to_give_an_internal_reference_with "No"

    expect_to_be_on__is_product_for_under_threes_page
    expect_back_link_to_internal_reference_page
    answer_is_product_for_under_threes_with "No"

    expect_to_be_on__multi_item_kits_page
    expect_back_link_to_is_product_for_under_threes_page
    answer_is_product_multi_item_kit_with "No, this is a single product"

    expect_to_be_on_upload_product_label_page
    expect_back_link_to_multi_item_kits_page
    upload_product_label

    expect_to_be_on__is_item_available_in_shades_page
    expect_back_link_to_upload_product_label_page
    answer_is_item_available_in_shades_with "No"

    expect_to_be_on__physical_form_of_item_page
    expect_back_link_to_is_item_available_in_shades_page
    answer_what_is_physical_form_of_item_with "Liquid"

    expect_to_be_on__what_is_product_contained_in_page
    expect_back_link_to_physical_form_of_item_page
    answer_what_is_product_contained_in_with "A pressurised container, an impregnated sponge, wipe, patch or pad, or is encapsulated"

    expect_to_be_on__what_type_of_applicator_page
    expect_back_link_to_what_is_product_contained_in_page
    answer_what_type_of_applicator_with "Pressurised spray"

    expect_to_be_on__does_item_contain_cmrs_page
    expect_back_link_to_what_type_of_applicator_page
    answer_does_item_contain_cmrs_with "Yes"

    fill_in "component_cmrs_attributes_0_name", with: "Cmrs 1"
    fill_in "component_cmrs_attributes_0_cas_number", with: "1111-11-1"
    fill_in "component_cmrs_attributes_0_ec_number", with: "111-111-3"
    click_button "Continue"

    expect_to_be_on__does_item_contain_nanomaterial_page
    expect_back_link_to_add_cmrs_page
    answer_does_item_contain_nanomaterials_with "No"

    expect_to_be_on__item_category_page
    expect_back_link_to_does_item_contain_nanomaterial_page
    answer_item_category_with "Hair and scalp products"

    expect_to_be_on__item_subcategoy_page(category: "hair and scalp products")
    expect_back_link_to_item_category_page
    answer_item_subcategory_with "Hair and scalp care and cleansing products"

    expect_to_be_on__item_sub_subcategory_page(subcategory: "hair and scalp care and cleansing products")
    expect_back_link_to_item_category_page("hair_and_scalp_products")
    answer_item_sub_subcategory_with "Shampoo"

    expect_to_be_on__formulation_method_page
    expect_back_link_to_item_category_page("hair_and_scalp_care_and_cleansing_products")
    answer_how_do_you_want_to_give_formulation_with "List ingredients and their exact concentration"

    expect_to_be_on__upload_ingredients_page "Exact concentrations of the ingredients"
    expect_back_link_to_formulation_method_page
    upload_ingredients_pdf

    expect_to_be_on__what_is_ph_range_of_product_page
    expect_back_link_to_upload_ingredients_page
    answer_what_is_ph_range_of_product_with "The minimum pH is 3 or higher, and the maximum pH is 10 or lower"

    expect_to_be_on__check_your_answers_page(product_name: "SkinSoft tangerine shampoo")
    expect_back_link_to_what_is_ph_range_of_product_page

    expect_check_your_answers_page_to_contain(
      product_name: "SkinSoft tangerine shampoo",
      number_of_components: "1",
      shades: "None",
      nanomaterials: "None",
      contains_cmrs: "Yes",
      category: "Hair and scalp products",
      subcategory: "Hair and scalp care and cleansing products",
      sub_subcategory: "Shampoo",
      formulation_given_as: "Exact concentration",
      physical_form: "Liquid",
      ph: "Between 3 and 10",
    )
    click_button "Accept and submit"

    expect_to_be_on__your_cosmetic_products_page
    expect_to_see_message "SkinSoft tangerine shampoo notification submitted"
  end

  scenario "Manual, exact ingredients, single item, no nanomaterials" do
    visit new_responsible_person_add_notification_path(responsible_person)

    expect_to_be_on__was_eu_notified_about_products_page
    expect_back_link_to_notifications_page
    answer_was_eu_notified_with "No"

    expect_to_be_on__are_you_likely_to_notify_eu_page
    expect_back_link_to_was_eu_notified_about_products_page
    answer_are_you_likely_to_notify_eu_with "No"

    expect_to_be_on__what_is_product_called_page
    expect_back_link_to_are_you_likely_to_notify_eu_page
    answer_product_name_with "SkinSoft tangerine shampoo"

    expect_to_be_on__internal_reference_page
    expect_back_link_to_what_is_product_called_page
    answer_do_you_want_to_give_an_internal_reference_with "No"

    expect_to_be_on__is_product_for_under_threes_page
    expect_back_link_to_internal_reference_page
    answer_is_product_for_under_threes_with "No"

    expect_to_be_on__multi_item_kits_page
    expect_back_link_to_is_product_for_under_threes_page
    answer_is_product_multi_item_kit_with "No, this is a single product"

    expect_to_be_on_upload_product_label_page
    expect_back_link_to_multi_item_kits_page
    upload_product_label

    expect_to_be_on__is_item_available_in_shades_page
    expect_back_link_to_upload_product_label_page
    answer_is_item_available_in_shades_with "No"

    expect_to_be_on__physical_form_of_item_page
    expect_back_link_to_is_item_available_in_shades_page
    answer_what_is_physical_form_of_item_with "Liquid"

    expect_to_be_on__what_is_product_contained_in_page
    expect_back_link_to_physical_form_of_item_page
    answer_what_is_product_contained_in_with "A pressurised container, an impregnated sponge, wipe, patch or pad, or is encapsulated"

    expect_to_be_on__what_type_of_applicator_page
    expect_back_link_to_what_is_product_contained_in_page
    answer_what_type_of_applicator_with "Pressurised spray"

    expect_to_be_on__does_item_contain_cmrs_page
    expect_back_link_to_what_type_of_applicator_page
    answer_does_item_contain_cmrs_with "No"

    expect_to_be_on__does_item_contain_nanomaterial_page
    expect_back_link_to_does_item_contain_cmrs_page
    answer_does_item_contain_nanomaterials_with "No"

    expect_to_be_on__item_category_page
    expect_back_link_to_does_item_contain_nanomaterial_page
    answer_item_category_with "Hair and scalp products"

    expect_to_be_on__item_subcategoy_page(category: "hair and scalp products")
    expect_back_link_to_item_category_page
    answer_item_subcategory_with "Hair and scalp care and cleansing products"

    expect_to_be_on__item_sub_subcategory_page(subcategory: "hair and scalp care and cleansing products")
    expect_back_link_to_item_category_page("hair_and_scalp_products")
    answer_item_sub_subcategory_with "Shampoo"

    expect_to_be_on__formulation_method_page
    expect_back_link_to_item_category_page("hair_and_scalp_care_and_cleansing_products")
    answer_how_do_you_want_to_give_formulation_with "List ingredients and their exact concentration"

    expect_to_be_on__upload_ingredients_page "Exact concentrations of the ingredients"
    expect_back_link_to_formulation_method_page
    upload_ingredients_pdf

    expect_to_be_on__what_is_ph_range_of_product_page
    expect_back_link_to_upload_ingredients_page
    answer_what_is_ph_range_of_product_with "The minimum pH is 3 or higher, and the maximum pH is 10 or lower"

    expect_to_be_on__check_your_answers_page(product_name: "SkinSoft tangerine shampoo")
    expect_back_link_to_what_is_ph_range_of_product_page

    expect_check_your_answers_page_to_contain(
      product_name: "SkinSoft tangerine shampoo",
      number_of_components: "1",
      shades: "None",
      nanomaterials: "None",
      category: "Hair and scalp products",
      subcategory: "Hair and scalp care and cleansing products",
      sub_subcategory: "Shampoo",
      formulation_given_as: "Exact concentration",
      physical_form: "Liquid",
      ph: "Between 3 and 10",
    )
    click_button "Accept and submit"

    expect_to_be_on__your_cosmetic_products_page
    expect_to_see_message "SkinSoft tangerine shampoo notification submitted"
  end

  scenario "Manual, ingredient ranges, single item, no nanomaterials" do
    visit new_responsible_person_add_notification_path(responsible_person)

    expect_to_be_on__was_eu_notified_about_products_page
    expect_back_link_to_notifications_page
    answer_was_eu_notified_with "No"

    expect_to_be_on__are_you_likely_to_notify_eu_page
    expect_back_link_to_was_eu_notified_about_products_page
    answer_are_you_likely_to_notify_eu_with "No"

    expect_to_be_on__what_is_product_called_page
    expect_back_link_to_are_you_likely_to_notify_eu_page
    answer_product_name_with "SkinSoft tangerine shampoo"

    expect_to_be_on__internal_reference_page
    expect_back_link_to_what_is_product_called_page
    answer_do_you_want_to_give_an_internal_reference_with "No"

    expect_to_be_on__is_product_for_under_threes_page
    expect_back_link_to_internal_reference_page
    answer_is_product_for_under_threes_with "No"

    expect_to_be_on__multi_item_kits_page
    expect_back_link_to_is_product_for_under_threes_page
    answer_is_product_multi_item_kit_with "No, this is a single product"

    expect_to_be_on_upload_product_label_page
    expect_back_link_to_multi_item_kits_page
    upload_product_label

    expect_to_be_on__is_item_available_in_shades_page
    expect_back_link_to_upload_product_label_page
    answer_is_item_available_in_shades_with "No"

    expect_to_be_on__physical_form_of_item_page
    expect_back_link_to_is_item_available_in_shades_page
    answer_what_is_physical_form_of_item_with "Liquid"

    expect_to_be_on__what_is_product_contained_in_page
    expect_back_link_to_physical_form_of_item_page
    answer_what_is_product_contained_in_with "A pressurised container, an impregnated sponge, wipe, patch or pad, or is encapsulated"

    expect_to_be_on__what_type_of_applicator_page
    expect_back_link_to_what_is_product_contained_in_page
    answer_what_type_of_applicator_with "Pressurised spray"

    expect_to_be_on__does_item_contain_cmrs_page
    expect_back_link_to_what_type_of_applicator_page
    answer_does_item_contain_cmrs_with "No"

    expect_to_be_on__does_item_contain_nanomaterial_page
    expect_back_link_to_does_item_contain_cmrs_page
    answer_does_item_contain_nanomaterials_with "No"

    expect_to_be_on__item_category_page
    expect_back_link_to_does_item_contain_nanomaterial_page
    answer_item_category_with "Hair and scalp products"

    expect_to_be_on__item_subcategoy_page(category: "hair and scalp products")
    expect_back_link_to_item_category_page
    answer_item_subcategory_with "Hair and scalp care and cleansing products"

    expect_to_be_on__item_sub_subcategory_page(subcategory: "hair and scalp care and cleansing products")
    expect_back_link_to_item_category_page("hair_and_scalp_products")
    answer_item_sub_subcategory_with "Shampoo"

    expect_to_be_on__formulation_method_page
    expect_back_link_to_item_category_page("hair_and_scalp_care_and_cleansing_products")
    answer_how_do_you_want_to_give_formulation_with "List ingredients and their concentration range"

    expect_to_be_on__upload_ingredients_page "Concentration ranges of the ingredients"
    expect_back_link_to_formulation_method_page
    upload_ingredients_pdf

    expect_to_be_on__what_is_ph_range_of_product_page
    expect_back_link_to_upload_ingredients_page
    answer_what_is_ph_range_of_product_with "The minimum pH is 3 or higher, and the maximum pH is 10 or lower"

    expect_to_be_on__check_your_answers_page(product_name: "SkinSoft tangerine shampoo")
    expect_back_link_to_what_is_ph_range_of_product_page

    expect_check_your_answers_page_to_contain(
      product_name: "SkinSoft tangerine shampoo",
      number_of_components: "1",
      shades: "None",
      nanomaterials: "None",
      category: "Hair and scalp products",
      subcategory: "Hair and scalp care and cleansing products",
      sub_subcategory: "Shampoo",
      formulation_given_as: "Concentration ranges",
      physical_form: "Liquid",
      ph: "Between 3 and 10",
    )
    click_button "Accept and submit"

    expect_to_be_on__your_cosmetic_products_page
    expect_to_see_message "SkinSoft tangerine shampoo notification submitted"
  end

  scenario "Manual, frame formulation, single item, no nanomaterials" do
    visit new_responsible_person_add_notification_path(responsible_person)

    expect_to_be_on__was_eu_notified_about_products_page
    expect_back_link_to_notifications_page
    answer_was_eu_notified_with "No"

    expect_to_be_on__are_you_likely_to_notify_eu_page
    expect_back_link_to_was_eu_notified_about_products_page
    answer_are_you_likely_to_notify_eu_with "No"

    expect_to_be_on__what_is_product_called_page
    expect_back_link_to_are_you_likely_to_notify_eu_page
    answer_product_name_with "SkinSoft tangerine shampoo"

    expect_to_be_on__internal_reference_page
    expect_back_link_to_what_is_product_called_page
    answer_do_you_want_to_give_an_internal_reference_with "No"

    expect_to_be_on__is_product_for_under_threes_page
    expect_back_link_to_internal_reference_page
    answer_is_product_for_under_threes_with "No"

    expect_to_be_on__multi_item_kits_page
    expect_back_link_to_is_product_for_under_threes_page
    answer_is_product_multi_item_kit_with "No, this is a single product"

    expect_to_be_on_upload_product_label_page
    expect_back_link_to_multi_item_kits_page
    upload_product_label

    expect_to_be_on__is_item_available_in_shades_page
    expect_back_link_to_upload_product_label_page
    answer_is_item_available_in_shades_with "No"

    expect_to_be_on__physical_form_of_item_page
    expect_back_link_to_is_item_available_in_shades_page
    answer_what_is_physical_form_of_item_with "Liquid"

    expect_to_be_on__what_is_product_contained_in_page
    expect_back_link_to_physical_form_of_item_page
    answer_what_is_product_contained_in_with "A pressurised container, an impregnated sponge, wipe, patch or pad, or is encapsulated"

    expect_to_be_on__what_type_of_applicator_page
    expect_back_link_to_what_is_product_contained_in_page
    answer_what_type_of_applicator_with "Pressurised spray"

    expect_to_be_on__does_item_contain_cmrs_page
    expect_back_link_to_what_type_of_applicator_page
    answer_does_item_contain_cmrs_with "No"

    expect_to_be_on__does_item_contain_nanomaterial_page
    expect_back_link_to_does_item_contain_cmrs_page
    answer_does_item_contain_nanomaterials_with "No"

    expect_to_be_on__item_category_page
    expect_back_link_to_does_item_contain_nanomaterial_page
    answer_item_category_with "Hair and scalp products"

    expect_to_be_on__item_subcategoy_page(category: "hair and scalp products")
    expect_back_link_to_item_category_page
    answer_item_subcategory_with "Hair and scalp care and cleansing products"

    expect_to_be_on__item_sub_subcategory_page(subcategory: "hair and scalp care and cleansing products")
    expect_back_link_to_item_category_page("hair_and_scalp_products")
    answer_item_sub_subcategory_with "Shampoo"

    expect_to_be_on__formulation_method_page
    expect_back_link_to_item_category_page("hair_and_scalp_care_and_cleansing_products")
    answer_how_do_you_want_to_give_formulation_with "Choose a predefined frame formulation"

    expect_to_be_on__frame_formulation_select_page
    expect_back_link_to_formulation_method_page
    give_frame_formulation_as "Soap Shampoo"

    expect_to_be_on__poisonous_ingredients_page
    expect_back_link_to_frame_formulation_select_page
    answer_does_product_contain_poisonous_ingredients_with "No"

    expect_to_be_on__what_is_ph_range_of_product_page
    expect_back_link_to_poisonous_ingredients_page
    answer_what_is_ph_range_of_product_with "The minimum pH is 3 or higher, and the maximum pH is 10 or lower"

    expect_to_be_on__check_your_answers_page(product_name: "SkinSoft tangerine shampoo")
    expect_back_link_to_what_is_ph_range_of_product_page

    expect_check_your_answers_page_to_contain(
      product_name: "SkinSoft tangerine shampoo",
      number_of_components: "1",
      shades: "None",
      nanomaterials: "None",
      category: "Hair and scalp products",
      subcategory: "Hair and scalp care and cleansing products",
      sub_subcategory: "Shampoo",
      formulation_given_as: "Frame formulation",
      physical_form: "Liquid",
      ph: "Between 3 and 10",
    )
    click_button "Accept and submit"

    expect_to_be_on__your_cosmetic_products_page
    expect_to_see_message "SkinSoft tangerine shampoo notification submitted"
  end

  scenario "Manual, frame formulation (with poisonous ingredients), single item, no nanomaterials" do
    visit new_responsible_person_add_notification_path(responsible_person)

    expect_to_be_on__was_eu_notified_about_products_page
    expect_back_link_to_notifications_page
    answer_was_eu_notified_with "No"

    expect_to_be_on__are_you_likely_to_notify_eu_page
    expect_back_link_to_was_eu_notified_about_products_page
    answer_are_you_likely_to_notify_eu_with "No"

    expect_to_be_on__what_is_product_called_page
    expect_back_link_to_are_you_likely_to_notify_eu_page
    answer_product_name_with "SkinSoft tangerine shampoo"

    expect_to_be_on__internal_reference_page
    expect_back_link_to_what_is_product_called_page
    answer_do_you_want_to_give_an_internal_reference_with "No"

    expect_to_be_on__is_product_for_under_threes_page
    expect_back_link_to_internal_reference_page
    answer_is_product_for_under_threes_with "No"

    expect_to_be_on__multi_item_kits_page
    expect_back_link_to_is_product_for_under_threes_page
    answer_is_product_multi_item_kit_with "No, this is a single product"

    expect_to_be_on_upload_product_label_page
    expect_back_link_to_multi_item_kits_page
    upload_product_label

    expect_to_be_on__is_item_available_in_shades_page
    expect_back_link_to_upload_product_label_page
    answer_is_item_available_in_shades_with "No"

    expect_to_be_on__physical_form_of_item_page
    expect_back_link_to_is_item_available_in_shades_page
    answer_what_is_physical_form_of_item_with "Liquid"

    expect_to_be_on__what_is_product_contained_in_page
    expect_back_link_to_physical_form_of_item_page
    answer_what_is_product_contained_in_with "A pressurised container, an impregnated sponge, wipe, patch or pad, or is encapsulated"

    expect_to_be_on__what_type_of_applicator_page
    expect_back_link_to_what_is_product_contained_in_page
    answer_what_type_of_applicator_with "Pressurised spray"

    expect_to_be_on__does_item_contain_cmrs_page
    expect_back_link_to_what_type_of_applicator_page
    answer_does_item_contain_cmrs_with "No"

    expect_to_be_on__does_item_contain_nanomaterial_page
    expect_back_link_to_does_item_contain_cmrs_page
    answer_does_item_contain_nanomaterials_with "No"

    expect_to_be_on__item_category_page
    expect_back_link_to_does_item_contain_nanomaterial_page
    answer_item_category_with "Hair and scalp products"

    expect_to_be_on__item_subcategoy_page(category: "hair and scalp products")
    expect_back_link_to_item_category_page
    answer_item_subcategory_with "Hair and scalp care and cleansing products"

    expect_to_be_on__item_sub_subcategory_page(subcategory: "hair and scalp care and cleansing products")
    expect_back_link_to_item_category_page("hair_and_scalp_products")
    answer_item_sub_subcategory_with "Shampoo"

    expect_to_be_on__formulation_method_page
    expect_back_link_to_item_category_page("hair_and_scalp_care_and_cleansing_products")
    answer_how_do_you_want_to_give_formulation_with "Choose a predefined frame formulation"

    expect_to_be_on__frame_formulation_select_page
    expect_back_link_to_formulation_method_page
    give_frame_formulation_as "Soap Shampoo"

    expect_to_be_on__poisonous_ingredients_page
    expect_back_link_to_frame_formulation_select_page
    answer_does_product_contain_poisonous_ingredients_with "Yes"

    expect(page.current_path).to end_with("/build/upload_formulation")
    expect(page).to have_h1("Upload a list of ingredients the National Poisons Information Service needs to know about")

    expect_back_link_to_poisonous_ingredients_page
    upload_ingredients_pdf

    expect_to_be_on__what_is_ph_range_of_product_page
    expect_back_link_to_upload_poisonous_ingredients_page
    answer_what_is_ph_range_of_product_with "The minimum pH is 3 or higher, and the maximum pH is 10 or lower"

    expect_to_be_on__check_your_answers_page(product_name: "SkinSoft tangerine shampoo")
    expect_back_link_to_what_is_ph_range_of_product_page

    expect_check_your_answers_page_to_contain(
      product_name: "SkinSoft tangerine shampoo",
      number_of_components: "1",
      shades: "None",
      nanomaterials: "None",
      category: "Hair and scalp products",
      subcategory: "Hair and scalp care and cleansing products",
      sub_subcategory: "Shampoo",
      formulation_given_as: "Frame formulation",
      physical_form: "Liquid",
      ph: "Between 3 and 10",
    )
    click_button "Accept and submit"

    expect_to_be_on__your_cosmetic_products_page
    expect_to_see_message "SkinSoft tangerine shampoo notification submitted"
  end

  scenario "Manual, frame formulation, multi-item, no nanomaterials, no poison" do
    visit new_responsible_person_add_notification_path(responsible_person)

    expect_to_be_on__was_eu_notified_about_products_page
    expect_back_link_to_notifications_page
    answer_was_eu_notified_with "Yes"

    expect_to_be_on__do_you_have_the_zip_files_page
    expect_back_link_to_was_eu_notified_about_products_page
    answer_do_you_have_zip_files_with "No, I’ll enter information manually"

    expect_to_be_on__what_is_product_called_page
    expect_back_link_to_do_you_have_the_zip_files_page
    answer_product_name_with "SkinSoft strawberry blonde hair dye"

    expect_to_be_on__internal_reference_page
    expect_back_link_to_what_is_product_called_page
    answer_do_you_want_to_give_an_internal_reference_with "No"

    expect_to_be_on__is_product_for_under_threes_page
    expect_back_link_to_internal_reference_page
    answer_is_product_for_under_threes_with "No"

    expect_to_be_on__multi_item_kits_page
    expect_back_link_to_is_product_for_under_threes_page
    answer_is_product_multi_item_kit_with "Yes"

    expect_to_be_on_upload_item_label_page
    expect_back_link_to_multi_item_kits_page
    upload_product_label

    expect_to_be_on__how_are_items_used_together_page
    expect_back_link_to_upload_item_label_page
    answer_does_contain_items_that_need_to_be_mixed_with "No, the items are used in sequence"

    expect_to_be_on__kit_items_page
    expect_back_link_to_how_are_items_used_together_page
    add_an_item

    expect_to_be_on__what_is_item_called_page
    expect_back_link_to_kit_items_page
    answer_item_name_with "SkinSoft strawberry blonde hair colourant"

    expect_to_be_on__is_item_available_in_shades_page(item_name: "SkinSoft strawberry blonde hair colourant")
    expect_back_link_to_what_is_item_called_page
    answer_is_item_available_in_shades_with "No", item_name: "SkinSoft strawberry blonde hair colourant"

    expect_to_be_on__physical_form_of_item_page(item_name: "SkinSoft strawberry blonde hair colourant")
    expect_back_link_to_is_item_available_in_shades_page
    answer_what_is_physical_form_of_item_with "Liquid", item_name: "SkinSoft strawberry blonde hair colourant"

    expect_to_be_on__what_is_product_contained_in_page(item_name: "SkinSoft strawberry blonde hair colourant")
    expect_back_link_to_physical_form_of_item_page
    answer_what_is_product_contained_in_with("A pressurised container, an impregnated sponge, wipe, patch or pad, or is encapsulated",
                                             item_name: "SkinSoft strawberry blonde hair colourant")

    expect_to_be_on__what_type_of_applicator_page
    expect_back_link_to_what_is_product_contained_in_page
    answer_what_type_of_applicator_with "Pressurised spray"

    expect_to_be_on__does_item_contain_cmrs_page
    expect_back_link_to_what_type_of_applicator_page
    answer_does_item_contain_cmrs_with "No", item_name: "SkinSoft strawberry blonde hair colourant"

    expect_to_be_on__does_item_contain_nanomaterial_page
    expect_back_link_to_does_item_contain_cmrs_page
    answer_does_item_contain_nanomaterials_with "No", item_name: "SkinSoft strawberry blonde hair colourant"

    expect_to_be_on__item_category_page
    expect_back_link_to_does_item_contain_nanomaterial_page
    answer_item_category_with "Hair and scalp products"

    expect_to_be_on__item_subcategoy_page(category: "hair and scalp products", item_name: "SkinSoft strawberry blonde hair colourant")
    expect_back_link_to_item_category_page
    answer_item_subcategory_with "Hair colouring products"

    expect_to_be_on__item_sub_subcategory_page(subcategory: "hair colouring products", item_name: "SkinSoft strawberry blonde hair colourant")
    expect_back_link_to_item_category_page("hair_and_scalp_products")
    answer_item_sub_subcategory_with "Oxidative hair colour products"

    expect_to_be_on__formulation_method_page item_name: "SkinSoft strawberry blonde hair colourant"
    expect_back_link_to_item_category_page("hair_colouring_products")
    answer_how_do_you_want_to_give_formulation_with("Choose a predefined frame formulation",
                                                    item_name: "SkinSoft strawberry blonde hair colourant")

    expect_to_be_on__frame_formulation_select_page
    expect_back_link_to_formulation_method_page
    give_frame_formulation_as "Hair Colorant (Permanent, Oxidative Type) - Type 1 : Two Components - Colorant Part"

    expect_to_be_on__poisonous_ingredients_page
    expect_back_link_to_frame_formulation_select_page
    answer_does_product_contain_poisonous_ingredients_with "No"

    expect_to_be_on__what_is_ph_range_of_product_page
    expect_back_link_to_poisonous_ingredients_page
    answer_what_is_ph_range_of_product_with "It does not have a pH"

    expect_to_be_on__kit_items_page
    expect_back_link_to_what_is_ph_range_of_product_page
    add_an_item

    expect_to_be_on__what_is_item_called_page
    expect_back_link_to_kit_items_page
    answer_item_name_with "SkinSoft strawberry blonde hair fixer"

    expect_to_be_on__is_item_available_in_shades_page(item_name: "SkinSoft strawberry blonde hair fixer")
    expect_back_link_to_what_is_item_called_page
    answer_is_item_available_in_shades_with "No", item_name: "SkinSoft strawberry blonde hair fixer"

    expect_to_be_on__physical_form_of_item_page item_name: "SkinSoft strawberry blonde hair fixer"
    expect_back_link_to_is_item_available_in_shades_page
    answer_what_is_physical_form_of_item_with "Liquid", item_name: "SkinSoft strawberry blonde hair fixer"

    expect_to_be_on__what_is_product_contained_in_page(item_name: "SkinSoft strawberry blonde hair fixer")
    expect_back_link_to_physical_form_of_item_page
    answer_what_is_product_contained_in_with("A pressurised container, an impregnated sponge, wipe, patch or pad, or is encapsulated",
                                             item_name: "SkinSoft strawberry blonde hair fixer")

    expect_to_be_on__what_type_of_applicator_page
    expect_back_link_to_what_is_product_contained_in_page
    answer_what_type_of_applicator_with "Pressurised spray"

    expect_to_be_on__does_item_contain_cmrs_page
    expect_back_link_to_what_type_of_applicator_page
    answer_does_item_contain_cmrs_with "No", item_name: "SkinSoft strawberry blonde hair fixer"

    expect_to_be_on__does_item_contain_nanomaterial_page
    expect_back_link_to_does_item_contain_cmrs_page
    answer_does_item_contain_nanomaterials_with "No", item_name: "SkinSoft strawberry blonde hair fixer"

    expect_to_be_on__item_category_page
    expect_back_link_to_does_item_contain_nanomaterial_page
    answer_item_category_with "Hair and scalp products"

    expect_to_be_on__item_subcategoy_page(category: "hair and scalp products", item_name: "SkinSoft strawberry blonde hair fixer")
    expect_back_link_to_item_category_page
    answer_item_subcategory_with "Hair colouring products"

    expect_to_be_on__item_sub_subcategory_page(subcategory: "hair colouring products", item_name: "SkinSoft strawberry blonde hair fixer")
    expect_back_link_to_item_category_page("hair_and_scalp_products")
    answer_item_sub_subcategory_with "Oxidative hair colour products"

    expect_to_be_on__formulation_method_page item_name: "SkinSoft strawberry blonde hair fixer"
    expect_back_link_to_item_category_page("hair_colouring_products")
    answer_how_do_you_want_to_give_formulation_with("Choose a predefined frame formulation",
                                                    item_name: "SkinSoft strawberry blonde hair fixer")

    expect_to_be_on__frame_formulation_select_page
    expect_back_link_to_formulation_method_page
    give_frame_formulation_as "Hair / Scalp Care Lotion"

    expect_to_be_on__poisonous_ingredients_page
    expect_back_link_to_frame_formulation_select_page
    answer_does_product_contain_poisonous_ingredients_with "No"

    expect_to_be_on__what_is_ph_range_of_product_page
    expect_back_link_to_poisonous_ingredients_page
    answer_what_is_ph_range_of_product_with "It does not have a pH"

    expect_to_be_on__kit_items_page
    expect_back_link_to_what_is_ph_range_of_product_page
    click_button "Continue"

    expect_to_be_on__check_your_answers_page(product_name: "SkinSoft strawberry blonde hair dye")
    expect_back_link_to_kit_items_page

    expect_check_your_answers_page_for_kit_items_to_contain(
      product_name: "SkinSoft strawberry blonde hair dye",
      number_of_components: "2",
      components_mixed: "No",
      kit_items: [
        {
          name: "SkinSoft strawberry blonde hair colourant",
          shades: "None",

          nanomaterials: "None",
          category: "Hair and scalp products",
          subcategory: "Hair colouring products",
          sub_subcategory: "Oxidative hair colour products",
          formulation_given_as: "Frame formulation",
          physical_form: "Liquid",
          ph: "No pH",
          poisonous_ingredients: "No",
        },
        {
          name: "SkinSoft strawberry blonde hair fixer",
          shades: "None",

          nanomaterials: "None",
          category: "Hair and scalp products",
          subcategory: "Hair colouring products",
          sub_subcategory: "Oxidative hair colour products",
          formulation_given_as: "Frame formulation",
          physical_form: "Liquid",
          ph: "No pH",
          poisonous_ingredients: "No",
        },
      ],
    )
    click_button "Accept and submit"

    expect_to_be_on__your_cosmetic_products_page
    expect_to_see_message "SkinSoft strawberry blonde hair dye notification submitted"
  end
end
