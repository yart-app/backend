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

  def icon_class(auto_generated)
    case auto_generated
    when true
      "fa-arrow-circle-right"
    else
      "fa-first-order-alt"
    end
  end

  def tag_color(value)
    case value
    when Project::Status::CANCELED
      "is-danger"
    when Project::Status::DONE
      "is-success"
    else
      "is-info"
    end
  end

  def post_text_class(auto_generated)
    case auto_generated
    when true
      "has-text-grey-light"
    else
      "has-text-grey"
    end
  end
end
