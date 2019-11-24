debug = true

skippableBlocks={
  "BiomesOPlenty:foliage",
  "minecraft:tallgrass"
}

height = 0
location = "0:0"

--needs to be global to add to table obj
function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

--debug print function set global to false
function debugPrint(s)
  if debug then
    print(s)
  end
end

function touchDown()
  debugPrint("start touchDown")
  fly=0
  down=0
  while (fly < 1) do
    if not move(turtle.down, turtle.inspectDown) then
      fly=1
    end
  end
  return true
end

function climbForward()
  debugPrint("start climbForward")
  advanced = false
  advanced, block = move(turtle.forward, turtle.inspect)
  while not advanced do
    bool, block = move(turtle.up, turtle.inspectUp)
    if not bool then
      return false
    end
    advanced, block = move(turtle.forward, turtle.inspect)
  end
  return true
end

function move(mvtFunc, inspectFunc)
  debugPrint("move function")
  success, block = inspectFunc()
  if not success or table.contains(skippableBlocks, block["name"]) then
    if mvtFunc == turtle.up then
      height = height+1
    end
    if mvtFunc == turtle.down then
      height = height-1
    end
    return mvtFunc()
  else
    return false
  end
end

function travel(dest)
  dest = dest
end

function surveyTerrain(size)
--TODO: Another for loop for y
  debugPrint(string.format("Strating to survey terrain for %s ^2", size))
  map = {}
  map[location] = height
  for x=1,size do
    if not climbForward() then
      print("stuck climbing, exiting")
      exit()
    end
    touchDown()
    map[string.format("0:%s", x)] = height
  end
  return map
end

terrainMap = surveyTerrain(3)
for key,value in pairs(terrainMap) do
  print(string.format("%s - %s", key, value))
end
