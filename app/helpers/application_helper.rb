module ApplicationHelper
  def full_title(page_title)
    base_title = "Platforma ePUEPS"

    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  # TODO: Merge theese two methods into one
  def admin_title(page_title)
    base_title = "Platforma ePUEPS (admin)"

    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def sign_in_out_link
    if user_signed_in?
      link_to "Wyloguj się", destroy_user_session_path, method: :delete
    else
      link_to "Zaloguj się", new_user_session_path
    end
  end

  def sortable(object, column, title = nil)
    title ||= column.titleize

    css_class = column == sort_column ? "current #{sort_direction}" : nil
    dir = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, { sort: column, direction: dir }, class: css_class
  end

  def sort_column
    params[:sort]
  end

  def sort_direction
    params[:direction]
  end

  
end
