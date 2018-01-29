module ApplicationHelper
  include SessionsHelper
  include AppliedsHelper
  include JobsHelper
	# Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Job App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def custom_form(object, path, label_name, name, submit_name)    
    form_for object, url: path do |f|
      result = capture do
        tag.div class: "form-group" do
          concat f.label name, label_name
          concat f.text_field name, class: "form-control"
        end
      end
      result += f.submit submit_name, class: "btn-primary form-control"
    end
  end

end

