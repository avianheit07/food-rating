app.controller "MenusCtrl",[
  "$scope"
  ($s)->
    $s.score = null
    ###
      to listen:
      menus
    ###
    $s.menus = []

    # TEST
    $s.menus.push {
      id: 'TEST'
      date:'2014-12-31T00:00:00+00:00'
      foods:[
        {
          name: "Ginisang Betlog sa Tula-Tula"
        }
        {
          name: "Humba na Pata ng Baby"
        }
        {
          name: "Ginaling na Tokwa ng Baboy"
        }
        {
          name: "Tinolang Bakang may Chickend"
        }
      ]
    }

    
    # a list of orders made by this user for the specific date range determind by server
    $s.orders = []

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
      return
    $s.selected = (index,menuIndex)->
      test = $s.orders[menuIndex].food is index
      return test
    #return boolean if whether it the food was likely eaten already or not
    $s.eaten = (date)->
      current = new Date()
      toTest = new Date date
      return !(toTest > current)
    return
]