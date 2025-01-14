local incidents = {}
local convictions = {}
local bolos = {}
local MugShots = {}
local activeUnits = {}
local impound = {}
local dispatchMessages = {}
local isDispatchRunning = false
local antiSpam = false
local calls = {}

--------------------------------
-- SET YOUR WEHBOOKS IN HERE
-- Images for mug shots will be uploaded here. Add a Discord webhook. 
local MugShotWebhook = ''

-- Clock-in notifications for duty. Add a Discord webhook.
-- Command /mdtleaderboard, will display top players per clock-in hours.
local ClockinWebhook = GetConvar("mdt_clock_webhook", nil)

-- Incident and Incident editting. Add a Discord webhook.
-- Incident Author, Title, and Report will display in webhook post.
local IncidentWebhook = GetConvar("mdt_incident_webhook", nil)
--------------------------------

local chargesByName = {}

for key, directory in pairs(Config.PenalCode) do
	for key, charge in pairs(directory) do
		chargesByName[charge.title] = charge
	end
end

ESX.RegisterServerCallback('ps-mdt:server:MugShotWebhook', function(source, cb)
    if MugShotWebhook == '' then
        print("\27[31mA webhook is missing in: MugShotWebhook (server > main.lua > line 16)\27[0m")
    else
        cb(MugShotWebhook)
    end
end)

local function GetActiveData(cid)
	local player = type(cid) == "string" and cid or tostring(cid)
	if player then
		return activeUnits[player] and true or false
	end
	return false
end

local function IsPoliceOrEms(job)
	for k, v in pairs(Config.PoliceJobs) do
           if job == k then
              return true
            end
         end
         
         for k, v in pairs(Config.AmbulanceJobs) do
           if job == k then
              return true
            end
         end
    return false
end

RegisterServerEvent("ps-mdt:dispatchStatus", function(bool)
	isDispatchRunning = bool
end)

if Config.UseWolfknightRadar == true then
	RegisterNetEvent("wk:onPlateScanned")
	AddEventHandler("wk:onPlateScanned", function(cam, plate, index)
		local src = source
		local PlayerData = GetPlayerData(src)
		local vehicleOwner = GetVehicleOwner(plate)
		local bolo, title, boloId = GetBoloStatus(plate)
		local warrant, owner, incidentId = GetWarrantStatus(plate)

		if bolo == true then
			PlayerData.showNotification('BOLO ID: '..boloId..' | Title: '..title..' | Registered Owner: '..vehicleOwner..' | Plate: '..plate, 'error', Config.WolfknightNotifyTime)
			TriggerClientEvent("wk:togglePlateLock", src, cam, true, 1)
		end
		if warrant == true then
			PlayerData.showNotification('WANTED - INCIDENT ID: '..incidentId..' | Registered Owner: '..owner..' | Plate: '..plate, 'error', Config.WolfknightNotifyTime)
			TriggerClientEvent("wk:togglePlateLock", src, cam, true, 1)
		end

		-- if Config.PlateScanForDriversLicense and driversLicense == false and vehicleOwner then
		-- 	TriggerClientEvent('esx:showNotification', src, 'NO DRIVERS LICENCE | Registered Owner: '..vehicleOwner..' | Plate: '..plate, 'error', Config.WolfknightNotifyTime)
		-- end

		-- if bolo or warrant or (Config.PlateScanForDriversLicense and not driversLicense) and vehicleOwner then
		-- 	TriggerClientEvent("wk:togglePlateLock", src, cam, true, 1)
		-- end
	end)
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
	Wait(3000)
	if MugShotWebhook == '' then
		print("\27[31mA webhook is missing in: MugShotWebhook (server > main.lua > line 16)\27[0m")
    end
    if ClockinWebhook == '' then
		print("\27[31mA webhook is missing in: ClockinWebhook (server > main.lua > line 20)\27[0m")
	end
	if GetResourceState('ps-dispatch') == 'started' then
		local calls = exports['ps-dispatch']:GetDispatchCalls()
		return calls
	end
end)

RegisterNetEvent("esx:setJob", function (source, new, last)
	local player = ESX.GetPlayerFromId(source)
	if (not IsPoliceOrEms(new.name) and GetActiveData(player.identifier)) then
		activeUnits[player.identifier] = nil
		player.setMeta("duty:"..player.job.name, 0)
		return
	end
	if (IsPoliceOrEms(new.name) and GetActiveData(player.identifier)) then
		activeUnits[player.identifier].callSign = player.getMeta("callsign:"..player.job.name) or player.metadata.callsign
		activeUnits[player.identifier].unitType = player.job.name
		activeUnits[player.identifier].duty = player.getMeta("duty:"..player.job.name) or 0
	end
end)

RegisterNetEvent("ps-mdt:server:OnPlayerUnload", function()
	--// Delete player from the MDT on logout
	local src = source
	local player = ESX.GetPlayerFromId(src)
	if GetActiveData(player.identifier) then
		activeUnits[player.identifier] = nil
	end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    local PlayerData = GetPlayerData(src)
	if PlayerData == nil then return end -- Player not loaded in correctly and dropped early

    local time = os.date("%Y-%m-%d %H:%M:%S")
    local job = PlayerData.job.name
    local firstName = PlayerData.variables.firstName:sub(1,1):upper()..PlayerData.variables.firstName:sub(2)
    local lastName = PlayerData.variables.lastName:sub(1,1):upper()..PlayerData.variables.lastName:sub(2)

    -- Auto clock out if the player is off duty
     if IsPoliceOrEms(job) and PlayerData.getMeta("duty:"..job) == 1 then
		MySQL.query.await('UPDATE mdt_clocking SET clock_out_time = NOW(), total_time = TIMESTAMPDIFF(SECOND, clock_in_time, NOW()) WHERE user_id = @user_id ORDER BY id DESC LIMIT 1', {
			['@user_id'] = PlayerData.citizenid
		})

		local result = MySQL.scalar.await('SELECT total_time FROM mdt_clocking WHERE user_id = @user_id', {
			['@user_id'] = PlayerData.citizenid
		})
		if result then
			local time_formatted = format_time(tonumber(result))
			sendToDiscord(16711680, "MDT Clock-Out", 'Player: **' ..  firstName .. " ".. lastName .. '**\n\nJob: **' .. PlayerData.job.name .. '**\n\nRank: **' .. PlayerData.job.grade.name .. '**\n\nStatus: **Off Duty**\n Total time:' .. time_formatted, "ps-mdt | Made by Project Sloth")
		end
	end

    -- Delete player from the MDT on logout
    if PlayerData ~= nil then
        if GetActiveData(PlayerData.identity) then
            activeUnits[PlayerData.identity] = nil
        end
    else
        local license = QBCore.Functions.GetIdentifier(src, "license")
        local citizenids = GetCitizenID(license)

        for _, v in pairs(citizenids) do
            if GetActiveData(v.citizenid) then
                activeUnits[v.citizenid] = nil
            end
        end
    end
end)

RegisterNetEvent("ps-mdt:server:ToggleDuty", function()
    local src = source
    local player = ESX.GetPlayerFromId(source)
end)

ESX.RegisterCommand("mdtleaderboard", {}, function(source, args)
    local PlayerData = GetPlayerData(source)
    local job = PlayerData.job.name

    if not IsPoliceOrEms(job) then
        TriggerClientEvent('esx:showNotification', source, "You don't have permission to use this command.", 'error')
        return
    end

	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, total_time FROM mdt_clocking ORDER BY total_time DESC')

    local leaderboard_message = '**MDT Leaderboard**\n\n'

    for i, record in ipairs(result) do
		local firstName = record.firstname:sub(1,1):upper()..record.firstname:sub(2)
		local lastName = record.lastname:sub(1,1):upper()..record.lastname:sub(2)
		local total_time = format_time(record.total_time)
	
		leaderboard_message = leaderboard_message .. i .. '. **' .. firstName .. ' ' .. lastName .. '** - ' .. total_time .. '\n'
	end

    sendToDiscord(16753920, "MDT Leaderboard", leaderboard_message, "ps-mdt | Made by Project Sloth")
    TriggerClientEvent('esx:showNotification', source, "MDT leaderboard sent to Discord!", 'success')
end, false, {
	help = "Show MDT leaderboard"
})

RegisterNetEvent("ps-mdt:server:ClockSystem", function()
    local src = source
    local PlayerData = GetPlayerData(src)
    local time = os.date("%Y-%m-%d %H:%M:%S")
    local firstName = PlayerData.variables.firstName:sub(1,1):upper()..PlayerData.variables.firstName:sub(2)
    local lastName = PlayerData.variables.lastName:sub(1,1):upper()..PlayerData.variables.lastName:sub(2)


	local currentDuty = PlayerData.getMeta("duty:"..PlayerData.job.name)
    if currentDuty == 0 or not currentDuty then
		PlayerData.setMeta("duty:"..PlayerData.job.name, 1)
		TriggerClientEvent("ps-dispatch:refreshDispatch", PlayerData.source)
		PlayerData.showNotification( "You're clocked-in", 'success')
		MySQL.Async.insert('INSERT INTO mdt_clocking (user_id, firstname, lastname, clock_in_time) VALUES (:user_id, :firstname, :lastname, :clock_in_time) ON DUPLICATE KEY UPDATE user_id = :user_id, firstname = :firstname, lastname = :lastname, clock_in_time = :clock_in_time', {
			user_id = PlayerData.identifier,
			firstname = firstName,
			lastname = lastName,
			clock_in_time = time
		}, function() end)
		sendToDiscord(65280, "MDT Clock-In", 'Player: **' ..  firstName .. " ".. lastName .. '**\n\nJob: **' .. PlayerData.job.name .. '**\n\nRank: **' .. PlayerData.job.grade_label .. '**\n\nStatus: **On Duty**', "ps-mdt | Made by Project Sloth")
    else
		PlayerData.showNotification("You're clocked-out", 'success')
		PlayerData.setMeta("duty:"..PlayerData.job.name, 0)
		MySQL.query.await('UPDATE mdt_clocking SET clock_out_time = NOW(), total_time = TIMESTAMPDIFF(SECOND, clock_in_time, NOW()) WHERE user_id = @user_id ORDER BY id DESC LIMIT 1', {
			['@user_id'] = PlayerData.identifier,
		})

		local result = MySQL.scalar.await('SELECT total_time FROM mdt_clocking WHERE user_id = @user_id', {
			['@user_id'] = PlayerData.identifier
		})

		local time_formatted = format_time(tonumber(result))

		sendToDiscord(16711680, "MDT Clock-Out", 'Player: **' ..  firstName .. " ".. lastName .. '**\n\nJob: **' .. PlayerData.job.name .. '**\n\nRank: **' .. PlayerData.job.grade_label .. '**\n\nStatus: **Off Duty**\n Total time:' .. time_formatted, "ps-mdt | Made by Project Sloth")
    end
end)

