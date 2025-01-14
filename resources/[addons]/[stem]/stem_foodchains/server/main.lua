
---@class Business
---@field businessInformation BusinessInformation
---@field registers Register[]
---@field processes Process[] 
---@field inventories Inventory[]
Business = {}
Business.__index = Business
local registeredBusinesses = {}

---@class BusinessInformation
---@field name string
---@field label string
---@field bossGrade string
---@field coords vector3
---@field blip BlipData

--- func desc
---@param businessInformation BusinessInformation
---@return Business
function Business:new(businessInformation) 
    local self = setmetatable({}, Business)

    --- @type BusinessInformation
    self.businessInformation = businessInformation
    self.name = self.businessInformation.name
    --- @type Register[]
    self.registers = {}
    --- @type Process[]
    self.processes = {}
    
    self.stashCount = 0
    self.bossMenu = nil;
    
    --- @type Inventory[]
    self.inventories = {}


    exports.esx_society:registerSociety(self.name, self.name, 'society_'..self.name, 'society_,'..self.name, 'society_'..self.name, { type = 'private' })
    exports.esx_society:setBossGradeName("owner")
    exports.esx_society:setBossGradeName("coowner")

    registeredBusinesses[self.name] = self
    
    return self
end


---@class Register
---@field coords vector

--- func desc
--- @param data Register
function Business:createRegister(data)
    table.insert(self.registers, data)
    return self
end


---@class Item
---@field name string
---@field amount number

---@class ProcessOption 
---@field title string
---@field icon? string
---@field inputItems Item[]
---@field outputItems Item[]

---@class animation
---@field dict string
---@field clip string

---@class Process
---@field coords vector3
---@field standCoords vector3
---@field options ProcessOption[]
---@field anim Animation
---@field customerAccessible? boolean

--- func desc
--- @param data Process
function Business:createProcess(processId, data)
    self.processes[processId] = data
    return self
end

--- func desc
--- @param data vector3
function Business:addBossMenu(data)
    self.bossMenu = data
    return self
end

---@class Inventory 
---@field coords vector3
---@field id string
---@field name? string
---@field stashId string
---@field size number
---@field slots number
---@field icon? number
--- func desc
--- @param data Inventory
function Business:createInventory(data)
    data.stashId = "business:" ..self.name .. data.id or self.stashCount + 1
    exports.ox_inventory:RegisterStash(
        data.stashId, 
        data.name, 
        data.slots, 
        data.size, 
        false, { [self.name] = 0 }
    )
    self.stashCount = self.stashCount + 1
    table.insert(self.inventories, data)
    return self
end

---@return Business[]
function fetchBusinesses()
    return registeredBusinesses
end

---@param business any
---@param process any
---@return Process
function fetchProcess(business, process) 
    return registeredBusinesses[business]?.processes?[process]
end
