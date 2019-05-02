module CategoryHelper
  def full_category_display_name(component)
    component.display_root_category + ", " + \
      component.display_sub_category + ", " + \
      component.display_sub_sub_category
  end

  def get_full_category_name(sub_sub_category)
    sub_category = Component.get_parent_category(sub_sub_category.to_sym)
    "#{get_category_name(sub_category)} - #{get_category_name(sub_sub_category)}"
  end

  def get_main_categories
    parent_of_categories = Component.get_parent_of_categories
    Component.categories.reject { |category| parent_of_categories[category.to_sym].present? }
  end

  def get_sub_categories category
    Component.get_parent_of_categories.select { |_key, value| value == category.to_sym }
  end

  def sub_category_belongs_to_category(sub_category, category)
    return false if sub_category.nil?

    parent_category = Component.get_parent_category(sub_category)
    sub_category.to_sym == category.to_sym || sub_category_belongs_to_category(parent_category, category)
  end

  def has_sub_categories(category)
    get_sub_categories(category).any?
  end
end