RegisterNetEvent('mdt:server:openMDT', function()
	local src = source
	local PlayerData = GetPlayerData(src)
	
	
	if not PermCheck(src, PlayerData) then return end
	local Radio = Player(src).state.radioChannel or 0
	
	if GetResourceState('ps-dispatch') == 'started' then
		calls = exports['ps-dispatch']:GetDispatchCalls()
	end

	activeUnits[PlayerData.identifier] = {
		cid = PlayerData.identifier,
		callSign = PlayerData.getMeta("callsign:"..PlayerData.job.name) or PlayerData.metadata.callsign,
		firstName = PlayerData.get("firstName"):sub(1,1):upper()..PlayerData.get("firstName"):sub(2),
		lastName = PlayerData.get("lastName"):sub(1,1):upper()..PlayerData.get("lastName"):sub(2),
		radio = Radio,
		unitType = PlayerData.job.name,
		duty = PlayerData.getMeta("duty:"..PlayerData.job.name) or 0
	}

	local JobType = GetJobType(PlayerData.job.name)
	local bulletin = GetBulletins(JobType)

	activeUnits = exports.stem_common:tableMapWithKeys(activeUnits, function (key, value) 
		local player = ESX.GetPlayerFromIdentifier(key)
		if not player or not IsPoliceOrEms(player.job.name)  then
			return key, nil
		end
		return key, value
	end)

	TriggerClientEvent('mdt:client:open', src, bulletin, activeUnits, calls, PlayerData.id)
end)

