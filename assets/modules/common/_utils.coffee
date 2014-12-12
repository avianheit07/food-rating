app.service "utils",[
  ->
    @getIndexByProperty = (value,prop,list)->
      idx = -1
      if list.length
        idx = list.map (l)->
          return l[prop]
        .indexOf value
      return idx

    @getIndexById = (id,list)->
      idx = -1
      if list.length
        idx = @getIndexByProperty id,"id",list
      return idx
    return
]