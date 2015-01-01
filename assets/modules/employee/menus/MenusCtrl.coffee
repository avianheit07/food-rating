app.controller "MenusCtrl",[
  "$scope"
  "$http"
  "utils"
  ($s,$x,utils)->
    # a list of orders made by this user for the specific date range determind by server
    $s.orders = []
    $s.menus = []
    $s.score = null

    $x.get "order/latest"
    .success (orders)->
      $s.orders = orders

      $x.get "/menu/latest"
      .success (menus)->
        $s.menus = menus

        if menus.length
          newOrders = []
          $s.menus.forEach (m,i)->
            oIdx = utils.getIndexByProperty m.id,'menu',$s.orders
            newOrder =
              menu: m.id
            
            newOrder = $s.orders[oIdx] if oIdx > -1

            newOrders[i] = newOrder
            return
          $s.orders = newOrders




    io.socket.get "/menu/latest"

    # listen to updates in menu
    io.socket.on "menu/latest",(menu)->
      menu = menu[0] if Array.isArray menu
      if !menu.menu
        obj = menu
        obj = menu[0] if menu.length

        idx = utils.getIndexById obj.id,$s.menus
        if idx is -1
          $s.menus.unshift obj
          newOrder =
            menu: obj.id
          $s.orders.unshift newOrder
        $s.menus[idx] = obj if idx > -1

        $s.$digest()
      else
        #must be order
        console.log menu
      return

    #select a food then saves it, but also keeps track of past selected food
    $s.select = (menuIndex,index)->
      if ($s.orders[menuIndex].food isnt index) or index is undefined
        type = (if $s.orders[menuIndex].id then "put" else "post")

        if type is "put" and index > -1
          $s.orders[menuIndex].pastSelected = $s.orders[menuIndex].food
        
        $s.orders[menuIndex].food = index if index > -1

        obj = angular.fromJson angular.toJson $s.orders[menuIndex]

        io.socket[type] "/order/save",obj,(resData,jwres)->
          obj = resData
          obj = resData[0] if Array.isArray resData
          angular.forEach obj, (val,key)->
            $s.orders[menuIndex][key] = obj[key]

      return
    $s.selected = (index,menuIndex)->
      test = false
      test = ($s.orders[menuIndex].food is index) if $s.orders[menuIndex]
      return test
    #return boolean if whether it the food was likely eaten already or not
    $s.eaten = (date)->
      current = new Date()
      toTest = new Date date
      return !(toTest > current)

    return
]