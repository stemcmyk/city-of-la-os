function tableMap(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        t[k] = f(v, k)
    end
    return t
end

exports("tableMap", tableMap)

function tableMapCallback(tbl, f)
  local newTbl = {}
  
  for k, v in pairs(tbl) do
      local finished = false
      f(v, k, function(mappedValue)
          newTbl[k] = mappedValue
          finished = true
      end)

      local timeElapsed = 0;
      while not finished do
        timeElapsed = timeElapsed + 25
        if (timeElapsed >= 20 * 1000) then
          print("ERROR: tableMapCallback took too long, aborting")
          break
        end
        Wait(25)
      end
  end

  return newTbl;
end

exports("tableMapCallback", tableMapCallback)

function tableMapWithKeys(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        local nk, nv = f(k, v)
        t[nk] = nv 
    end
    return t
end

exports("tableMapWithKeys", tableMapWithKeys)

function tableMerge(...)
    local result = {}

    for i, tbl in ipairs({...}) do
      for k, v in pairs(tbl) do
        if type(k) ~= "number" then
          result[k] = v
        else
          table.insert(result, v)
        end
      end
    end

    return result
end

exports("tableMerge", tableMerge)

function baseFilterFunction(data) 
  return not not data
end

function tableFilter(tbl, filterFunc)
  local result = {}
  for _, v in ipairs(tbl) do
      if filterFunc and filterFunc(v) or baseFilterFunction(v) then
          table.insert(result, v)
      end
  end
  return result
end

exports("tableFilter", tableFilter)

function tableContains(tbl, item)
  for _, value in ipairs(tbl) do
      if value == item then
          return true
      end
  end
  return false
end

exports("tableContains", tableContains)

function tableSort(tbl, func) 
  local newTbl = table.clone(tbl)
  table.sort(newTbl, func)
  return newTbl
end

exports("tableSort", tableSort)

function tableReverse(t)
  local reversedTable = {}
  local itemCount = #t
  
  for i = itemCount, 1, -1 do
      table.insert(reversedTable, t[i])
  end
  
  return reversedTable
end

exports("tableReverse", tableReverse)
