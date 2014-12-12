app.controller "SummaryCtrl",[
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


    ###room = '/test/subscribe/'
    roomTerm = '/test/terminate/'
    $s.active = null

    $s.tests = []
    $s.child = {}
    io.socket.get room

    getIdx = (obj,prop,list)->
      i = -1
      if obj and prop and list and list.length
        i = list.map (e)->
          return e[prop]
        .indexOf obj[prop]
      return i
    $s.sampleItemOn = (obj)->
      if obj.id
        i = getIdx(obj,'id',$s.tests)
        $s.tests[i] = obj
        $s.$digest()
      return

    $x.get room
    .success (data)->
      $s.tests = data
      $s.tests.forEach (test)->
        nr = room+test.id
        io.socket.get nr,$s.sampleItemOn
        io.socket.on "test/"+test.id,$s.sampleItemOn

    $s.addChild = ->
      $s.tests[$s.active].children = [] if !Array.isArray($s.tests[$s.active].children)
      $s.tests[$s.active].children.push $s.newChild
      $s.newChild = {}

    io.socket.on 'test/all',(obj)->
      idx = getIdx(obj,'id',$s.tests)
      if idx > -1
        $s.tests[idx] = obj
      else
        $s.tests.push obj
      $s.$digest()

    $s.select = (idx)->
      $s.active = idx
      console.log $s.active

    $s.addTest = ->
      obj =
        name:"New Test"
        children:[]
      $s.active = $s.tests.length
      $s.tests.push obj

    $s.save = ->
      if $s.active > -1
        type = (if $s.tests[$s.active].id then "put" else "post")
        obj = angular.fromJson angular.toJson $s.tests[$s.active]
        io.socket[type] room,obj,(resData,jwres)->
          console.log resData,jwres###
    return
]