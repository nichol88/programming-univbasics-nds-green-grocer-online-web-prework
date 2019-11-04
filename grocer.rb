def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  # in: string and AoH
  # ret: matching Hash if name appears in collection
  count = 0
  while count < collection.length
    if collection[count][:item] == name
      return collection[count]
    else
      nil
    end
    count += 1
  end

end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  count = 0
  result = []
  puts "Consolidating cart..."
  while count < cart.length
    #puts count
    #puts "Searching for: " + cart[count][:item]
    # run previous method to check existence of item
    item = find_item_by_name_in_collection(cart[count][:item], result)
    #puts "Item: #{item}"
    if !item # if current item doesn't exist in our array
      # add it
      #puts "Not found."
      #puts "Updating cart count (#{cart[count][:count]})"
      cart[count][:count] = 1
      #puts "New value: #{cart[count][:count]}"
      #puts "Adding to result array"
      result.push(cart[count])
      #puts "New result array:"
      #puts result
    else # if item exists in our array
      #puts "Item found. Checking for :count key"
      if item[:count] #check for :count key
        #puts "Found (#{item[:count]}). Incrementing by 1"
        item[:count] = item[:count] + 1
        #puts "New value: #{item[:count]}"
      else
        #puts "No :count key found. Adding and assigning to 1."
        item[:count] = 1
      end
    end
    count += 1
  end
  result
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  #puts "Input cart::" #
  #puts cart
  #puts "Input coupons::"
  #puts coupons

  # for each coupon, see if it applies
  coupon_index = 0

  while coupon_index < coupons.length
    cur_coup = coupons[coupon_index]

        #puts "Current coupon: #{coupon_index}"
        #puts cur_coup
    applicable_item = find_item_by_name_in_collection(coupons[coupon_index][:item], cart)
        #puts "Applicable item?:"
        #puts applicable_item
    if applicable_item && applicable_item[:count] >= cur_coup[:num] # if coupon appllies to an item, do stuff
      # subtract coupon's :num from :count of applicable_item
      applicable_item[:count] = applicable_item[:count] - cur_coup[:num]
      # add couponed item to cart with appropriate keys
        #  puts "applicable_item after subtracting couponed items:"
        #  puts applicable_item

        #  puts "Cart before adding couponed item"
        #  puts cart
      cart.push({
      :item => "#{cur_coup[:item]} W/COUPON",
      :price => cur_coup[:cost] / cur_coup[:num],
      :clearance => applicable_item[:clearance],
      :count => cur_coup[:num]
      #:cost => cur_coup[:cost]

      })
    #  puts "Cart AFTER adding couponed item"
    #  puts cart

      #if applicable_item[:count] == 0
      #  puts "Item count reduced to zero. removing #{applicable_item[:item]}"
      #  cart.delete(applicable_item)
      #  puts
      #  puts cart
      #end

    else
    #  puts "Coupon does not apply to any items in cart."
    end
    coupon_index += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  count = 0
  while count < cart.length
    if cart[count][:clearance]
      cart[count][:price] = cart[count][:price] * 0.8
    end
    count += 1
  end
    cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  puts "CHECKING OUT"
  puts "Cart:"
  puts cart
  puts "Coupons:"
  puts coupons

  consolidate_cart(cart)
  apply coupons(cart, coupons)
  apply_clearance(cart)

  count = 0
  total = 0
  while count < cart.length
    line_total = cart[count][:price] * cart[count][:count]
    total += line_total
    count += 1
  end
  total

end
