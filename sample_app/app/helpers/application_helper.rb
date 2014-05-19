module ApplicationHelper
  
  # Returns the full title on a per-page basis.
    def full_title(page_title)
      base_title = "Sample App"
      if page_title.empty?
        base_title
      else
        "#{base_title} | #{page_title}"
      end
    end
    
    #  to display flash messages with the alert styles. 
    def flash_class(level)
        case level
            when "notice" then "warning"
            when "success" then "success"
            when "error" then "danger"
            when "alert" then "danger"
        end
    end 
    
end