ESX.RegisterServerCallback('mdt:server:SearchProfile', function(source, cb, sentData)
    if not sentData then  return cb({}) end
    local src = source
    local Player = ESX.GetPlayerFromId(source)
    if Player then
        local JobType = GetJobType(Player.job.name)
        if JobType ~= nil then
            local people = MySQL.query.await([[
				SELECT p.identifier, p.firstname, p.lastname, md.pfp, md.fingerprint 
				FROM users p 
				LEFT JOIN mdt_data md on p.identifier = md.cid WHERE 
				LOWER(CONCAT(p.firstname, ' ', p.lastname)) LIKE @query OR 
				LOWER(`identifier`) LIKE @query OR 
				LOWER(md.fingerprint) LIKE @query
			]], { ["@query"] = string.lower('%'..sentData..'%') })
			local citizenIds = {}
            local citizenIdIndexMap = {}
            if not next(people) then cb({}) return end

            for index, data in pairs(people) do
                people[index]['warrant'] = false
                people[index]['convictions'] = 0
                people[index]['licences'] = GetPlayerLicenses(data.identifier)
                people[index]['pp'] = ProfPic(data.gender, data.pfp)
				if data.fingerprint and data.fingerprint ~= "" then
					people[index]['fingerprint'] = data.fingerprint
				else
					people[index]['fingerprint'] = ""
				end				
                citizenIds[#citizenIds+1] = data.identifier
                citizenIdIndexMap[data.identifier] = index
            end

            local convictions = GetConvictions(citizenIds)

            if next(convictions) then
                for _, conv in pairs(convictions) do
                    if conv.warrant == "1" then people[citizenIdIndexMap[conv.cid]].warrant = true end

                    local charges = json.decode(conv.charges)
                    people[citizenIdIndexMap[conv.cid]].convictions = people[citizenIdIndexMap[conv.cid]].convictions + #charges
                end
            end

			TriggerClientEvent('mdt:client:searchProfile', src, people, false)

            return cb(people)
        end
    end

    return cb({})
end)



ESX.RegisterServerCallback('ps-mdt:getDispatchCalls', function(source, cb)
    local calls = exports['ps-dispatch']:GetDispatchCalls()
    cb(calls)
end)

ESX.RegisterServerCallback("mdt:server:getWarrants", function(source, cb)
    local WarrantData = {}
    local data = MySQL.query.await("SELECT * FROM mdt_convictions", {})
    for _, value in pairs(data) do
        if value.warrant == "1" then
			WarrantData[#WarrantData+1] = {
                cid = value.cid,
                linkedincident = value.linkedincident,
                name = GetNameFromId(value.cid),
                time = value.time
            }
        end
    end
    cb(WarrantData)
end)

ESX.RegisterServerCallback('mdt:server:OpenDashboard', function(source, cb)
	local PlayerData = GetPlayerData(source)
	if not PermCheck(source, PlayerData) then return end
	local JobType = GetJobType(PlayerData.job.name)
	local bulletin = GetBulletins(JobType)
	cb(bulletin)
end)

RegisterNetEvent('mdt:server:NewBulletin', function(title, info, time)
	local src = source
	local PlayerData = GetPlayerData(src)
	if not PermCheck(src, PlayerData) then return end
	local JobType = GetJobType(PlayerData.job.name)
	local newBulletin = MySQL.insert.await('INSERT INTO `mdt_bulletin` (`title`, `desc`, `author`, `time`, `jobtype`) VALUES (:title, :desc, :author, :time, :jt)', {
		title = title,
		desc = info,
		author = PlayerData.name,
		time = tostring(time),
		jt = JobType
	})

	AddLog(("A new bulletin was added by %s with the title: %s!"):format(PlayerData.name, title))
	TriggerClientEvent('mdt:client:newBulletin', -1, src, {id = newBulletin, title = title, info = info, time = time, author = PlayerData.identifier}, JobType)
end)

RegisterNetEvent('mdt:server:deleteBulletin', function(id, title)
	if not id then return false end
	local src = source
	local PlayerData = GetPlayerData(src)
	if not PermCheck(src, PlayerData) then return end
	local JobType = GetJobType(PlayerData.job.name)

	MySQL.query.await('DELETE FROM `mdt_bulletin` where id = ?', {id})
	AddLog("Bulletin with Title: "..title.." was deleted by " .. GetNameFromPlayerData(PlayerData) .. ".")
end)

ESX.RegisterServerCallback('mdt:server:GetProfileData', function(source, cb, sentId)
	if not sentId then return cb({}) end

	local src = source
	local PlayerData = GetPlayerData(src)
	if not PermCheck(src, PlayerData) then return cb({}) end
	local JobType = GetJobType(PlayerData.job.name)
	local target = GetPlayerDataById(sentId)
	local JobName = PlayerData.job.name

	local apartmentData

	if not target or not next(target) then return cb({}) end

	if type(target.job) == 'string' then target.job = json.decode(target.job) end
	if type(target.charinfo) == 'string' then target.charinfo = json.decode(target.charinfo) end
	if type(target.metadata) == 'string' then target.metadata = json.decode(target.metadata) end

	local licencesdata = GetPlayerLicenses(target.identifier)
	local job = target.job.name
	local grade = target.job.grade


	if Config.UsingPsHousing and not Config.UsingDefaultQBApartments then
		local propertyData = GetPlayerPropertiesByCitizenId(target.identifier)
		if propertyData and next(propertyData) then
			local apartmentList = {}
			for i, property in ipairs(propertyData) do
				if property.apartment then
					table.insert(apartmentList, property.apartment .. ' Apt # (' .. property.property_id .. ')')
				end
			end
			if #apartmentList > 0 then
				apartmentData = table.concat(apartmentList, ', ')
			else
				TriggerClientEvent("QBCore:Notify", src, 'The citizen does not have an apartment.', 'error')
				print('The citizen does not have an apartment. Set Config.UsingPsHousing to false.')
			end
		else
			TriggerClientEvent("QBCore:Notify", src, 'The citizen does not have a property.', 'error')
			print('The citizen does not have a property. Set Config.UsingPsHousing to false.')
		end	
    elseif Config.UsingDefaultQBApartments then
        apartmentData = GetPlayerApartment(target.identifier)
        if apartmentData then
            if apartmentData[1] then
                apartmentData = apartmentData[1].label .. ' (' ..apartmentData[1].name..')'
            else
                TriggerClientEvent("QBCore:Notify", src, 'The citizen does not have an apartment.', 'error')
                print('The citizen does not have an apartment. Set Config.UsingDefaultQBApartments to false.')
            end
        else
            TriggerClientEvent("QBCore:Notify", src, 'The citizen does not have an apartment.', 'error')
            print('The citizen does not have an apartment. Set Config.UsingDefaultQBApartments to false.')
        end
    end

	local person = {
		cid = target.identifier,
		firstname = target.charinfo.firstname,
		lastname = target.charinfo.lastname,
		job = job,
		grade = grade,
		apartment = apartmentData,
		pp = ProfPic(target.charinfo.gender),
		licences = licencesdata,
		dob = target.charinfo.dateofbirth,
		fingerprint = target.metadata.fingerprint,
		phone = target.charinfo.phone,
		mdtinfo = '',
		tags = {},
		vehicles = {},
		properties = {},
		gallery = {},
		isLimited = false
	}


	if Config.PoliceJobs[JobName] or Config.DojJobs[JobName] then
		local convictions = GetConvictions({person.cid})
		local incidents = {}
		person.convictions2 = {}
		local convCount = 1
		if next(convictions) then
			for _, conv in pairs(convictions) do
				if conv.warrant == "1" then person.warrant = true end
				
				-- Get the incident details
				local id = conv.linkedincident
				local incident = GetIncidentName(id)

				if incident then
					incidents[#incidents + 1] = {
						id = id,
						title = incident.title,
						time = conv.time
					}
				end

				local charges = json.decode(conv.charges)
				for _, charge in pairs(charges) do
					person.convictions2[convCount] = charge
					convCount = convCount + 1
				end
			end
		end

		person.incidents = incidents

		local hash = {}
		person.convictions = {}

		for _,v in ipairs(person.convictions2) do
			if (not hash[v]) then
				person.convictions[#person.convictions+1] = v
				hash[v] = true
			end
		end

		local vehicles = GetPlayerVehicles(person.cid)

		if vehicles then
			person.vehicles = vehicles
		end

		if Config.UsingPsHousing and not Config.UsingDefaultQBApartments then
    		local Coords = {}
    		local Houses = {}
		local propertyData = GetPlayerPropertiesByCitizenId(target.citizenid)
    		for k, v in pairs(propertyData) do
				if not v.apartment then
    		    	Coords[#Coords + 1] = {
    		    	    coords = json.decode(v["door_data"]),
    		    	    street = v["street"],
    		    	    propertyid = v["property_id"],
    		    	}
				end
    		end
    		for index = 1, #Coords do
    		    local coordsLocation, label
    		    local coords = Coords[index]["coords"]

    		    coordsLocation = tostring(coords.x .. "," .. coords.y .. "," .. coords.z)
    		    label = tostring(Coords[index].propertyid .. " " .. Coords[index].street)
			
    		    Houses[#Houses + 1] = {
    		        label = label,
    		        coords = coordsLocation,
    		    }
    		end
			person.properties = Houses
		else
			-- local Coords = {}
			-- local Houses = {}
			-- local properties= GetPlayerProperties(person.cid)
			-- for k, v in pairs(properties) do
			-- 	Coords[#Coords+1] = {
			-- 		coords = json.decode(v["coords"]),
			-- 	}
			-- end
			-- for index = 1, #Coords, 1 do
			-- 	Houses[#Houses+1] = {
			-- 		label = properties[index]["label"],
			-- 		coords = tostring(Coords[index]["coords"]["enter"]["x"]..",".. Coords[index]["coords"]["enter"]["y"].. ",".. Coords[index]["coords"]["enter"]["z"]),
			-- 	}
			-- end
			-- person.properties = Houses
		end
	end
	local mdtData = GetPersonInformation(sentId, JobType)
	if mdtData then
		person.mdtinfo = mdtData.information
		person.profilepic = mdtData.pfp
		person.tags = json.decode(mdtData.tags)
		person.gallery = json.decode(mdtData.gallery)
		person.fingerprint = mdtData.fingerprint
		print("Fetched fingerprint from mdt_data:", mdtData.fingerprint)
	end

	return cb(person)
end)

RegisterNetEvent("mdt:server:saveProfile", function(pfp, information, cid, fName, sName, tags, gallery, licenses, fingerprint)
    local src = source
	local Player = GetPlayerData(src)
    UpdateAllLicenses(cid, licenses)
    if Player then
        local JobType = GetJobType(Player.job.name)
        if JobType == 'doj' then JobType = 'police' end

        MySQL.Async.insert('INSERT INTO mdt_data (cid, information, pfp, jobtype, tags, gallery, fingerprint) VALUES (:cid, :information, :pfp, :jobtype, :tags, :gallery, :fingerprint) ON DUPLICATE KEY UPDATE cid = :cid, information = :information, pfp = :pfp, jobtype = :jobtype, tags = :tags, gallery = :gallery, fingerprint = :fingerprint', {
            cid = cid,
            information = information,
            pfp = pfp,
            jobtype = JobType,
            tags = json.encode(tags),
            gallery = json.encode(gallery),
            fingerprint = fingerprint,
        }, function()
        end)
    end
end)


-- Mugshotd
RegisterNetEvent('cqc-mugshot:server:triggerSuspect', function(suspect)
    TriggerClientEvent('cqc-mugshot:client:trigger', suspect, suspect)
end)

RegisterNetEvent('psmdt-mugshot:server:MDTupload', function(citizenid, MugShotURLs)
    MugShots[citizenid] = MugShotURLs
    local cid = citizenid
    MySQL.Async.insert('INSERT INTO mdt_data (cid, pfp, gallery, tags) VALUES (:cid, :pfp, :gallery, :tags) ON DUPLICATE KEY UPDATE cid = :cid,  pfp = :pfp, tags = :tags, gallery = :gallery', {
		cid = cid,
		pfp = MugShotURLs[1],
		tags = json.encode(tags),
		gallery = json.encode(MugShotURLs),
	})
end)

RegisterNetEvent("mdt:server:updateLicense", function(cid, type, status)
	local src = source
	local Player = GetPlayerData(src)
	if Player then
		if GetJobType(Player.job.name) == 'police' then
			ManageLicense(cid, type, status)
		end
	end
end)

-- Incidents

RegisterNetEvent('mdt:server:getAllIncidents', function()
	local src = source
	local Player = GetPlayerData(src)
	if Player then
		local JobType = GetJobType(Player.job.name)
		if JobType == 'police' or JobType == 'doj' then
			local matches = MySQL.query.await("SELECT * FROM `mdt_incidents` ORDER BY `id` DESC LIMIT 30", {})

			TriggerClientEvent('mdt:client:getAllIncidents', src, matches)
		end
	end
end)

RegisterNetEvent('mdt:server:searchIncidents', function(query)
	if query then
		local src = source
		local Player = GetPlayerData(src)
		if Player then
			local JobType = GetJobType(Player.job.name)
			if JobType == 'police' or JobType == 'doj' then
				local matches = MySQL.query.await("SELECT * FROM `mdt_incidents` WHERE `id` LIKE :query OR LOWER(`title`) LIKE :query OR LOWER(`author`) LIKE :query OR LOWER(`details`) LIKE :query OR LOWER(`tags`) LIKE :query OR LOWER(`officersinvolved`) LIKE :query OR LOWER(`civsinvolved`) LIKE :query OR LOWER(`author`) LIKE :query ORDER BY `id` DESC LIMIT 50", {
					query = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
				})

				TriggerClientEvent('mdt:client:getIncidents', src, matches)
			end
		end
	end
end)

RegisterNetEvent('mdt:server:getIncidentData', function(sentId)
	if sentId then
		local src = source
		local Player = GetPlayerData(src)
		if Player then
			local JobType = GetJobType(Player.job.name)
			if JobType == 'police' or JobType == 'doj' then
				local matches = MySQL.query.await("SELECT * FROM `mdt_incidents` WHERE `id` = :id", {
					id = sentId
				})
				local data = matches[1]
				data['tags'] = json.decode(data['tags'])
				data['officersinvolved'] = json.decode(data['officersinvolved'])
				data['civsinvolved'] = json.decode(data['civsinvolved'])
				data['evidence'] = json.decode(data['evidence'])


				local convictions = MySQL.query.await("SELECT * FROM `mdt_convictions` WHERE `linkedincident` = :id", {
					id = sentId
				})
				if convictions ~= nil then
					for i=1, #convictions do
						local res = GetNameFromId(convictions[i]['cid'])
						if res ~= nil then
							convictions[i]['name'] = res
						else
							convictions[i]['name'] = "Unknown"
						end
						convictions[i]['charges'] = json.decode(convictions[i]['charges'])
					end
				end
				TriggerClientEvent('mdt:client:getIncidentData', src, data, convictions)
			end
		end
	end
end)

RegisterNetEvent('mdt:server:getAllBolos', function()
	local src = source
	local Player = ESX.GetPlayerFromId(source)
	local JobType = GetJobType(Player.job.name)
	if JobType == 'police' or JobType == 'ambulance' then
		local matches = MySQL.query.await("SELECT * FROM `mdt_bolos` WHERE jobtype = :jobtype", {jobtype = JobType})
		TriggerClientEvent('mdt:client:getAllBolos', src, matches)
	end
end)

RegisterNetEvent('mdt:server:searchBolos', function(sentSearch)
	if sentSearch then
		local src = source
		local Player = ESX.GetPlayerFromId(source)
		local JobType = GetJobType(Player.job.name)
		if JobType == 'police' or JobType == 'ambulance' then
			local matches = MySQL.query.await("SELECT * FROM `mdt_bolos` WHERE `id` LIKE :query OR LOWER(`title`) LIKE :query OR `plate` LIKE :query OR LOWER(`owner`) LIKE :query OR LOWER(`individual`) LIKE :query OR LOWER(`detail`) LIKE :query OR LOWER(`officersinvolved`) LIKE :query OR LOWER(`tags`) LIKE :query OR LOWER(`author`) LIKE :query AND jobtype = :jobtype", {
				query = string.lower('%'..sentSearch..'%'), -- % wildcard, needed to search for all alike results
				jobtype = JobType
			})
			TriggerClientEvent('mdt:client:getBolos', src, matches)
		end
	end
end)

RegisterNetEvent('mdt:server:getBoloData', function(sentId)
	if sentId then
		local src = source
		local Player = ESX.GetPlayerFromId(source)
		local JobType = GetJobType(Player.job.name)
		if JobType == 'police' or JobType == 'ambulance' then
			local matches = MySQL.query.await("SELECT * FROM `mdt_bolos` WHERE `id` = :id AND jobtype = :jobtype LIMIT 1", {
				id = sentId,
				jobtype = JobType
			})

			local data = matches[1]
			data['tags'] = json.decode(data['tags'])
			data['officersinvolved'] = json.decode(data['officersinvolved'])
			data['gallery'] = json.decode(data['gallery'])
			TriggerClientEvent('mdt:client:getBoloData', src, data)
		end
	end
end)

RegisterNetEvent('mdt:server:newBolo', function(existing, id, title, plate, owner, individual, detail, tags, gallery, officersinvolved, time)
	if id then
		local src = source
		local Player = ESX.GetPlayerFromId(source)
		local JobType = GetJobType(Player.job.name)
		if JobType == 'police' or JobType == 'ambulance' then
			local fullname = Player.name

			local function InsertBolo()
				MySQL.insert('INSERT INTO `mdt_bolos` (`title`, `author`, `plate`, `owner`, `individual`, `detail`, `tags`, `gallery`, `officersinvolved`, `time`, `jobtype`) VALUES (:title, :author, :plate, :owner, :individual, :detail, :tags, :gallery, :officersinvolved, :time, :jobtype)', {
					title = title,
					author = fullname,
					plate = plate,
					owner = owner,
					individual = individual,
					detail = detail,
					tags = json.encode(tags),
					gallery = json.encode(gallery),
					officersinvolved = json.encode(officersinvolved),
					time = tostring(time),
					jobtype = JobType
				}, function(r)
					if r then
						TriggerClientEvent('mdt:client:boloComplete', src, r)
						TriggerEvent('mdt:server:AddLog', "A new BOLO was created by "..fullname.." with the title ("..title..") and ID ("..id..")")
					end
				end)
			end

			local function UpdateBolo()
				MySQL.update("UPDATE mdt_bolos SET `title`=:title, plate=:plate, owner=:owner, individual=:individual, detail=:detail, tags=:tags, gallery=:gallery, officersinvolved=:officersinvolved WHERE `id`=:id AND jobtype = :jobtype LIMIT 1", {
					title = title,
					plate = plate,
					owner = owner,
					individual = individual,
					detail = detail,
					tags = json.encode(tags),
					gallery = json.encode(gallery),
					officersinvolved = json.encode(officersinvolved),
					id = id,
					jobtype = JobType
				}, function(r)
					if r then
						TriggerClientEvent('mdt:client:boloComplete', src, id)
						TriggerEvent('mdt:server:AddLog', "A BOLO was updated by "..fullname.." with the title ("..title..") and ID ("..id..")")
					end
				end)
			end

			if existing then
				UpdateBolo()
			elseif not existing then
				InsertBolo()
			end
		end
	end
end)

RegisterNetEvent('mdt:server:deleteWeapons', function(id)
	if id then
		local src = source
		local Player = ESX.GetPlayerFromId(source)
		if Config.RemoveWeaponsPerms[Player.job.name] then
			if Config.RemoveWeaponsPerms[Player.job.name][Player.job.grade] then
				local fullname = Player.name
				MySQL.update("DELETE FROM `mdt_weaponinfo` WHERE id=:id", { id = id })
				TriggerEvent('mdt:server:AddLog', "A Weapon Info was deleted by "..fullname.." with the ID ("..id..")")
			else
				local fullname = Player.name
				TriggerClientEvent("QBCore:Notify", src, 'No Permissions to do that!', 'error')
				TriggerEvent('mdt:server:AddLog', fullname.." tryed to delete a Weapon Info with the ID ("..id..")")
			end
		end
	end
end)

RegisterNetEvent('mdt:server:deleteReports', function(id)
	if id then
		local src = source
		local Player = ESX.GetPlayerFromId(source)
		if Config.RemoveReportPerms[Player.job.name] then
			if Config.RemoveReportPerms[Player.job.name][Player.job.grade] then
				local fullName = Player.name
				MySQL.update("DELETE FROM `mdt_reports` WHERE id=:id", { id = id })
				TriggerEvent('mdt:server:AddLog', "A Report was deleted by "..fullName.." with the ID ("..id..")")
			else
				local fullName = Player.name
				TriggerClientEvent("QBCore:Notify", src, 'No Permissions to do that!', 'error')
				TriggerEvent('mdt:server:AddLog', fullName.." tryed to delete a Report with the ID ("..id..")")
			end
		end
	end
end)

RegisterNetEvent('mdt:server:deleteIncidents', function(id)
    local src = source
	local Player = ESX.GetPlayerFromId(source)
    if Config.RemoveIncidentPerms[Player.job.name] then
        if Config.RemoveIncidentPerms[Player.job.name][Player.job.grade] then
            MySQL.update("DELETE FROM `mdt_convictions` WHERE `linkedincident` = :id", {id = id})
            MySQL.update("UPDATE `mdt_convictions` SET `warrant` = '0' WHERE `linkedincident` = :id", {id = id}) -- Delete any outstanding warrants from incidents
            MySQL.update("DELETE FROM `mdt_incidents` WHERE id=:id", { id = id }, function(rowsChanged)
                if rowsChanged > 0 then
                    TriggerEvent('mdt:server:AddLog', "A Incident was deleted by "..Player.name.." with the ID ("..id..")")
                end
            end)
        else
            TriggerClientEvent("QBCore:Notify", src, 'No Permissions to do that!', 'error')
            TriggerEvent('mdt:server:AddLog', Player.name.." tried to delete an Incident with the ID ("..id..")")
        end
    end
end)

RegisterNetEvent('mdt:server:deleteBolo', function(id)
	if id then
		local src = source
		local Player = ESX.GetPlayerFromId(source)
		local JobType = GetJobType(Player.job.name)
		if JobType == 'police' then
			MySQL.update("DELETE FROM `mdt_bolos` WHERE id=:id", { id = id, jobtype = JobType })
			TriggerEvent('mdt:server:AddLog', "A BOLO was deleted by "..Player.name.." with the ID ("..id..")")
		end
	end
end)

RegisterNetEvent('mdt:server:deleteICU', function(id)
	if id then
		local src = source
		local Player = ESX.GetPlayerFromId(source)
		local JobType = GetJobType(Player.job.name)
		if JobType == 'ambulance' then
			MySQL.update("DELETE FROM `mdt_bolos` WHERE id=:id", { id = id, jobtype = JobType })
			TriggerEvent('mdt:server:AddLog', "A ICU Check-in was deleted by "..Player.name.." with the ID ("..id..")")
		end
	end
end)

RegisterNetEvent('mdt:server:incidentSearchPerson', function(query)
    if query then
        local src = source
		local Player = GetPlayerData(src)
        if Player then
            local JobType = GetJobType(Player.job.name)
            if JobType == 'police' or JobType == 'doj' or JobType == 'ambulance' then
                local function ProfPic(gender, profilepic)
                    if profilepic then return profilepic end;
                    if gender == "f" then return "img/female.png" end;
                    return "img/male.png"
                end

                local result = MySQL.query.await("SELECT p.identifier, p.sex, p.firstname, p.lastname, p.job, p.metadata, md.pfp from users p LEFT JOIN mdt_data md on p.identifier = md.cid WHERE LOWER(CONCAT(p.firstname, ' ', p.lastname)) LIKE :query OR LOWER(`identifier`) LIKE :query OR LOWER(md.fingerprint) LIKE :query AND jobtype = :jobtype LIMIT 30", {
					query = string.lower('%'..query..'%'),
                    jobtype = JobType
                })

                local data = {}
                for i=1, #result do
                    data[i] = {
                        id = result[i].identifier,
                        firstname = result[i].firstname,
                        lastname = result[i].lastname,
                        profilepic = ProfPic(result[i].sex, result[i].pfp),
                        callsign = result[i].metadata["callsign:"..result[i].job] or result[i].metadata["callsign"]
                    }
                end
                TriggerClientEvent('mdt:client:incidentSearchPerson', src, data)
            end
        end
    end
end)

RegisterNetEvent('mdt:server:getAllReports', function()
	local src = source
	local Player = GetPlayerData(src)
	if Player then
		local JobType = GetJobType(Player.job.name)
		if JobType == 'police' or JobType == 'doj' or JobType == 'ambulance' then
			if JobType == 'doj' then JobType = 'police' end
			local matches = MySQL.query.await("SELECT * FROM `mdt_reports` WHERE jobtype = :jobtype ORDER BY `id` DESC LIMIT 30", {
				jobtype = JobType
			})
			TriggerClientEvent('mdt:client:getAllReports', src, matches)
		end
	end
end)

RegisterNetEvent('mdt:server:getReportData', function(sentId)
	if sentId then
		local src = source
		local Player = GetPlayerData(src)
		if Player then
			local JobType = GetJobType(Player.job.name)
			if JobType == 'police' or JobType == 'doj' or JobType == 'ambulance' then
				if JobType == 'doj' then JobType = 'police' end
				local matches = MySQL.query.await("SELECT * FROM `mdt_reports` WHERE `id` = :id AND `jobtype` = :jobtype LIMIT 1", {
					id = sentId,
					jobtype = JobType
				})
				local data = matches[1]
				data['tags'] = json.decode(data['tags'])
				data['officersinvolved'] = json.decode(data['officersinvolved'])
				data['civsinvolved'] = json.decode(data['civsinvolved'])
				data['gallery'] = json.decode(data['gallery'])
				TriggerClientEvent('mdt:client:getReportData', src, data)
			end
		end
	end
end)

RegisterNetEvent('mdt:server:searchReports', function(sentSearch)
	if sentSearch then
		local src = source
		local Player = GetPlayerData(src)
		if Player then
			local JobType = GetJobType(Player.job.name)
			if JobType == 'police' or JobType == 'doj' or JobType == 'ambulance' then
				if JobType == 'doj' then JobType = 'police' end
				local matches = MySQL.query.await("SELECT * FROM `mdt_reports` WHERE `id` LIKE :query OR LOWER(`author`) LIKE :query OR LOWER(`title`) LIKE :query OR LOWER(`type`) LIKE :query OR LOWER(`details`) LIKE :query OR LOWER(`tags`) LIKE :query AND `jobtype` = :jobtype ORDER BY `id` DESC LIMIT 50", {
					query = string.lower('%'..sentSearch..'%'), -- % wildcard, needed to search for all alike results
					jobtype = JobType
				})

				TriggerClientEvent('mdt:client:getAllReports', src, matches)
			end
		end
	end
end)

RegisterNetEvent('mdt:server:newReport', function(existing, id, title, reporttype, details, tags, gallery, officers, civilians, time)
	if id then
		local src = source
		local Player = GetPlayerData(src)
		if Player then
			local JobType = GetJobType(Player.job.name)
			if JobType ~= nil then
				local fullname = Player.name
				local function InsertReport()
					MySQL.insert('INSERT INTO `mdt_reports` (`title`, `author`, `type`, `details`, `tags`, `gallery`, `officersinvolved`, `civsinvolved`, `time`, `jobtype`) VALUES (:title, :author, :type, :details, :tags, :gallery, :officersinvolved, :civsinvolved, :time, :jobtype)', {
						title = title,
						author = fullname,
						type = reporttype,
						details = details,
						tags = json.encode(tags),
						gallery = json.encode(gallery),
						officersinvolved = json.encode(officers),
						civsinvolved = json.encode(civilians),
						time = tostring(time),
						jobtype = JobType,
					}, function(r)
						if r then
							TriggerClientEvent('mdt:client:reportComplete', src, r)
							TriggerEvent('mdt:server:AddLog', "A new report was created by "..fullname.." with the title ("..title..") and ID ("..id..")")
						end
					end)
				end

				local function UpdateReport()
					MySQL.update("UPDATE `mdt_reports` SET `title` = :title, type = :type, details = :details, tags = :tags, gallery = :gallery, officersinvolved = :officersinvolved, civsinvolved = :civsinvolved, jobtype = :jobtype WHERE `id` = :id LIMIT 1", {
						title = title,
						type = reporttype,
						details = details,
						tags = json.encode(tags),
						gallery = json.encode(gallery),
						officersinvolved = json.encode(officers),
						civsinvolved = json.encode(civilians),
						jobtype = JobType,
						id = id,
					}, function(affectedRows)
						if affectedRows > 0 then
							TriggerClientEvent('mdt:client:reportComplete', src, id)
							TriggerEvent('mdt:server:AddLog', "A report was updated by "..fullname.." with the title ("..title..") and ID ("..id..")")
						end
					end)
				end

				if existing then
					UpdateReport()
				elseif not existing then
					InsertReport()
				end
			end
		end
	end
end)

ESX.RegisterServerCallback('mdt:server:SearchVehicles', function(source, cb, sentData)
	if not sentData then  return cb({}) end
	local src = source
	local PlayerData = GetPlayerData(src)
	if not PermCheck(source, PlayerData) then return cb({}) end

	local src = source
	local Player = GetPlayerData(src)
	if Player then
		local JobType = GetJobType(Player.job.name)
		if JobType == 'police' or JobType == 'doj' then
			local vehicles = MySQL.query.await("SELECT pv.model, pv.owner, pv.plate, pv.vehicle, pv.stored, pv.pound, p.firstname, p.lastname FROM `owned_vehicles` pv LEFT JOIN users p ON pv.owner = p.identifier WHERE LOWER(`plate`) LIKE :query OR LOWER(CONCAT(p.firstname, ' ', p.lastname))  LIKE :query OR LOWER(`vehicle`) LIKE :query LIMIT 25", {
				query = string.lower('%'..sentData..'%')
			})

			if not next(vehicles) then cb({}) return end

			for _, value in ipairs(vehicles) do
				if not value.stored then
					value.state = "Out"
				end
				if value.stored then
					value.state = "Garaged"
				end
				if value.pound then
					value.state = "Impounded"
				end

				value.bolo = false
				local boloResult = GetBoloStatus(value.plate)
				if boloResult then
					value.bolo = true
				end

				value.code = false
				value.stolen = false
				value.image = "img/not-found.webp"
				local info = GetVehicleInformation(value.plate)
				if info then
					value.code = info['code5']
					value.stolen = info['stolen']
					value.image = info['image']
				end

				value.owner = value['firstname'] .. " " .. value['lastname']
			end

		
			return cb(vehicles)
		end

		return cb({})
	end

end)

RegisterNetEvent('mdt:server:getVehicleData', function(plate)
	if plate then
		local src = source
		local Player = GetPlayerData(src)
		if Player then
			local JobType = GetJobType(Player.job.name)
			if JobType == 'police' or JobType == 'doj' then
				local vehicle = MySQL.query.await("select pv.*, p.firstname, p.lastname from owned_vehicles pv LEFT JOIN users p ON pv.owner = p.identifier where pv.plate = :plate LIMIT 1", { plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")})
				if vehicle and vehicle[1] then
					vehicle[1]['impound'] = false

					if vehicle[1].pound then
						vehicle[1]['impound'] = true
					end

					vehicle[1]['bolo'] = GetBoloStatus(vehicle[1]['plate'])
					vehicle[1]['information'] = ""

					vehicle[1]['name'] = "Unknown Person"

					vehicle[1]['name'] = vehicle[1].firstname .. " " .. vehicle[1].lastname

					local color1 = json.decode(vehicle[1].vehicle)
					vehicle[1]['color1'] = color1['color1']

					vehicle[1]['dbid'] = 0

					local info = GetVehicleInformation(vehicle[1]['plate'])
					if info then
						vehicle[1]['information'] = info['information']
						vehicle[1]['dbid'] = info['id']
						vehicle[1]['points'] = info['points']
						vehicle[1]['image'] = info['image']
						vehicle[1]['code'] = info['code5']
						vehicle[1]['stolen'] = info['stolen']
					end

					if vehicle[1]['image'] == nil then vehicle[1]['image'] = "img/not-found.webp" end
				end

				TriggerClientEvent('mdt:client:getVehicleData', src, vehicle)
			end
		end
	end
end)

RegisterNetEvent('mdt:server:saveVehicleInfo', function(dbid, plate, imageurl, notes, stolen, code5, impoundInfo, points)
	if plate then
		local src = source
		local Player = GetPlayerData(src)
		if Player then
			if GetJobType(Player.job.name) == 'police' then
				if dbid == nil then dbid = 0 end;
				local fullname = Player.name
				TriggerEvent('mdt:server:AddLog', "A vehicle with the plate ("..plate..") has a new image ("..imageurl..") edited by "..fullname)
				if tonumber(dbid) == 0 then
					MySQL.insert('INSERT INTO `mdt_vehicleinfo` (`plate`, `information`, `image`, `code5`, `stolen`, `points`) VALUES (:plate, :information, :image, :code5, :stolen, :points)', { plate = string.gsub(plate, "^%s*(.-)%s*$", "%1"), information = notes, image = imageurl, code5 = code5, stolen = stolen, points = tonumber(points) }, function(infoResult)
						if infoResult then
							TriggerClientEvent('mdt:client:updateVehicleDbId', src, infoResult)
							TriggerEvent('mdt:server:AddLog', "A vehicle with the plate ("..plate..") was added to the vehicle information database by "..fullname)
						end
					end)
				elseif tonumber(dbid) > 0 then
					MySQL.update("UPDATE mdt_vehicleinfo SET `information`= :information, `image`= :image, `code5`= :code5, `stolen`= :stolen, `points`= :points WHERE `plate`= :plate LIMIT 1", { plate = string.gsub(plate, "^%s*(.-)%s*$", "%1"), information = notes, image = imageurl, code5 = code5, stolen = stolen, points = tonumber(points) })
				end

				if impoundInfo.impoundChanged then
					local vehicle = MySQL.single.await("SELECT p.id, p.plate, i.vehicleid AS impoundid FROM `player_vehicles` p LEFT JOIN `mdt_impound` i ON i.vehicleid = p.id WHERE plate=:plate", { plate = string.gsub(plate, "^%s*(.-)%s*$", "%1") })
					if impoundInfo.impoundActive then
						local plate, linkedreport, fee, time = impoundInfo['plate'], impoundInfo['linkedreport'], impoundInfo['fee'], impoundInfo['time']
						if (plate and linkedreport and fee and time) then
							if vehicle.impoundid == nil then
								-- This section is copy pasted from request impound and needs some attention.
								-- sentVehicle doesnt exist.
								-- data is defined twice
								-- INSERT INTO will not work if it exists already (which it will)
								local data = vehicle
								MySQL.insert('INSERT INTO `mdt_impound` (`vehicleid`, `linkedreport`, `fee`, `time`) VALUES (:vehicleid, :linkedreport, :fee, :time)', {
									vehicleid = data['id'],
									linkedreport = linkedreport,
									fee = fee,
									time = os.time() + (time * 60)
								}, function(res)
									local npwdPlayerData = exports.npwd.getPlayerData({ identifier = Player.identifier })

									local data = {
										vehicleid = data['id'],
										plate = plate,
										beingcollected = 0,
										vehicle = sentVehicle,
										officer = Player.name,
										number = npwdPlayerData.phoneNumber,
										time = os.time() * 1000,
										src = src,
									}
									local vehicle = NetworkGetEntityFromNetworkId(sentVehicle)
									FreezeEntityPosition(vehicle, true)
									impound[#impound+1] = data

									TriggerClientEvent("police:client:ImpoundVehicle", src, true, fee)
								end)
								-- Read above comment
							end
						end
					else
						if vehicle.impoundid ~= nil then
							local data = vehicle
							local result = MySQL.single.await("SELECT id, vehicle, fuel, engine, body FROM `player_vehicles` WHERE plate=:plate LIMIT 1", { plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")})
							if result then
								local data = result
								MySQL.update("DELETE FROM `mdt_impound` WHERE vehicleid=:vehicleid", { vehicleid = data['id'] })

								result.currentSelection = impoundInfo.CurrentSelection
								result.plate = plate
								TriggerClientEvent('ps-mdt:client:TakeOutImpound', src, result)
							end

						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent('mdt:server:searchCalls', function(calls)
	local Player = GetPlayerData(source)
	local JobType = GetJobType(Player.job.name)
	if JobType == 'police' then
		TriggerClientEvent('mdt:client:getCalls', Player.source, calls)
	end
end)

ESX.RegisterServerCallback('mdt:server:SearchWeapons', function(source, cb, sentData)
	if not sentData then  return cb({}) end
	local Player = GetPlayerData(source)
	if not PermCheck(source, Player) then return cb({}) end
	if Player then
		local JobType = GetJobType(Player.job.name)
		if JobType == 'police' or JobType == 'doj' then
			local matches = MySQL.query.await('SELECT * FROM mdt_weaponinfo WHERE LOWER(`serial`) LIKE :query OR LOWER(`weapModel`) LIKE :query OR LOWER(`owner`) LIKE :query LIMIT 25', {
				query = string.lower('%'..sentData..'%')
			})
			cb(matches)
		end
	end
end)

RegisterNetEvent('mdt:server:saveWeaponInfo', function(serial, imageurl, notes, owner, weapClass, weapModel)
	if serial then
		local Player = GetPlayerData(source)
		if not PermCheck(source, PlayerData) then return cb({}) end
		if Player then
			local JobType = GetJobType(Player.job.name)
			if JobType == 'police' or JobType == 'doj' then
				local fullname = Player.name
				if imageurl == nil then imageurl = 'img/not-found.webp' end
				--AddLog event?
				local result = false
				result = MySQL.Async.insert('INSERT INTO mdt_weaponinfo (serial, owner, information, weapClass, weapModel, image) VALUES (:serial, :owner, :notes, :weapClass, :weapModel, :imageurl) ON DUPLICATE KEY UPDATE owner = :owner, information = :notes, weapClass = :weapClass, weapModel = :weapModel, image = :imageurl', {
					['serial'] = serial,
					['owner'] = owner,
					['notes'] = notes,
					['weapClass'] = weapClass,
					['weapModel'] = weapModel,
					['imageurl'] = imageurl,
				})

				if result then
					TriggerEvent('mdt:server:AddLog', "A weapon with the serial number ("..serial..") was added to the weapon information database by "..fullname)
				else
					TriggerEvent('mdt:server:AddLog', "A weapon with the serial number ("..serial..") failed to be added to the weapon information database by "..fullname)
				end
			end
		end
	end
end)

function CreateWeaponInfo(serial, imageurl, notes, owner, weapClass, weapModel)

	local results = MySQL.query.await('SELECT * FROM mdt_weaponinfo WHERE serial = ?', { serial })
	if results[1] then
		return
	end

	if serial == nil then return end
	if imageurl == nil then imageurl = 'img/not-found.webp' end

	MySQL.Async.insert('INSERT INTO mdt_weaponinfo (serial, owner, information, weapClass, weapModel, image) VALUES (:serial, :owner, :notes, :weapClass, :weapModel, :imageurl) ON DUPLICATE KEY UPDATE owner = :owner, information = :notes, weapClass = :weapClass, weapModel = :weapModel, image = :imageurl', {
		['serial'] = serial,
		['owner'] = owner,
		['notes'] = notes,
		['weapClass'] = weapClass,
		['weapModel'] = weapModel,
		['imageurl'] = imageurl,
	})
end

exports('CreateWeaponInfo', CreateWeaponInfo)

RegisterNetEvent('mdt:server:getWeaponData', function(serial)
	if serial then
		local Player = GetPlayerData(source)
		if Player then
			local JobType = GetJobType(Player.job.name)
			if JobType == 'police' or JobType == 'doj' then
				local results = MySQL.query.await('SELECT * FROM mdt_weaponinfo WHERE serial = ?', { serial })
				TriggerClientEvent('mdt:client:getWeaponData', Player.source, results)
			end
		end
	end
end)

RegisterNetEvent('mdt:server:getAllLogs', function()
	local src = source
	local Player = GetPlayerData(source)
	if Player then
		if Config.LogPerms[Player.job.name] then
			if Config.LogPerms[Player.job.name][Player.job.grade] then

				local JobType = GetJobType(Player.job.name)
				local infoResult = MySQL.query.await('SELECT * FROM mdt_logs WHERE `jobtype` = :jobtype ORDER BY `id` DESC LIMIT 250', {jobtype = JobType})

				TriggerLatentClientEvent('mdt:client:getAllLogs', src, 30000, infoResult)
			end
		end
	end
end)

-- Penal Code

local function IsCidFelon(sentCid, cb)
	if sentCid then
		local convictions = MySQL.query.await('SELECT charges FROM mdt_convictions WHERE cid=:cid', { cid = sentCid })
		local Charges = {}
		for i=1, #convictions do
			local currCharges = json.decode(convictions[i]['charges'])
			for x=1, #currCharges do
				Charges[#Charges+1] = currCharges[x]
			end
		end
		local PenalCode = Config.PenalCode
		for i=1, #Charges do
			for p=1, #PenalCode do
				for x=1, #PenalCode[p] do
					if PenalCode[p][x]['title'] == Charges[i] then
						if PenalCode[p][x]['class'] == 'Felony' then
							cb(true)
							return
						end
						break
					end
				end
			end
		end
		cb(false)
	end
end

exports('IsCidFelon', IsCidFelon) -- exports['erp_mdt']:IsCidFelon()

RegisterCommand("isfelon", function(source, args, rawCommand)
	IsCidFelon(1998, function(res)
	end)
end, false)

RegisterNetEvent('mdt:server:getPenalCode', function()
	local src = source
	TriggerClientEvent('mdt:client:getPenalCode', src, Config.PenalCodeTitles, Config.PenalCode)
end)

RegisterNetEvent('mdt:server:setCallsign', function(cid, newcallsign)
	local Player = ESX.GetPlayerFromIdentifier(cid)
	Player.setMeta("callsign:"..Player.job.name, newcallsign)
	if (GetActiveData(Player.identifier)) then
		activeUnits[Player.identifier].callSign =  newcallsign
	end
end)

RegisterNetEvent('mdt:server:saveIncident', function(id, title, information, tags, officers, civilians, evidence, associated, time)
    local src = source
    local Player = ESX.GetPlayerFromId(source)
    if Player then
        if GetJobType(Player.job.name) == 'police' then
            if id == 0 then
                local fullname = Player.name
                MySQL.insert('INSERT INTO `mdt_incidents` (`author`, `title`, `details`, `tags`, `officersinvolved`, `civsinvolved`, `evidence`, `time`, `jobtype`) VALUES (:author, :title, :details, :tags, :officersinvolved, :civsinvolved, :evidence, :time, :jobtype)',
                {
                    author = fullname,
                    title = title,
                    details = information,
                    tags = json.encode(tags),
                    officersinvolved = json.encode(officers),
                    civsinvolved = json.encode(civilians),
                    evidence = json.encode(evidence),
                    time = time,
                    jobtype = 'police',
                }, function(infoResult)
                    if infoResult then
                        MySQL.Async.fetchAll('SELECT `author`, `title`, `details` FROM `mdt_incidents` WHERE `id` = @id', { ['@id'] = infoResult }, function(result)
                            if result and #result > 0 then
                                local message = generateMessageFromResult(result)
                                
                                for i=1, #associated do
                                    local associatedData = {
                                        cid = associated[i]['Cid'],
                                        linkedincident = associated[i]['LinkedIncident'],
                                        warrant = associated[i]['Warrant'],
                                        guilty = associated[i]['Guilty'],
                                        processed = associated[i]['Processed'],
                                        associated = associated[i]['Isassociated'],
                                        charges = json.encode(associated[i]['Charges']),
                                        fine = tonumber(associated[i]['Fine']),
                                        sentence = tonumber(associated[i]['Sentence']),
                                        recfine = tonumber(associated[i]['recfine']),
                                        recsentence = tonumber(associated[i]['recsentence']),
                                        time = associated[i]['Time'],
                                        officersinvolved = officers,
                                        civsinvolved = civilians
                                    }
                                    sendIncidentToDiscord(3989503, "MDT Incident Report", message, "ps-mdt | Made by Project Sloth", associatedData)                                
                                end
                            else
                                print('No incident found in the mdt_incidents table with id: ' .. infoResult)
                            end
                        end)
                        
                        for i=1, #associated do
                            MySQL.insert('INSERT INTO `mdt_convictions` (`cid`, `linkedincident`, `warrant`, `guilty`, `processed`, `associated`, `charges`, `fine`, `sentence`, `recfine`, `recsentence`, `time`) VALUES (:cid, :linkedincident, :warrant, :guilty, :processed, :associated, :charges, :fine, :sentence, :recfine, :recsentence, :time)', {
                                cid = associated[i]['Cid'],
                                linkedincident = infoResult,
                                warrant = associated[i]['Warrant'],
                                guilty = associated[i]['Guilty'],
                                processed = associated[i]['Processed'],
                                associated = associated[i]['Isassociated'],
                                charges = json.encode(associated[i]['Charges']),
                                fine = tonumber(associated[i]['Fine']),
                                sentence = tonumber(associated[i]['Sentence']),
                                recfine = tonumber(associated[i]['recfine']),
                                recsentence = tonumber(associated[i]['recsentence']),
                                time = time,
                                officersinvolved = officers,
                                civsinvolved = civilians
                            })
                        end
                        TriggerClientEvent('mdt:client:updateIncidentDbId', src, infoResult)
                    end
                end)
            elseif id > 0 then
                MySQL.Async.fetchAll('SELECT `author`, `title`, `details` FROM `mdt_incidents` WHERE `id` = @id', { ['@id'] = id }, function(result)
                    if result and #result > 0 then
                        local message = generateMessageFromResult(result)
                        
                        for i=1, #associated do
                            local associatedData = {
                                cid = associated[i]['Cid'],
                                linkedincident = associated[i]['LinkedIncident'],
                                warrant = associated[i]['Warrant'],
                                guilty = associated[i]['Guilty'],
                                processed = associated[i]['Processed'],
                                associated = associated[i]['Isassociated'],
                                charges = json.encode(associated[i]['Charges']),
                                fine = tonumber(associated[i]['Fine']),
                                sentence = tonumber(associated[i]['Sentence']),
                                recfine = tonumber(associated[i]['recfine']),
                                recsentence = tonumber(associated[i]['recsentence']),
                                time = associated[i]['Time'],
                                officersinvolved = officers,
                                civsinvolved = civilians
                            }
                            sendIncidentToDiscord(16711680, "MDT Incident Report has been Updated", message, "ps-mdt | Made by Project Sloth", associatedData)
                        end
                    else
                        print('No incident found in the mdt_incidents table with id: ' .. id)
                    end
                end)

                MySQL.Async.execute('UPDATE `mdt_incidents` SET `title` = @title, `details` = @details, `tags` = @tags, `officersinvolved` = @officersinvolved, `civsinvolved` = @civsinvolved, `evidence` = @evidence, `time` = @time WHERE `id` = @id',
                {
                    ['@id'] = id,
                    ['@title'] = title,
                    ['@details'] = information,
                    ['@tags'] = json.encode(tags),
                    ['@officersinvolved'] = json.encode(officers),
                    ['@civsinvolved'] = json.encode(civilians),
                    ['@evidence'] = json.encode(evidence),
                    ['@time'] = time,
                }, function(rowsChanged)
                    if rowsChanged > 0 then
                        --print('Updated incident' .. id)
                    else
                        print('Failed to update incident with id: ' .. id)
                    end
                end)

                for i=1, #associated do
                    TriggerEvent('mdt:server:handleExistingConvictions', associated[i], id, time)
                end
            end
        end
    end
end)

RegisterNetEvent('mdt:server:handleExistingConvictions', function(data, incidentId, time)
	MySQL.query('SELECT * FROM mdt_convictions WHERE cid=:cid AND linkedincident=:linkedincident', {
		cid = data['Cid'],
		linkedincident = incidentId
	}, function(convictionRes)
		if convictionRes and convictionRes[1] and convictionRes[1]['id'] then
			MySQL.update('UPDATE mdt_convictions SET cid=:cid, linkedincident=:linkedincident, warrant=:warrant, guilty=:guilty, processed=:processed, associated=:associated, charges=:charges, fine=:fine, sentence=:sentence, recfine=:recfine, recsentence=:recsentence WHERE cid=:cid AND linkedincident=:linkedincident', {
				cid = data['Cid'],
				linkedincident = incidentId,
				warrant = data['Warrant'],
				guilty = data['Guilty'],
				processed = data['Processed'],
				associated = data['Isassociated'],
				charges = json.encode(data['Charges']),
				fine = tonumber(data['Fine']),
				sentence = tonumber(data['Sentence']),
				recfine = tonumber(data['recfine']),
				recsentence = tonumber(data['recsentence']),
			})
		else
			MySQL.insert('INSERT INTO `mdt_convictions` (`cid`, `linkedincident`, `warrant`, `guilty`, `processed`, `associated`, `charges`, `fine`, `sentence`, `recfine`, `recsentence`, `time`) VALUES (:cid, :linkedincident, :warrant, :guilty, :processed, :associated, :charges, :fine, :sentence, :recfine, :recsentence, :time)', {
				cid = data['Cid'],
				linkedincident = incidentId,
				warrant = data['Warrant'],
				guilty = data['Guilty'],
				processed = data['Processed'],
				associated = data['Isassociated'],
				charges = json.encode(data['Charges']),
				fine = tonumber(data['Fine']),
				sentence = tonumber(data['Sentence']),
				recfine = tonumber(data['recfine']),
				recsentence = tonumber(data['recsentence']),
				time = time
			})
		end
	end)
end)

RegisterNetEvent("mdt:server:sentencePlayer", function(targetCitizen, caseId, sentence, charges) 
	local player = ESX.GetPlayerFromIdentifier(targetCitizen)
	local sourcePlayer = ESX.GetPlayerFromId(source)

	if (not player) then
		return sourcePlayer.showNotification("This user is not in the city", "error")
	end

	local distanceToPlayer = exports.stem_common:getDistanceToCoord(sourcePlayer.source, GetEntityCoords(GetPlayerPed(player.source)))
	if (distanceToPlayer > 25) then
		return sourcePlayer.showNotification("You are too far away from the player", "error")
	end
	
	local bills = {}

	for key, value in pairs(charges) do
		if (chargesByName[value]) then
			table.insert(bills, {
				title = chargesByName[value].title,
				case = caseId,
				category = chargesByName[value].class,
				amount = chargesByName[value].fine
			})
		end
	end


	exports.esx_billing:sendCriminalBills(player.source, bills)
	
	if (GetJobType(sourcePlayer.job.name) == "police" or GetJobType(sourcePlayer.job.name) == "doj" and sentence > 0) then
		sourcePlayer.showNotification(string.format("You've jailed %s for %s months.", player.name, sentence))
		TriggerClientEvent("wasabi_police:uncuff", player.source)
		return exports.pickle_prisons:JailPlayer(sourcePlayer.source, player.source, sentence)
	end
end)

RegisterNetEvent("mdt:server:finePlayer", function(targetCitizen, fineAmount, indicentId) 
	local player = ESX.GetPlayerFromIdentifier(targetCitizen)
	local sourcePlayer = ESX.GetPlayerFromId(source)
	if (not player) then
		return sourcePlayer.showNotification("This user is not in the city", "error")
	end

	if (GetJobType(sourcePlayer.job.name) == "police" or GetJobType(sourcePlayer.job.name) == "doj") then
		sourcePlayer.showNotification(string.format("You've fined %s for $ %s", player.name, ESX.Math.GroupDigits(fineAmount)))
		MySQL.insert('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (?, ?, ?, ?, ?, ?)', {player.identifier, sourcePlayer.identifier, 'fine', "society_police", string.format("Incident %s fine", indicentId), fineAmount},
		function(rowsChanged)
			player.showNotification(string.format("You've been fined $%s", ESX.Math.GroupDigits(fineAmount)))
		end)
	end
end)

RegisterNetEvent('mdt:server:removeIncidentCriminal', function(cid, incident)
	MySQL.update('DELETE FROM mdt_convictions WHERE cid=:cid AND linkedincident=:linkedincident', {
		cid = cid,
		linkedincident = incident
	})
end)

-- Dispatch
RegisterNetEvent('mdt:server:setWaypoint', function(callid)
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	local callid = tonumber(callid)
	local JobType = GetJobType(Player.job.name)
	if not callid then return end
	if JobType == 'police' or JobType == 'ambulance' then
		if isDispatchRunning then
			for i = 1, #calls do
				if calls[i]['id'] == callid then
					TriggerClientEvent('mdt:client:setWaypoint', src, calls[i])
					return
				end
			end
		end
	end
end)

RegisterNetEvent('mdt:server:attachedUnits', function(callid)
    local src = source
	local Player = ESX.GetPlayerFromId(src)
    local JobType = GetJobType(Player.job.name)
	if not callid then return end
    if JobType == 'police' or JobType == 'ambulance' then
        if isDispatchRunning then
            for i = 1, #calls do
                if calls[i]['id'] == callid then
                    TriggerClientEvent('mdt:client:attachedUnits', src, calls[i]['units'], callid)
                    return
                end
            end
        end
    end
end)

RegisterNetEvent('mdt:server:setDispatchWaypoint', function(callid, cid)
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	local callid = tonumber(callid)
	local JobType = GetJobType(Player.job.name)
	if not callid then return end
	if JobType == 'police' or JobType == 'ambulance' then
		if isDispatchRunning then
			for i = 1, #calls do
				if calls[i]['id'] == callid then
					TriggerClientEvent('mdt:client:setWaypoint', src, calls[i])
					return
				end
			end
		end
	end
end)

RegisterNetEvent('mdt:server:callDragAttach', function(callid, cid)
	local src = source
	local Player = ESX.GetPlayerFromId(src)

	local playerdata = {
		name = Player.variables.firstName.. " "..Player.variables.lastName,
		job = Player.job.name,
		cid = Player.license,
		callsign = Player.getMeta("callsign:"..Player.job.name) or Player.getMeta("callsign")
	}
	local callid = tonumber(callid)
	local JobType = GetJobType(Player.job.name)
	if JobType == 'police' or JobType == 'ambulance' then
		if callid then
			local newNum = exports["ps-dispatch"]:attachUnit(callid, playerdata)
			TriggerClientEvent('mdt:client:callAttach', -1, callid, newNum)
		end
	end
end)

RegisterNetEvent('mdt:server:setWaypoint:unit', function(cid)
	local src = source
	local Player = ESX.GetPlayerFromIdentifier(cid)
	local PlayerCoords = GetEntityCoords(GetPlayerPed(Player.source))
	TriggerClientEvent("mdt:client:setWaypoint:unit", src, PlayerCoords)
end)

-- Dispatch chat

RegisterNetEvent('mdt:server:sendMessage', function(message, time)
	if message and time then
		local src = source	
		local Player = ESX.GetPlayerFromId(src)
		if Player then
			MySQL.scalar("SELECT pfp FROM `mdt_data` WHERE cid=@id LIMIT 1", {
				["@id"] = Player.identifier -- % wildcard, needed to search for all alike results
			}, function(data)
				if data == "" then data = nil end
				local ProfilePicture = ProfPic(Player.get("sex"), data)
				local callsign = Player.getMeta("callsign:"..Player.job.name) or Player.getMeta("callsign") or "000"
				local Item = {
					profilepic = ProfilePicture,
					callsign = callsign,
					cid = Player.identifier,
					name = '('..callsign..') '..Player.name,
					message = message,
					time = time,
					job = Player.job.name
				}
				dispatchMessages[#dispatchMessages+1] = Item
				TriggerClientEvent('mdt:client:dashboardMessage', -1, Item)
			end)
		end
	end
end)

RegisterNetEvent('mdt:server:refreshDispatchMsgs', function()
	local src = source
	local PlayerData = GetPlayerData(src)
	if IsJobAllowedToMDT(PlayerData.job.name) then
		TriggerClientEvent('mdt:client:dashboardMessages', src, dispatchMessages)
	end
end)

RegisterNetEvent('mdt:server:getCallResponses', function(callid)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if IsPoliceOrEms(Player.PlayerData.job.name) then
		if isDispatchRunning then
			
			TriggerClientEvent('mdt:client:getCallResponses', src, calls[callid]['responses'], callid)
		end
	end
end)

RegisterNetEvent('mdt:server:sendCallResponse', function(message, time, callid)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local name = Player.PlayerData.charinfo.firstname.. " "..Player.PlayerData.charinfo.lastname
	if IsPoliceOrEms(Player.PlayerData.job.name) then
		TriggerEvent('dispatch:sendCallResponse', src, callid, message, time, function(isGood)
			if isGood then
				TriggerClientEvent('mdt:client:sendCallResponse', -1, message, time, callid, name)
			end
		end)
	end
end)

RegisterNetEvent('mdt:server:setRadio', function(cid, newRadio)
	local src = source
	local targetPlayer = QBCore.Functions.GetPlayerByCitizenId(cid)
	local targetSource = targetPlayer.PlayerData.source
	local targetName = targetPlayer.PlayerData.charinfo.firstname .. ' ' .. targetPlayer.PlayerData.charinfo.lastname

	local radio = targetPlayer.Functions.GetItemByName("radio")
	if radio ~= nil then
		TriggerClientEvent('mdt:client:setRadio', targetSource, newRadio)
	else
		TriggerClientEvent("QBCore:Notify", src, targetName..' does not have a radio!', 'error')
	end
end)

local function isRequestVehicle(vehId)
	local found = false
	for i=1, #impound do
		if impound[i]['vehicle'] == vehId then
			found = true
			impound[i] = nil
			break
		end
	end
	return found
end
exports('isRequestVehicle', isRequestVehicle)

RegisterNetEvent('mdt:server:impoundVehicle', function(sentInfo, sentVehicle)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player then
		if GetJobType(Player.PlayerData.job.name) == 'police' then
			if sentInfo and type(sentInfo) == 'table' then
				local plate, linkedreport, fee, time = sentInfo['plate'], sentInfo['linkedreport'], sentInfo['fee'], sentInfo['time']
				if (plate and linkedreport and fee and time) then
				local vehicle = MySQL.query.await("SELECT id, plate FROM `player_vehicles` WHERE plate=:plate LIMIT 1", { plate = string.gsub(plate, "^%s*(.-)%s*$", "%1") })
					if vehicle and vehicle[1] then
						local data = vehicle[1]
						MySQL.insert('INSERT INTO `mdt_impound` (`vehicleid`, `linkedreport`, `fee`, `time`) VALUES (:vehicleid, :linkedreport, :fee, :time)', {
							vehicleid = data['id'],
							linkedreport = linkedreport,
							fee = fee,
							time = os.time() + (time * 60)
						}, function(res)
							local data = {
								vehicleid = data['id'],
								plate = plate,
								beingcollected = 0,
								vehicle = sentVehicle,
								officer = Player.PlayerData.charinfo.firstname.. " "..Player.PlayerData.charinfo.lastname,
								number = Player.PlayerData.charinfo.phone,
								time = os.time() * 1000,
								src = src,
							}
							local vehicle = NetworkGetEntityFromNetworkId(sentVehicle)
							FreezeEntityPosition(vehicle, true)
							impound[#impound+1] = data

							TriggerClientEvent("police:client:ImpoundVehicle", src, true, fee)
						end)
					end
				end
			end
		end
	end
end)

RegisterNetEvent('mdt:server:getImpoundVehicles', function()
	TriggerClientEvent('mdt:client:getImpoundVehicles', source, impound)
end)

RegisterNetEvent('mdt:server:removeImpound', function(plate, currentSelection)
	print("Removing impound", plate, currentSelection)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player then
		if GetJobType(Player.PlayerData.job.name) == 'police' then
			local result = MySQL.single.await("SELECT id, vehicle FROM `player_vehicles` WHERE plate=:plate LIMIT 1", { plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")})
			if result and result[1] then
				local data = result[1]
				MySQL.update("DELETE FROM `mdt_impound` WHERE vehicleid=:vehicleid", { vehicleid = data['id'] })
				TriggerClientEvent('police:client:TakeOutImpound', src, currentSelection)
			end
		end
	end
end)

RegisterNetEvent('mdt:server:statusImpound', function(plate)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player then
		if GetJobType(Player.PlayerData.job.name) == 'police' then
			local vehicle = MySQL.query.await("SELECT id, plate FROM `player_vehicles` WHERE plate=:plate LIMIT 1", { plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")})
			if vehicle and vehicle[1] then
				local data = vehicle[1]
				local impoundinfo = MySQL.query.await("SELECT * FROM `mdt_impound` WHERE vehicleid=:vehicleid LIMIT 1", { vehicleid = data['id'] })
				if impoundinfo and impoundinfo[1] then
					TriggerClientEvent('mdt:client:statusImpound', src, impoundinfo[1], plate)
				end
			end
		end
	end
end)

RegisterServerEvent("mdt:server:AddLog", function(text)
	AddLog(text)
end)

function GetBoloStatus(plate)

    local result = MySQL.query.await("SELECT * FROM mdt_bolos where plate = @plate", {['@plate'] = plate})
	if result and result[1] then
		local title = result[1]['title']
		local boloId = result[1]['id']
		return true, title, boloId
	end

	return false
end

function GetWarrantStatus(plate)
    local result = MySQL.query.await("SELECT p.plate, p.owner, m.id FROM owned_vehicles p INNER JOIN mdt_convictions m ON p.owner = m.cid WHERE m.warrant =1 AND p.plate =?", {plate})
	if result and result[1] then
		local citizenid = result[1]['owner']
		local Player = ESX.GetPlayerFromIdentifier(citizenid)
		local owner = Player.name;
		local incidentId = result[1]['id']
		return true, owner, incidentId
	end
	return false
end

function GetVehicleInformation(plate)
	local result = MySQL.query.await('SELECT * FROM mdt_vehicleinfo WHERE plate = @plate', {['@plate'] = plate})
    if result[1] then
        return result[1]
    else
        return false
    end
end

function GetVehicleOwner(plate)

	local result = MySQL.query.await('SELECT plate, owner, model FROM owned_vehicles WHERE plate = @plate', {['@plate'] = plate})
	if result and result[1] then
		local citizenid = result[1]['owner']
		local Player = ESX.GetPlayerFromIdentifier(citizenid)
		local owner = Player.name
		return owner
	end
end

-- Returns the source for the given citizenId
ESX.RegisterServerCallback('mdt:server:GetPlayerSourceId', function(source, cb, targetCitizenId)
    local targetPlayer = QBCore.Functions.GetPlayerByCitizenId(targetCitizenId)
    if targetPlayer == nil then 
        TriggerClientEvent('esx:showNotification', source, "Citizen seems Asleep / Missing", "error")
        return
    end
    local targetSource = targetPlayer.PlayerData.source

    cb(targetSource)
end)

ESX.RegisterServerCallback('getWeaponInfo', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local weaponInfos = {}
	if Config.InventoryForWeaponsImages == "ox_inventory" then
		local inv = exports.ox_inventory:GetInventoryItems(source)
		for _, item in pairs(inv) do
			if string.find(item.name, "WEAPON_") then
				local invImage = ("https://cfx-nui-ox_inventory/web/images/%s.png"):format(item.name)
				if invImage then
					weaponInfo = {
						serialnumber = item.metadata.serial,
						owner = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
						weaponmodel = QBCore.Shared.Items[string.lower(item.name)].label,
						weaponurl = invImage,
						notes = "Self Registered",
						weapClass = "Class 1",
					}
					break
				end
			end
		end
	else -- qb/lj
		for _, item in pairs(Player.PlayerData.items) do
			if item.type == "weapon" then
				local invImage = ("https://cfx-nui-%s/html/images/%s"):format(Config.InventoryForWeaponsImages, item.image)
				if invImage then
					local weaponInfo = {
						serialnumber = item.info.serie,
						owner = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
						weaponmodel = QBCore.Shared.Items[item.name].label,
						weaponurl = invImage,
						notes = "Self Registered",
						weapClass = "Class 1",
					}
					table.insert(weaponInfos, weaponInfo)
				end
			end
		end	
	end
    cb(weaponInfos)
end)

ESX.RegisterServerCallback("ps-mdt:getSelfData", function (source, cb) 
    local player = ESX.GetPlayerFromId(source)
    cb({
        duty = player.getMeta("duty:"..player.job.name),
        callsign = player.getMeta("callsign:"..player.job.name)
    })
end)

RegisterNetEvent('mdt:server:registerweapon', function(serial, imageurl, notes, owner, weapClass, weapModel) 
    exports['ps-mdt']:CreateWeaponInfo(serial, imageurl, notes, owner, weapClass, weapModel)
end)

local function giveCitationItem(src, citizenId, fine, incidentId)
	local Player = ESX.GetPlayerFromIdentifier(citizenId)
	local PlayerName = Player.name
	local Officer = ESX.GetPlayerFromId(src)
	local OfficerFullName = '(' .. Officer.getMeta("callsign:"..Officer.job.name) or Officer.getMeta("callsign") .. ') ' .. Officer.name
	local info = {}
	local date = os.date("%Y-%m-%d %H:%M")
	if Config.InventoryForWeaponsImages == "ox_inventory" then
		info = {
			description = {
				'Citizen ID: ' .. citizenId '  \n',
				'Fine: $ ' .. fine '  \n',
				'Date: ' .. date '  \n',
				'Incitent ID: # ' .. incidentId '  \n',
				'Officer: ' .. OfficerFullName
			}
		}
	else
		info = {
			citizenId = citizenId,
			fine = "$"..fine,
			date = date,
			incidentId = "#"..incidentId,
			officer = OfficerFullName,
		}
	end
	-- Player.Functions.AddItem('mdtcitation', 1, false, info)
	TriggerClientEvent('esx:showNotification', src, PlayerName.." (" ..citizenId.. ") received a citation!")
	if Config.QBBankingUse then 
		exports['qb-banking']:AddMoney(Officer.job.name, fine) 
	end
	TriggerClientEvent('inventory:client:ItemBox', Player.source, QBCore.Shared.Items['mdtcitation'], "add")
	TriggerEvent('mdt:server:AddLog', "A Fine was writen by "..OfficerFullName.." and was sent to "..PlayerName..", the Amount was $".. fine ..". (ID: "..incidentId.. ")")
end

-- Removes money from the players bank and gives them a citation item
RegisterNetEvent('mdt:server:removeMoney', function(citizenId, fine, incidentId)
	local src = source
	local Player = QBCore.Functions.GetPlayerByCitizenId(citizenId)
	
	if not antiSpam then
		if Player.Functions.RemoveMoney('bank', fine, 'lspd-fine') then
			TriggerClientEvent('esx:showNotification', Player.PlayerData.source, fine.."$ was removed from your bank!")
			giveCitationItem(src, citizenId, fine, incidentId)
		else
			TriggerClientEvent('esx:showNotification', Player.PlayerData.source, "Something went wrong!")
		end
		antiSpam = true
		SetTimeout(60000, function()
			antiSpam = false
		end)
	else
		TriggerClientEvent('esx:showNotification', src, "On cooldown!")
	end
end)

-- Gives the player a citation item
RegisterNetEvent('mdt:server:giveCitationItem', function(citizenId, fine, incidentId)
	local src = source
	giveCitationItem(src, citizenId, fine, incidentId)
end)

function getTopOfficers(callback)
    local result = {}
    local query = 'SELECT * FROM mdt_clocking ORDER BY total_time DESC LIMIT 25'
    MySQL.Async.fetchAll(query, {}, function(officers)
        for k, officer in ipairs(officers) do
            table.insert(result, {
                rank = k,
                name = officer.firstname .. " " .. officer.lastname,
                callsign = officer.user_id,
                totalTime = format_time(officer.total_time)
            })
        end
        callback(result)
    end)
end

RegisterServerEvent("mdt:requestOfficerData")
AddEventHandler("mdt:requestOfficerData", function()
    local src = source
    getTopOfficers(function(officerData)
        TriggerClientEvent("mdt:receiveOfficerData", src, officerData)
    end)
end)

function sendToDiscord(color, name, message, footer)
	if ClockinWebhook == '' then
		print("\27[31mA webhook is missing in: ClockinWebhook (server > main.lua > line 20)\27[0m")
	else
		local embed = {
			{
				color = color,
				title = "**".. name .."**",
				description = message,
				footer = {
					text = footer,
				},
			}
		}
	
		PerformHttpRequest(ClockinWebhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
	end
end

function sendIncidentToDiscord(color, name, message, footer, associatedData)
    local rolePing = "<@&1074119792258199582>" -- DOJ role to be pigned when the person is not Guilty.
    local pingMessage = ""

    if IncidentWebhook == '' then
        print("\27[31mA webhook is missing in: IncidentWebhook (server > main.lua > line 24)\27[0m")
    else
        if associatedData then
            message = message .. "\n\n--- Associated Data ---"
            message = message .. "\nCID: " .. (associatedData.cid or "Not Found")
            
            if associatedData.guilty == false then
                pingMessage = "**Guilty: Not Guilty - Need Court Case** " .. rolePing
                message = message .. "\n" .. pingMessage
            else
                message = message .. "\nGuilty: " .. tostring(associatedData.guilty or "Not Found")
            end
			
			
            if associatedData.officersinvolved and #associatedData.officersinvolved > 0 then
                local officersList = table.concat(associatedData.officersinvolved, ", ")
                message = message .. "\nOfficers Involved: " .. officersList
            else
                message = message .. "\nOfficers Involved: None"
            end

            if associatedData.civsinvolved and #associatedData.civsinvolved > 0 then
                local civsList = table.concat(associatedData.civsinvolved, ", ")
                message = message .. "\nCivilians Involved: " .. civsList
            else
                message = message .. "\nCivilians Involved: None"
            end


            message = message .. "\nWarrant: " .. tostring(associatedData.warrant or "No Warrants")
            message = message .. "\nReceived Fine: $" .. tostring(associatedData.fine or "Not Found")
            message = message .. "\nReceived Sentence: " .. tostring(associatedData.sentence or "Not Found")
            message = message .. "\nRecommended Fine: $" .. tostring(associatedData.recfine or "Not Found")
            message = message .. "\nRecommended Sentence: " .. tostring(associatedData.recsentence or "Not Found")

            local chargesTable = json.decode(associatedData.charges)
            if chargesTable and #chargesTable > 0 then
                local chargeList = table.concat(chargesTable, "\n")
                message = message .. "\n**Charges:** \n" .. chargeList
            else
                message = message .. "\n**Charges: No Charges**"
            end
        end

        local embed = {
            {
                color = color,
                title = "**".. name .."**",
                description = message,
                footer = {
                    text = footer,
                },
            }
        }

        PerformHttpRequest(IncidentWebhook, function(err, text, headers) end, 'POST', json.encode({content = pingMessage, username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })	
    end
end

function format_time(time)
    local days = math.floor(time / 86400)
    time = time % 86400
    local hours = math.floor(time / 3600)
    time = time % 3600
    local minutes = math.floor(time / 60)
    local seconds = time % 60

    local formattedTime = ""
    if days > 0 then
        formattedTime = string.format("%d day%s ", days, days == 1 and "" or "s")
    end
    if hours > 0 then
        formattedTime = formattedTime .. string.format("%d hour%s ", hours, hours == 1 and "" or "s")
    end
    if minutes > 0 then
        formattedTime = formattedTime .. string.format("%d minute%s ", minutes, minutes == 1 and "" or "s")
    end
    if seconds > 0 then
        formattedTime = formattedTime .. string.format("%d second%s", seconds, seconds == 1 and "" or "s")
    end
    return formattedTime
end

function GetPlayerPropertiesByCitizenId(citizenid)
    local properties = {}

    local result = MySQL.Sync.fetchAll("SELECT * FROM properties WHERE owner_citizenid = @citizenid", {
        ['@citizenid'] = citizenid
    })

    if result and #result > 0 then
        for i = 1, #result do
            table.insert(properties, result[i])
        end
    end

    return properties
end

function generateMessageFromResult(result)
    local author = result[1].author
    local title = result[1].title
    local details = result[1].details
    details = details:gsub("<[^>]+>", ""):gsub("&nbsp;", "")
    local message = "Author: " .. author .. "\n"
    message = message .. "Title: " .. title .. "\n"
    message = message .. "Details: " .. details
    return message
end
