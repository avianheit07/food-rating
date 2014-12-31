app.controller "MenusCtrl",[
  "$http"
  "$log"
  "$scope"
  "utils"
  ($x, $log, $s, utils)->
    $s.menus = []
    $s.activeMenu =
      date: new Date()
      foods:[]
      default: null
    # checks if user is loggedin and get its data
    $s.user = null

    $x.get "/auth/logged"
    .success (data)->
      $s.user = data.session

    # get all food menu for this week
    $x.get "/menu/latest"
    .success (data)->
      $s.menus = data
      $s.menus.forEach (m)->
        m.date = new Date m.date

    # join/subscribe to latest menu updates
    io.socket.get "/menu/latest"

    # listen to updates in menu
    io.socket.on "menu/latest",(menu)->
      obj = menu
      obj = menu[0] if menu.length

      idx = utils.getIndexById obj.id,$s.menus
      obj.date = new Date obj.date
      $s.menus.push obj if idx is -1
      $s.menus[idx] = obj if idx > -1
      $s.$digest()

    $s.minDate = new Date()
    $s.minDate.setDate($s.minDate.getDate()+1)

    $s.newFood = ""
    $s.edit = (menu)->
      $s.activeMenu = menu

    $s.new = ->
      $s.activeMenu =
        date: new Date()
        foods:[]
        default: null
    $s.addFood = ->
      if $s.newFood
        $s.activeMenu.foods.push name:$s.newFood

      $s.newFood = ""

    $s.save = ->
      type = (if $s.activeMenu.id then "put" else "post")
      obj = angular.fromJson angular.toJson $s.activeMenu
      io.socket[type] "/menu/save",obj,(resData,jwres)->
        $s.activeMenu = resData
    return
]