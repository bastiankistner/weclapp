module.exports =
  
  buildQueryString: (opts = {}) ->
    {where, whereOperator, sort, page, perPage, expand} = _.defaults opts,
      where: []
      whereOperator: 'and'
      sort: []
      expand: [] 