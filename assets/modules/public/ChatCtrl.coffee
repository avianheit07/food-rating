app.controller "ChatCtrl",[
  "$http"
  "$log"
  "$scope"
  ($x, $log, $s)->
    room = '/test/subscribe/5489bb2acc7452061fdc5078'
    roomTerm = '/test/terminate/5489bb2acc7452061fdc5078' 
    $s.test = null
    $s.child = {}
    io.socket.get room

    $x.get room
    .success (data)->
      $s.test = data

    $s.addChild = ->
      $s.test.children = [] if !Array.isArray($s.test.children)
      $s.test.children.push $s.child

      io.socket.put room,$s.test,(resData,jwres)->
        console.log resData,jwRes

      $s.child = {}

    io.socket.on 'test',(obj)->
      if obj.verb is 'updated'
        $s.test = obj.data
        $s.$digest()

    $s.save = ->
      io.socket.put room,$s.test,(resData,jwres)->
        console.log resData,jwRes

    $s.terminate = ->
      io.socket.get roomTerm
    return
]