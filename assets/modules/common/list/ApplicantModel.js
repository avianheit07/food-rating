app.factory("APPLICANT",[
  "$resource",
  function($resource){
    return $resource("/applicant/:idAction:listAction/:id",{id:'@id'},{
      create:{
        method:"POST",
        params:{
          idAction:"create"
        },
        isArray: false
      },
      find:{
        method:"GET",
        params:{
          idAction:"find"
        },
        isArray: false
      },
      query:{
        method:"GET",
        params:{
          listAction:"query"
        },
        isArray: true
      }
    })
  }
])