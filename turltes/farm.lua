skippableBlocks={
  "BiomesOPlenty:foliage"
  "minecraft:tallgrass"
}

height = 0

--needs to be global to add to table obj
function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

local function touchDown()
  fly=0
  down=0
  print("Checking if we go down")
  while (fly < 1) do
    if move(turtle.down) then
      down=down+1
    else
      fly=1
    end
  end
  return true, down
end

local function move(mvtFunc, inspectFunc)
  success, block = inspectFunc()
  if not success or table.contains(skippableBlocks, block["name"]) then
    if mvtFunc == turtle.up then
      height = height+1
    end
    if mvtFunc == turtle.down then
      height = height-1
    end
    mvtFunc()
  else
    return false
  end
end

local function surveyTerrain(size)
--TODO: Another for loop for y
  map = {}
  for x=size,0,-1 do
    if not move(turtle.forward, turtle.inspect) then
      print("can't start facing something turtles can't move into")
      exit()
    end
    isDown, downCount = touchdown()
    map[string.format("0:%s", x)] = downCount
  end
  return map
end

local function farm(size)
  x=0
  y=0
  while(x < size and y < size) do
  end
end

terrainMap = surveyTerrain(9)
