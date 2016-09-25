module ActiveAdmin
  module Views
    class Footer < Component

      def build
        super :id => "footer"                                                    
        super :style => "text-align: left;"                                     

        div do                                                                   
          small "&copy; ARISE Church #{Date.today.year}".html_safe                                       
          small "Any issues? Email <a href'mailto:cam.hovell@arisechurch.com'>cam.hovell@arisechurch.com".html_safe
        end
      end

    end
  end
end