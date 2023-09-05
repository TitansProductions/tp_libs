AddEventHandler('tp_libs:getSharedObject', function(cb)
  local Invoke = GetInvokingResource()
  cb(TP)
end)

exports('getSharedObject', function()
  return TP
end)
