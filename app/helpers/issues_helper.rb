module IssuesHelper
  def new_issue_button(line: nil, stop: nil)
    line ||= stop&.lines&.first
    link_to(
      content_tag(:div, '', class: 'create-issue'),
      new_issue_path(line_id: line&.id, stop_id: stop&.id),
    )
  end

  def new_issue_button_a
    link_to(
      content_tag(:div, '', class: 'create-issue-a'),
      report_a_path
    )
  end

  def new_issue_button_b
    link_to(
      content_tag(:div, '', class: 'create-issue-b'),
      report_b_path
    )
  end
end
