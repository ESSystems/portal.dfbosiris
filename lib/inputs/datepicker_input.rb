class DatepickerInput < Formtastic::Inputs::StringInput
  
  def input_html_options
    datepicker_class = options[:display_menus] ? "datepicker-with-menus" : "datepicker"
    super.merge(:class => datepicker_class)
  end
  
end