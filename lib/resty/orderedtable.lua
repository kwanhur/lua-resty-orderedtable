-- Copyright (C) 2016 Kwanhur (huang_hua2012@163.com).
-- lua-resty-orderedtable -  an ordered table with sorted index
-- https://github.com/Kwanhur/lua-resty-orderedtable

local _M = { _VERSION = '0.0.1' }
local mt = { __index = _M }

_M.new = function(self, reverse, indexType)
    if reverse then
        self._cmp = function(x, y) return x > y end
    else
        self._cmp = function(x, y) return x < y end
    end
    self._indexType = indexType or "string"

    self._sortedTable = {}
    return setmetatable(self, mt)
end

_M.add = function(self, key, value)
    if type(key) == self._indexType then
        local sortedTable = self._sortedTable
        if not value then
            local index, _ = self:find(key)
            if index then
                table.remove(sortedTable, index)
            end
        else
            -- update or insert new k-v
            local index, _ = self:find(key)
            if index then
                sortedTable[index] = { key, value }
            else
                local ind = self:insert({ key, value })
            end
        end
    end
end

_M.value = function(self, key)
    if type(key) == self._indexType then
        local index, value = self:find(key)
        if index then
            return value[2]
        end
    end
end

_M.insert = function(self, keyValueTable)
    local sortedTable = self._sortedTable
    local startIndex, endIndex, midIndex, flag = 1, #sortedTable, 1, 0
    -- flag for marking index before or after midIndex
    while startIndex <= endIndex do
        midIndex = math.floor((startIndex + endIndex) / 2)
        if self._cmp(keyValueTable[1], sortedTable[midIndex][1]) then
            endIndex = midIndex - 1
            flag = 0
        else
            startIndex = midIndex + 1
            flag = 1
        end
    end
    local index = midIndex + flag
    table.insert(sortedTable, index, keyValueTable)
    return index
end

_M.pairs = function(self)
    return self.next, self
end

_M.next = function(self, index)
    index = index or 0
    index = index + 1
    local value = self._sortedTable[index]
    if value then
        return index, value[1], value[2]
    end
end

_M.slice = function(self, first, last, step)
    if last > #self._sortedTable then
        return self
    end

    local sliced = {}
    for index = first or 1, last, step or 1 do
        sliced[index] = self._sortedTable[index]
    end
    self._sortedTable = sliced
    return self
end

_M.find = function(self, key)
    local sortedTable = self._sortedTable
    local startIndex, endIndex, midIndex = 1, table.getn(sortedTable), 1
    -- binary search
    while startIndex <= endIndex do
        midIndex = math.floor((startIndex + endIndex) / 2)
        local cmpKey = sortedTable[midIndex][1]
        if key == cmpKey then
            return midIndex, sortedTable[midIndex]
        end

        if self._cmp(key, cmpKey) then
            endIndex = midIndex - 1
        else
            startIndex = midIndex + 1
        end
    end
end

_M.count = function(self)
    return table.maxn(self._sortedTable)
end

return _M