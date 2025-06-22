AddEventHandler('tp_libs:getSharedObject', function(cb)
  cb(TP)
end)

exports('getSharedObject', function()
  return TP
end)
