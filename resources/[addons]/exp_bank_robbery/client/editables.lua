function ShowNotification(event)
	lib.notify({
		title = event.title,
		description = event.message,
		type = event.type or "success"
	})
end

function DoesPedHaveAnyBag(ped)
    return GetPedDrawableVariation(ped, 5) > 0
end