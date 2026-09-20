
local _, addon = ...

--------------------------------------------------------------------------------
-- Ring Buffer
--------------------------------------------------------------------------------

local RingBuffer = {}
RingBuffer.__index = RingBuffer

function RingBuffer:New(size)
    return setmetatable({
        size = size,
        data = {},
        next = 1,
        count = 0,
    }, RingBuffer)
end

function RingBuffer:Add(value)
    self.data[self.next] = value

    self.next = self.next + 1
    if self.next > self.size then
        self.next = 1
    end

    if self.count < self.size then
        self.count = self.count + 1
    end
end

function RingBuffer:GetCount()
    return self.count
end

function RingBuffer:GetData()
    return self.data
end

addon.RingBuffer = RingBuffer