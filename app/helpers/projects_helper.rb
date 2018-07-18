module ProjectsHelper
  def status_class(status)
    case status
    when Project::Status::NEW
      "is-dark"
    when Project::Status::UNDER_PROGRESS
      "is-warning"
    when Project::Status::DONE
      "is-success"
    when Project::Status::CANCELED
      "is-danger"
    else
      ""
    end
  end
end
