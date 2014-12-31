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
    

    # TEST
    $s.orders.push {
      id:"TEST"
      menu:"TEST"
      user:"TEST"
      comment:""
    }
    $s.select = (index,menuIndex)->
      $s.orders[menuIndex].food = index
      # then SAVE
      type = (if $s.orders[menuIndex].id then "put" else "post")

      obj = angular.fromJson angular.toJson $s.orders[menuIndex]
      io.socket[type] "/order/save",obj,(resData,jwres)->
        for key in resData
          $s.orders[menuIndex][key] = resData[key]
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

    $s.schedule = null
    $s.edit = (schedule)->
      $s.schedule = null

      if schedule
        $s.schedule = schedule
        $s.schedule.date = new Date schedule.date
      else
        $s.schedule =
          date: new Date()
          foods:[
            name:""
          ]
      return

    $s.save = (obj)->
      type = (if obj.id then "put" else "post")
      obj = angular.fromJson angular.toJson obj
      io.socket[type] "/menu/save",obj,(resData,jwres)->
        for key in resData
          obj[key] = resData[key]
      return
    return
]