let WaveShield = exports.WaveShield
let isServerSide = IsDuplicityVersion()

if (!isServerSide) {

	const setEntityCoords = SetEntityCoords
	let lastTeleported = 0
	SetEntityCoords = function(entity, ...args) {
		if ((GetGameTimer() - lastTeleported) > 1000) {
			if (entity === PlayerPedId()) {
				WaveShield.hasTeleported();
			}
			lastTeleported = GetGameTimer();
		}
		return setEntityCoords(entity, ...args);
	};

	const setEntityCoordsNoOffset = SetEntityCoordsNoOffset;
	SetEntityCoordsNoOffset = function(entity, ...args) {
		if ((GetGameTimer() - lastTeleported) > 1000) {
			if (entity === PlayerPedId()) {
				WaveShield.hasTeleported();
			}
			lastTeleported = GetGameTimer();
		}
		return setEntityCoordsNoOffset(entity, ...args);
	};

	const startPlayerTeleport = StartPlayerTeleport;
	StartPlayerTeleport = function(player, ...args) {
		if (player === PlayerId()) {
			WaveShield.hasTeleported();
		}
		return startPlayerTeleport(player, ...args);
	};

	const setPedCoordsKeepVehicle = SetPedCoordsKeepVehicle;
	SetPedCoordsKeepVehicle = function(ped, ...args) {
		if ((GetGameTimer() - lastTeleported) > 1000) {
			if (ped === PlayerPedId()) {
				WaveShield.hasTeleported();
			}
			lastTeleported = GetGameTimer();
		}
		return setPedCoordsKeepVehicle(ped, ...args);
	};

	const setPedIntoVehicle = SetPedIntoVehicle;
	SetPedIntoVehicle = function(ped, ...args) {
		if ((GetGameTimer() - lastTeleported) > 1000) {
			if (ped === PlayerPedId()) {
				WaveShield.hasTeleported();
			}
			lastTeleported = GetGameTimer();
		}
		return setPedIntoVehicle(ped, ...args);
	};

	const taskWarpPedIntoVehicle = TaskWarpPedIntoVehicle;
	TaskWarpPedIntoVehicle = function(ped, ...args) {
		if ((GetGameTimer() - lastTeleported) > 1000) {
			if (ped === PlayerPedId()) {
				WaveShield.hasTeleported();
			}
			lastTeleported = GetGameTimer();
		}
		return taskWarpPedIntoVehicle(ped, ...args);
	};

	const setPlayerModel = SetPlayerModel;
	SetPlayerModel = function(player, model, ...args) {
		if (player === PlayerId()) {
			WaveShield.hasChangedPedModel();
		}
		return setPlayerModel(player, model, ...args);
	}

	const setEntityHealth = SetEntityHealth;
	let lastSettedHealth = 0;
	let lastSettedHealthValue;
	SetEntityHealth = function(entity, health, ...args) {
		if (health !== lastSettedHealthValue || (GetGameTimer() - lastSettedHealth) > 1000) {
			if (entity === PlayerPedId() && health > 0) {
				WaveShield.healthRefilled();
				lastSettedHealth = GetGameTimer();
				lastSettedHealthValue = health;
			}
		}
		return setEntityHealth(entity, health, ...args);
	}

	const resurrectPed = ResurrectPed;
	ResurrectPed = function(ped, ...args) {
		if (ped === PlayerPedId()) {
			WaveShield.playerRevived();
		}
		return resurrectPed(ped, ...args);
	}

	const networkResurrectLocalPlayer = NetworkResurrectLocalPlayer;
	NetworkResurrectLocalPlayer = function(x, y, z, heading, unk, changetime, ...args) {
		WaveShield.playerRevived();
		return networkResurrectLocalPlayer(x, y, z, heading, unk, changetime, ...args)
	}

	const reviveInjuredPed = ReviveInjuredPed;
	ReviveInjuredPed = function(ped, ...args) {
		if (ped === PlayerPedId()) {
			WaveShield.playerRevived();
		}
		return reviveInjuredPed(ped, ...args)
	}

	const setEntityProofs = SetEntityProofs;
	SetEntityProofs = function(entity, bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, drownProof, ...args) {
		if (entity == PlayerPedId()) {
			WaveShield.proofsEnabled(bulletProof == true || bulletProof == 1 || meleeProof == true || meleeProof == 1);
		}
		return setEntityProofs(entity, bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, drownProof, ...args);
	}

	const setEntityCanBeDamaged = SetEntityCanBeDamaged;
	let lastSettedCanBeDamaged = 0;
	let lastSettedCanBeDamagedValue;
	SetEntityCanBeDamaged = function(entity, toggle, ...args) {
		if ((GetGameTimer() - lastSettedCanBeDamaged) > 1000 || toggle !== lastSettedCanBeDamagedValue) {
			if (entity == PlayerPedId()) {
				WaveShield.canBeDamaged(toggle);
				lastSettedCanBeDamaged = GetGameTimer();
				lastSettedCanBeDamagedValue = toggle;
			}
		}
		return setEntityCanBeDamaged(entity, toggle, ...args);
	}

	const setPlayerInvincible = SetPlayerInvincible;
	let lastSettedPlayerInvincible = 0;
	let lastPlayerInvincibleToggle;
	SetPlayerInvincible = function(player, toggle, ...args) {
		if (toggle !== lastPlayerInvincibleToggle || (GetGameTimer() - lastSettedPlayerInvincible) > 1000) {
			if (player == PlayerId()) {
				WaveShield.isInvincible(toggle);
				lastSettedPlayerInvincible = GetGameTimer();
				lastPlayerInvincibleToggle = toggle;
			}
		}
		return setPlayerInvincible(player, toggle, ...args);
	}

	const setEntityInvincible = SetEntityInvincible;
	let lastSettedInvincible = 0;
	let lastInvincibleToggle;
	SetEntityInvincible = function(entity, toggle, ...args) {
		if (toggle !== lastInvincibleToggle || (GetGameTimer() - lastSettedInvincible) > 1000) {
			if (entity == PlayerPedId()) {
				WaveShield.isInvincible(toggle);
				lastSettedInvincible = GetGameTimer();
				lastInvincibleToggle = toggle;
			}
		}
		return setEntityInvincible(entity, toggle, ...args);
	}

	const setEntityVisible = SetEntityVisible;
	let lastSettedVisible = 0;
	let lastSettedVisibleToggle;
	SetEntityVisible = function(entity, toggle, unk, ...args) {
		if (toggle !== lastSettedVisibleToggle || (GetGameTimer() - lastSettedVisible) > 1000) {
			if (entity == PlayerPedId()) {
				WaveShield.isVisible(toggle);
				lastSettedVisible = GetGameTimer();
				lastSettedVisibleToggle = toggle;
			}
		}
		return setEntityVisible(entity, toggle, unk, ...args);
	}

	const restorePlayerStamina = RestorePlayerStamina;
	RestorePlayerStamina = function(player, p1, ...args) {
		if (player === PlayerId()) {
			WaveShield.resettedStamina();
		}
		return restorePlayerStamina(player, p1, ...args);
	}

	const resetPlayerStamina = ResetPlayerStamina;
	ResetPlayerStamina = function(player, ...args) {
		if (player === PlayerId()) {
			WaveShield.resettedStamina();
		}
		return resetPlayerStamina(player, ...args);
	}

	const statSetInt = StatSetInt;
	StatSetInt = function(statName, value, save, ...args) {
		if (statName !== null && ((typeof statName === "string" && statName.toLowerCase() === "mp0_stamina") || statName === GetHashKey("MP0_STAMINA"))) {
			WaveShield.haveMaxStaminaStats(value >= 100);
		}
		return statSetInt(statName, value, save, ...args);
	}

	const modifyVehicleTopSpeed = ModifyVehicleTopSpeed;
	ModifyVehicleTopSpeed = function(vehicle, value, ...args) {
		const playerPedId = PlayerPedId();
		const vehiclePedIsIn = GetVehiclePedIsIn(playerPedId, false);
		if ((vehicle === vehiclePedIsIn) && (GetPedInVehicleSeat(vehiclePedIsIn, -1) === playerPedId)) {
			WaveShield.newTopSpeedModifier(value);
		}
		return modifyVehicleTopSpeed(vehicle, value, ...args);
	}
	SetVehicleEnginePowerMultiplier = ModifyVehicleTopSpeed;

	const setVehicleCheatPowerIncrease = SetVehicleCheatPowerIncrease;
	SetVehicleCheatPowerIncrease = function(vehicle, value, ...args) {
		const playerPedId = PlayerPedId();
		const vehiclePedIsIn = GetVehiclePedIsIn(playerPedId, false);
		if ((vehicle === vehiclePedIsIn) && (GetPedInVehicleSeat(vehiclePedIsIn, -1) === playerPedId)) {
			WaveShield.newCheatPowerIncrease(value);
		}
		return setVehicleCheatPowerIncrease(vehicle, value, ...args);
	}
	SetVehicleEngineTorqueMultiplier = SetVehicleCheatPowerIncrease

	const setVehicleGravityAmount = SetVehicleGravityAmount;
	SetVehicleGravityAmount = function(vehicle, gravity, ...args) {
		const playerPedId = PlayerPedId();
		const vehiclePedIsIn = GetVehiclePedIsIn(playerPedId, false);
		if ((vehicle === vehiclePedIsIn) && (GetPedInVehicleSeat(vehiclePedIsIn, -1) === playerPedId)) {
			WaveShield.newGravity(gravity);
		}
		return setVehicleGravityAmount(vehicle, gravity, ...args);
	}

	const setWeaponDamageModifier = SetWeaponDamageModifier;
	let weaponsModified = {};
	SetWeaponDamageModifier = function(weaponHash, damageMultiplier, ...args){
		if (!weaponsModified[weaponHash] || weaponsModified[weaponHash] !== damageMultiplier){
			WaveShield.setNewDamage(weaponHash, damageMultiplier);
		}
		weaponsModified[weaponHash] = damageMultiplier;
		return setWeaponDamageModifier(weaponHash, damageMultiplier, ...args);
	}
	SetWeaponDamageModifierThisFrame = SetWeaponDamageModifier;
	N_0x4757f00bc6323cfe = SetWeaponDamageModifier;

	const addAmmoToPed = AddAmmoToPed;
	AddAmmoToPed = function(ped, weaponHash, ammo, ...args){
		if (ped === PlayerPedId()) {
			WaveShield.hasAddedAmmo()
		}
		return addAmmoToPed(ped, weaponHash, ammo, ...args)
	}

	const addAmmoToPedByType = AddAmmoToPedByType;
	AddAmmoToPedByType = function(ped, ammoType, ammo, ...args){
		if (ped === PlayerPedId()) {
			WaveShield.hasAddedAmmo()
		}
		return addAmmoToPedByType(ped, ammoType, ammo, ...args)
	}
	AddPedAmmo = AddAmmoToPedByType

	const refillAmmoInstantly = RefillAmmoInstantly;
	RefillAmmoInstantly = function(ped, ...args){
		if (ped === PlayerPedId()) {
			WaveShield.hasAddedAmmo()
		}
		return refillAmmoInstantly(ped, ...args)
	}
	PedSkipNextReloading = RefillAmmoInstantly;

	const setAmmoInClip = SetAmmoInClip;
	SetAmmoInClip = function(ped, weaponHash, ammo, ...args){
		if (ped === PlayerPedId()) {
			WaveShield.hasAddedAmmo()
		}
		return setAmmoInClip(ped, weaponHash, ammo, ...args)
	}

	const setPedAmmo = SetPedAmmo;
	SetPedAmmo = function(ped, weaponHash, ammo, ...args){
		if (ped === PlayerPedId()) {
			WaveShield.hasAddedAmmo()
		}
		return setPedAmmo(ped, weaponHash, ammo,...args)
	}

	const setPedAmmoByType = SetPedAmmoByType;
	SetPedAmmoByType = function(ped, ammoType, ammo, ...args){
		if (ped === PlayerPedId()) {
			WaveShield.hasAddedAmmo()
		}
		return setPedAmmoByType(ped, ammoType, ammo, ...args)
	}

	const setMouseCursorActiveThisFrame = SetMouseCursorActiveThisFrame;
	let lastCalledMouse = 0;
	SetMouseCursorActiveThisFrame = function(...args){
		if ((GetGameTimer() - lastCalledMouse) > 1000){
			WaveShield.disableE2();
			lastCalledMouse = GetGameTimer();
		}
		return setMouseCursorActiveThisFrame(...args);
	}
	ShowCursorThisFrame = SetMouseCursorActiveThisFrame;

	const disableAllControlActions = DisableAllControlActions;
	let lastCalledDisableControls = 0;
	DisableAllControlActions = function(padIndex, ...args){
		if ((GetGameTimer() - lastCalledDisableControls) > 1000){
			WaveShield.disableAllControls();
			lastCalledDisableControls = GetGameTimer();
		}
		return disableAllControlActions(padIndex, ...args);
	}

	const disableControlAction = DisableControlAction;
	let lastCalledDisableCamControls = 0;
	DisableControlAction = function(padIndex, control, disable, ...args){
		if (disable && (control === 1 || control === 2) && ((GetGameTimer() - lastCalledDisableCamControls) > 1000)){
			WaveShield.disableCamControls();
			lastCalledDisableCamControls = GetGameTimer();
		}
		return disableControlAction(padIndex, control, disable, ...args);
	}

	const requestStreamedTextureDict = RequestStreamedTextureDict;
	let allowedTextures = {};
	RequestStreamedTextureDict = function(textureDict, p1, ...args){
		if (!allowedTextures[textureDict]){
			allowedTextures[textureDict] = true;
			WaveShield.allowTexture(textureDict);
		}
		return requestStreamedTextureDict(textureDict, p1, ...args);
	}

	const drawSprite = DrawSprite;
	DrawSprite = function(textureDict, ...args){
		if (!allowedTextures[textureDict]){
			allowedTextures[textureDict] = true;
			WaveShield.allowTexture(textureDict);
		}
		return drawSprite(textureDict, ...args);
	}

	const createRuntimeTxd = CreateRuntimeTxd;
	CreateRuntimeTxd = function(textureDict, ...args){
		if (!allowedTextures[textureDict]){
			allowedTextures[textureDict] = true;
			WaveShield.allowTexture(textureDict);
		}
		return createRuntimeTxd(textureDict, ...args);
	}

	const requestScaleformMovie = RequestScaleformMovie
	RequestScaleformMovie = function(scaleformName, ...args) {
		if (typeof scaleformName === "string" && scaleformName.toLowerCase() !== null) {
			scaleformName = scaleformName.toLowerCase();
			if (scaleformName === "scaleformui") {
				allowedTextures["mpleaderboard"] = true;
				allowedTextures["mpinventory"] = true;
				allowedTextures["commonmenutu"] = true;
				allowedTextures["mphud"] = true;
				allowedTextures["mpshopsale"] = true;
				allowedTextures["mprankbadge"] = true;
				allowedTextures["mpcarhud"] = true;
				allowedTextures["mpcarhud2"] = true;
				allowedTextures["shared"] = true;
				allowedTextures["commonmenu"] = true;
				WaveShield.allowTexture("mpleaderboard");
				WaveShield.allowTexture("mpinventory");
				WaveShield.allowTexture("commonmenutu");
				WaveShield.allowTexture("mphud");
				WaveShield.allowTexture("mpshopsale");
				WaveShield.allowTexture("mprankbadge");
				WaveShield.allowTexture("mpcarhud");
				WaveShield.allowTexture("mpcarhud2");
				WaveShield.allowTexture("shared");
				WaveShield.allowTexture("commonmenu");
			} else if (scaleformName.indexOf("mp_car_stats") !== -1) {
				allowedTextures["mpcarhud"] = true;
				allowedTextures["mpcarhud2"] = true;
				WaveShield.allowTexture("mpcarhud");
				WaveShield.allowTexture("mpcarhud2");
			}
		}
		return requestScaleformMovie(scaleformName, ...args);
	}
	RequestScaleformMovie_2 = RequestScaleformMovie;

	const giveWeaponToPed = GiveWeaponToPed
	GiveWeaponToPed = function(ped, weaponHash, ...args) {
		if (ped === PlayerPedId()) {
			WaveShield.giveWeapon(weaponHash);
		}
		return giveWeaponToPed(ped, weaponHash, ...args);
	}

	const createWeaponObject = CreateWeaponObject;
	CreateWeaponObject = function(weaponHash, ammoCount, x, y, z, showWorldModel, scale, p7, ...args) {
		if (showWorldModel) {
			WaveShield.giveWeapon(weaponHash);
		}
		return createWeaponObject(weaponHash, ammoCount, x, y, z, showWorldModel, scale, p7, ...args);
	}

	const removeAllPedWeapons = RemoveAllPedWeapons;
	RemoveAllPedWeapons = function(ped, p1, ...args) {
		if (ped === PlayerPedId()) {
			WaveShield.removeAllWeapons();
		}
		return removeAllPedWeapons(ped, p1, ...args);
	}

	const removeWeaponFromPed = RemoveWeaponFromPed;
	RemoveWeaponFromPed = function(ped, weaponHash, ...args) {
		if (ped === PlayerPedId()) {
			WaveShield.removeWeapon(weaponHash);
		}
		return removeWeaponFromPed(ped, weaponHash, ...args);
	}

	const createObject = CreateObject;
	CreateObject = function(modelHash, x, y, z, isNetwork, ...args){
		let networked = isNetwork;
		if(typeof x == "vector3"){
			networked = z;
		}
		if(networked && (networked == true || networked == 1)){
			WaveShield.CreateObject(modelHash);
		}
		return createObject(modelHash, x, y, z, isNetwork, ...args);
	};

	const createObjectNoOffset = CreateObjectNoOffset;
	CreateObjectNoOffset = function(modelHash, x, y, z, isNetwork, ...args){
		let networked = isNetwork;
		if(typeof x == "vector3"){
			networked = z;
		}
		if(networked && (networked == true || networked == 1)){
			WaveShield.CreateObject(modelHash);
		}
		return createObjectNoOffset(modelHash, x, y, z, isNetwork, ...args);
	};

	//const getClosestObjectOfType = GetClosestObjectOfType;
	//GetClosestObjectOfType = function(x, y, z, radius, modelHash, ...args){
	//	if(typeof x == "vector3"){
	//		WaveShield.CreateObject(z);
	//	} else {
	//		WaveShield.CreateObject(modelHash);
	//	}
	//	return getClosestObjectOfType(x, y, z, radius, modelHash, ...args);
	//};

	const createVehicle = CreateVehicle;
	CreateVehicle = function(modelHash, x, y, z, heading, isNetwork, ...args){
		let networked = isNetwork;
		if(typeof x == "vector3"){
			networked = z;
		}
		if(networked && (networked == true || networked == 1)){
			WaveShield.CreateVehicle(modelHash);
		}
		return createVehicle(modelHash, x, y, z, heading, isNetwork, ...args);
	};

	const createPed = CreatePed;
	CreatePed = function(pedType, modelHash, x, y, z, heading, isNetwork, ...args){
		let networked = isNetwork;
		if(typeof x == "vector3"){
			networked = z;
		}
		if(networked && (networked == true || networked == 1)){
			WaveShield.CreatePed(modelHash);
		}
		return createPed(pedType, modelHash, x, y, z, heading, isNetwork, ...args);
	};

	const createPedInsideVehicle = CreatePedInsideVehicle;
	CreatePedInsideVehicle = function(vehicle, pedType, modelHash, seat, isNetwork, ...args){
		if(isNetwork && (isNetwork == true || isNetwork == 1)){
			WaveShield.CreatePed(modelHash);
		}
		return createPedInsideVehicle(vehicle, pedType, modelHash, seat, isNetwork, ...args);
	};

	const setVehicleNumberPlateText = SetVehicleNumberPlateText;
	SetVehicleNumberPlateText = function(vehicle, plateText, ...args){
		WaveShield.ChangeVehiclePlate(vehicle, plateText)
		return setVehicleNumberPlateText(vehicle, plateText, ...args);
	};

}