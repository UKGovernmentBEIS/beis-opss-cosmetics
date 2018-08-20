module ProductsHelper
  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(
      :gtin, :name, :description, :model, :batch_number, :url_reference, :brand, :serial_number,
      :manufacturer, :country_of_origin, :date_placed_on_market, :associated_parts,
      images_attributes: %i[id title url _destroy]
    )
  end

  # If the user supplies a barcode and it matches, then just return that.
  # Otherwise use the general query param
  def advanced_product_search(page_size)
    gtin_search_results = search_for_gtin(page_size) if params[:gtin].present?
    # if there was no GTIN param or there were no results for the GTIN search
    basic_search_results = search_for_products(page_size) if gtin_search_results.blank? && params[:q].present?
    basic_search_results || gtin_search_results || []
  end

  def search_for_products(page_size)
    if params[:q].blank?
      Product.paginate(page: params[:page], per_page: page_size)
    else
      Product.search(params[:q]).paginate(page: params[:page], per_page: page_size).records
    end
  end

  def search_for_gtin(page_size)
    Product.search(query: { match: { gtin: params[:gtin] } })
           .paginate(page: params[:page], per_page: page_size).records
  end
end
