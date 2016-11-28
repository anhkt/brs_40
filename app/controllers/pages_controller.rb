class PagesController < ApplicationController
  
  def show
    @activities = Activity.desc.take Settings.take_book
    @books = Book.publish_date_order_desc.take Settings.take_book
    if valid_page?
      render template: "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist? Pathname.new Rails.root +
      "app/views/pages/#{params[:page]}.html.erb"
  end
end
