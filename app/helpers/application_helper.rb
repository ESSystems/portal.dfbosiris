module ApplicationHelper
  
  def title(page_title)  
    content_for(:title) { page_title }  
  end
  
  # Only need this helper once, it will provide an interface to convert a block into a partial.
  # 1. Capture is a Rails helper which will 'capture' the output of a block into a variable
  # 2. Merge the 'body' variable into our options hash
  # 3. Render the partial with the given options hash. Just like calling the partial directly.
  def block_to_partial(partial_name, options = {}, &block)
    options.merge!(:body => capture(&block))
    render(:partial => partial_name, :locals => options)
  end
 
  # Create as many of these as you like, each should call a different partial 
  def box_widget(title, options = {}, &block)
    block_to_partial('shared/box_widget', options.merge(:title => title), &block)
  end
 
end