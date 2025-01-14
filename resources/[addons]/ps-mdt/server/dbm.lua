
-- Get CitizenIDs from Player License
function GetCitizenID(license)
    local result = MySQL.query.await("SELECT id FROM users WHERE license = ?", {license,})
    if result ~= nil then
        return result
    else
        print("Cannot find a CitizenID for License: "..license)
        return nil
    end
end

-- (Start) Opening the MDT and sending data
function AddLog(text)
    return MySQL.insert.await('INSERT INTO `mdt_logs` (`text`, `time`) VALUES (?,?)', {text, os.time() * 1000})
end

function GetNameFromId(cid)
	local result = MySQL.single .await('SELECT firstname, lastname FROM users WHERE identifier = @id', { ['@id'] = cid })
    if result ~= nil then
        local fullname = result['firstname']..' '..result['lastname']
        return fullname
    else
        --print('Player does not exist')
        return nil
    end
end

function GetPersonInformation(cid, jobtype)
    local result = MySQL.query.await('SELECT information, tags, gallery, pfp, fingerprint FROM mdt_data WHERE cid = ? and jobtype = ?', { cid,  jobtype})
    return result[1]
end

function GetIncidentName(id)
	local result = MySQL.query.await('SELECT title FROM `mdt_incidents` WHERE id = :id LIMIT 1', { id = id })
    return result[1]
end

function GetConvictions(cids)
	return MySQL.query.await('SELECT * FROM `mdt_convictions` WHERE `cid` IN(?)', { cids })
end

function GetLicenseInfo(cid)
	local result = MySQL.query.await('SELECT * FROM `licenses` WHERE `cid` = ?', { cid })
	return result
end

function CreateUser(cid, tableName)
	AddLog("A user was created with the CID: "..cid)
	return MySQL.insert.await("INSERT INTO `"..tableName.."` (cid) VALUES (:cid)", { cid = cid })
end

function GetPlayerVehicles(cid, cb)
	return MySQL.query.await('SELECT model, plate, vehicle FROM owned_vehicles WHERE owner = ?', { cid })
end

function GetBulletins(JobType)
	return MySQL.query.await('SELECT * FROM `mdt_bulletin` WHERE `jobtype` = ? LIMIT 10', { JobType })
end

function GetPlayerProperties(cid, cb)
	local result =  MySQL.query.await('SELECT houselocations.label, houselocations.coords FROM player_houses INNER JOIN houselocations ON player_houses.house = houselocations.name where player_houses.citizenid = ?', {cid})
	return result
end

function GetPlayerDataById(id)
    local Player = ESX.GetPlayerFromIdentifier(id)
    if Player ~= nil then

        local phone = exports.npwd:getPlayerData({ identifier = id })
        
		local response = {identifier = Player.identifier, charinfo = {
            firstname = Player.variables.firstName,
            lastname = Player.variables.lastName,
            dateofbirth = Player.get("dateofbirth"),
            phone = phone.phoneNumber
        }, metadata = Player.metadata, job = {
            name = Player.job.label,
            grade = Player.job.grade_label
        }}
        return response
    else
        local response = MySQL.single.await('SELECT * FROM users WHERE identifier = ? LIMIT 1', { id })
        local jobResponse = MySQL.single.await("SELECT label FROM job_grades WHERE job_name = ? AND grade = ?", { response.job, response.job_grade })
        local jobGradeResponse = MySQL.single.await("SELECT label FROM jobs WHERE name = ?", { response.job })

        return {identifier = id, charinfo = {
            firstname = response.firtname,
            lastname = response.lastname,
            dateofbirth = response.dateofbirth,
            phone = response.phone_number
        }, metadata = {}, job = {
            name = jobGradeResponse.label,
            grade = jobResponse.label
        }}
    end
end

function GetBoloStatus(plate)
	local result = MySQL.scalar.await('SELECT id FROM `mdt_bolos` WHERE LOWER(`plate`)=:plate', { plate = string.lower(plate)})
	return result
end

function GetOwnerName(cid)
	local result = MySQL.scalar.await('SELECT charinfo FROM `players` WHERE LOWER(`citizenid`) = ? LIMIT 1', {cid})
	return result
end

function GetVehicleInformation(plate, cb)
    local result = MySQL.query.await('SELECT id, information FROM `mdt_vehicleinfo` WHERE plate=:plate', { plate = plate})
	cb(result)
end

function GetPlayerApartment(cid, cb)
    local result =  MySQL.query.await('SELECT name, type, label FROM apartments where citizenid = ?', {cid})
    return result
end

function GetPlayerLicenses(identifier)
    local response = false
    local Player = ESX.GetPlayerFromIdentifier(identifier)
    local licenses = MySQL.query.await("SELECT user_licenses.type, licenses.label FROM user_licenses LEFT JOIN licenses ON user_licenses.type = licenses.type WHERE owner = ?", { identifier })
    local newLicenses = {
        ['drive'] = false,
        ['drive_bike'] = false,
        ['drive_truck'] = false,
        ['boat'] = false,
        ['weapon'] = false,
    }
    for key, value in pairs(licenses) do
        if (value and not newLicenses[value.type]) then newLicenses[value.type] = true end
    end
    return newLicenses;
end

function ManageLicense(identifier, type, status)
    local Player = QBCore.Functions.GetPlayerByCitizenId(identifier)
    local licenseStatus = nil
    if status == "give" then
        exports.esx_license:AddLicense(identifier, type)
    elseif status == "revoke" then
        exports.esx_license:RemoveLicense(identifier, type)
    end
end

function UpdateAllLicenses(identifier, incomingLicenses)
    for key, value in pairs(incomingLicenses) do
        if (not value) then
            exports.esx_license:RemoveLicense(identifier, key)
        end
    end
end