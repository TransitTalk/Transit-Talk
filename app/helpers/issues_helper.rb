module IssuesHelper
  def new_issue_button(line: nil, stop: nil)
    line ||= stop&.lines&.first
    link_to(
      content_tag(:div, '', class: 'create-issue'),
      new_issue_path(line_id: line&.id, stop_id: stop&.id),
    )
  end
end
