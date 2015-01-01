app.controller "MenusCtrl",[
  "$http"
  "$log"
  "$scope"
  "utils"
  ($x, $log, $s, utils)->
    $s.activeMenu = null
    $s.selected = (index)->
      return index is $s.activeMenu
    $s.select = (index)->
      value = null
      value = index if index isnt $s.activeMenu
      $s.activeMenu = value
    $s.commentTest = false

    $s.menus = []

    # get all food menu for this week
    $x.get "/menu/latest"
    .success (data)->
      $s.menus = data
      $s.menus.forEach (menu)->
        $s.orderCount menu

    # join/subscribe to latest menu updates
    io.socket.get "/menu/latest"

    # listen to updates in menu
    io.socket.on "menu/latest",(menu)->
      menu = menu[0] if Array.isArray menu
      if !menu.menu
        # menu object
        obj = menu
        obj = menu[0] if menu.length

        idx = utils.getIndexById obj.id,$s.menus
        obj.date = new Date obj.date
        $s.menus.unshift obj if idx is -1
        $s.menus[idx] = obj if idx > -1
      else
        # an order object
        order = menu

        menuIdx = utils.getIndexById order.menu,$s.menus
        console.log menuIdx,order,$s.menus
        idx = utils.getIndexById order.id,$s.menus[menuIdx].orders

        $s.menus[menuIdx].orders[idx] = order if idx > -1
        $s.menus[menuIdx].orders.push order if idx is -1

        $s.orderCount $s.menus[menuIdx]
      $s.$digest()

    $s.orderCount = (menu)->
      menu.foods.forEach (food)->
        food.orders = 0
        food.rating = 0
      if menu.orders.length
        menu.orders.forEach (o)->
          menu.foods[o.food].orders+=1
          avg = 0
          add = menu.foods[o.food].rating

          if add > 0
            avg = Math.ceil((o.rating+add)/2)
          else
            avg = o.rating

          menu.foods[o.food].rating = avg if avg > 0
          return

      return
    return
]