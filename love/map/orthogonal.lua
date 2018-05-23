map =
{
    width = 20,
    height = 20,
    tile =
    {
        width = 32,
        height = 32
    },
    view =
    {
        x = 1,
        y = 1,
        width = 16,
        height = 10
    },
    zoom =
    {
        x = 1,
        y = 1
    },
    batch = nil,
    data =
    {
       {3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 0, 2, 2, 2, 0, 3, 0, 3, 0, 1, 1, 1, 0, 0, 0, 0, 0},
       {0, 0, nil, 0, 2, 0, 2, 0, 3, 0, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 1, 2, 2, 2, 2, 0, 0, 3, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0},
       {0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 2, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0},
       {0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 1, 0, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
       {0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 0, 0, 0, 0, 0, 0},
       {0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0},
       {0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0},
       {0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 2, 2, 0, 0, 0, 0},
       {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},

    },
    new = function ()
        map.batch = love.graphics.newSpriteBatch(terrain.image, map.view.width * map.view.height)
    end,
    update = function ()
        map.batch:clear()
        for y=0, math.min(map.view.height,map.height-1) do
            for x=0, math.min(map.view.width,map.width-1) do
                print (y+math.floor(map.view.y).." "..x+math.floor(map.view.x))
                if map.data[y+math.floor(map.view.y)]~=nill and map.data[y+math.floor(map.view.y)][x+math.floor(map.view.x)]~=nil then
                    map.batch:add (
                            terrain.tiles [map.data[y+math.floor(map.view.y)][x+math.floor(map.view.x)]].quad,
                        x*map.tile.width,y*map.tile.height
                        )
                end
            end
        end
        map.batch:flush()
    end,
    move = function (x, y)
        if x~=0 and map.width<=map.view.width then return end
        if y~=0 and map.height<=map.view.height then return end
        old = {x=map.view.x, y=map.view.y}
        map.view.x = math.max(math.min(map.view.x + x, map.width - map.view.width), 1)
        map.view.y = math.max(math.min(map.view.y + y, map.height - map.view.height), 1)
        -- only update if we actually moved
        if math.floor(map.view.x) ~= math.floor(old.x) or math.floor(map.view.y) ~= math.floor(old.y) then
            map.update()
        end
        print (map.view.x..", "..map.view.y)
    end
}
