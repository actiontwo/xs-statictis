module.exports =
  attributes :
    date : 'datetime'
    type : 'integer'
    province : 'string'
    value : 'string'
  updateDate : ()->
    data = []
    _.map RssService.provinces(), (item)->
      fn = (cb) ->
        options =
          url : "#{RssService.router}#{item.url}"
          method : "GET"
        handleRequest = (error, response, body)->
          return cb null, [] if error

          cb null, RssService.formatData body, item.slug
        #end handleRequest
        _request options, handleRequest
      #end Fn
      data.push fn

    done = (error, result)->
      if error
        return sails.log.error error
      result = _.flatten result
      Lotery.findOrCreate(result).exec
    #end done
    async.parallel data, done
