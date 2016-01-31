exports.index = (req, res)->
  Lotery.find().exec (error, result)->
    res.ok result

exports.updateData = (req, res)->
  Lotery.updateDate()
  sails.log.info 'ok'
  res.ok 'ok'




