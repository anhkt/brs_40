module ApplicationHelper
  def full_title page_title = ""
    base_title = t "helpers.base_title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def content action
    case action
    when "review"
      t "activity.review_timeline"
    when "follow"
      t "activity.follow_timeline"
    when "comment"
      t "activity.comment_timeline"
    end
  end
end  
