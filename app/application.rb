class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  #create @@create to hold items in cart
  #create new route called /cart to show items in cart
  #create new route called /add - takes GET with key item. check if item is in @@items, then add in cart, else error

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/cart/)
      if @@cart.empty?
          resp.write "Your cart is empty"
        else
        @@cart.each do |c|
          resp.write "#{c}\n"
      end
  #   end
  #
  # elsif req.path.match(/add/)
  #   if @@items.include?(item)
  #     @@cart << item
      else
        resp.write "We don't have that item"
    end
  end

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end


end
