# frozen_string_literal: true

module IssuesHelper
  def new_issue_button(line: nil, stop: nil)
    line ||= stop&.lines&.first
    link_to("Report
    Issue",
      new_issue_path(line_id: line&.id, stop_id: stop&.id),
      id: "create-issue-#{stop&.id}", class: "create-issue"
    )
  end
end
