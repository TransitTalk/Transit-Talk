# frozen_string_literal: true

module IssuesHelper
  def new_issue_button(line: nil, stop: nil)
    line ||= stop&.lines&.first
    link_to("Report\nIssue",
      new_issue_path(line_id: line&.id, stop_id: stop&.id),
      id: "create-issue-#{stop&.id}", class: "create-issue",
      aria: { label: unless stop.nil? then "Report issue at " + stop.name else "Report issue" end }
    )
  end
end
