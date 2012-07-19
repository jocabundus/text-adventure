function dummyHandler(item as ItemType ptr, message as string) as string

	return ""

end function

function breadHandler(item as ItemType ptr, message as string) as string

	select case message
		case "get bread"
			if InInventory(item->strId) = 0 then
				StoreItem(item)
				return substi("Added %s to inventory.", item->strName)
			end if
		case "eat bread"
			if InInventory(item->strId) then
				HideItem(item->strId)
				return substi("You eat the %s. It is yummy.", item->strName)
			else
				return substi("You need to get it first. Try 'get %s'.", item->strName)
			end if
		case "drop bread"
			if InInventory(item->strId) then
				DropItem(item)
				return substi("Removed %s from inventory.", item->strName)
			end if
	end select
	
	return ""

end function

function hookHandler(item as ItemType ptr, message as string) as string

	select case message
		case "get hook", "get grapling hook"
			if InInventory(item->strId) = 0 then
				StoreItem(item)
				return substi("Added %s to inventory.", item->strName)
			end if
		case "use hook", "use grapling hook", "throw hook", "throw grapling hook"
			if InRoom("cliff") then
				HideItem("cliff")
				ShowItem("cliff-climbable")
				HideItem(item->strId)
				return substi("You hurl the %s to the top of the cliff. You pull and it snags! The rope hangs to the ground.", item->strName)
			end if
			return substi("There is no use for the %s here.", item->strName)
	end select

end function

function crossbowHandler(item as ItemType ptr, message as string) as string

	select case message
		case "get crossbow"
			if InInventory(item->strId) = 0 then
				StoreItem(item)
				return substi("Added %s to inventory.", item->strName)
			end if
	end select

end function

function cliffHandler(item as ItemType ptr, message as string) as string

	select case message
		case "north", "go north"
			return substi("The %s is in the way.", item->strName)
		case "climb cliff"
			return substi("The %s is too dangerous to climb by hand.", item->strName)
	end select
	
	return ""

end function

function cliffClimbableHandler(item as ItemType ptr, message as string) as string

	select case message
		case "north", "go north"
			return substi("The %s is in the way.", item->strName)
		case "climb cliff", "climb rope", "scale cliff"
			HideItem("cliff-climbable")
			ShowItem("cliff-passable")
			HideItem("room.beach")
			return substi("Using the rope from the grapling hook, you scale the cliff. You are now at the top of the cliff.", item->strName)
	end select
	
	return ""

end function

function cliffPassableHandler(item as ItemType ptr, message as string) as string

	select case message
		case "south", "go south"
			return substi("There is no turning back!", item->strName)
	end select
	
	return ""

end function

function riverHandler(item as ItemType ptr, message as string) as string

	select case message
		case "cross river", "ford river", "swim river", "swim across river"
			return "You jump into the river. Splash! You are quickly sucked into its current. You struggle and try to reach the other side before it's too late. But the current is too strong and swift. You are thrown off the cliff and fall alongside the waterfall to your end at the rocks below."
	end select

end function

function emptyBucketHandler(item as ItemType ptr, message as string) as string

	select case message
		case "fill", "fill bucket"
			if InInventory(item->strId) and InRoom("river") then
				HideItem("bucket-empty")
				ShowItem("bucket-full")
				AddToInventory("bucket-full")
				return "You fill the bucket with water from the river."
			end if
		case "get bucket"
			if InInventory(item->strId) = 0 then
				StoreItem(item)
				return substi("Added %s to inventory.", item->strName)
			end if
		case "drop bucket"
			if InInventory(item->strId) then
				DropItem(item)
				return substi("Removed %s from inventory.", item->strName)
			end if
	end select

end function

function fullBucketHandler(item as ItemType ptr, message as string) as string

	select case message
		case "douse fire", "douse campfire", "put out fire", "put out campfire", "dump bucket on fire", "dump bucket on campfire", "empty bucket on fire", "empty bucket on campfire", "pour bucket on fire"
			if InInventory(item->strId) and InRoom("campfire") then
				HideItem("bucket-full")
				ShowItem("bucket-empty")
				AddToInventory("bucket-empty")
				HideItem("campfire")
				ShowItem("campfire-out")
				ShowItem("shiny object")
				return "You dump the water on the fire. Splash! The fire is swiftly put out and nothing is left but a simmer."
			end if
		case "dump bucket", "empty bucket", "pour bucket"
			if InInventory(item->strId) then
				HideItem("bucket-full")
				ShowItem("bucket-empty")
				return "You dump the water onto the ground. The bucket is now empty."
			end if
		case "get bucket"
			if InInventory(item->strId) = 0 then
				StoreItem(item)
				return substi("Added %s to inventory.", item->strName)
			end if
		case "drop bucket"
			if InInventory(item->strId) then
				DropItem(item)
				return substi("Removed %s from inventory.", item->strName)
			end if
	end select

end function

function shinyObjectHandler(item as ItemType ptr, message as string) as string

	select case message
		case "get shiny object"
			HideItem("shiny object")
			ShowItem("silver key")
			AddToInventory("silver key")
			return "You pick it up. It is a silver key! You add it to your inventory."
	end select

end function

function woodenDoorLockedHandler(item as ItemType ptr, message as string) as string

	select case message
		case "north", "go north"
			return "The door is in the way."
		case "open door"
			return "You try to open the door but it won't budge. It appears to be locked."
		case "unlock door", "use key", "use silver key"
			if InInventory("silver key") then
				HideItem("silver key")
				HideItem("wooden-door-locked")
				ShowItem("wooden-door-unlocked")
				return "You try to unlock the door with the silver key. You hear the lock turn. It works!"
			else
				return "You have nothing to unlock the door with."
			end if
	end select
	
	return ""

end function

function woodenDoorUnlockedHandler(item as ItemType ptr, message as string) as string

	select case message
		case "north", "go north"
			return "The door is in the way."
		case "open door"
			HideItem("wooden-door-unlocked")
			ShowItem("wooden-door-open")
			return "The wooden door swings open."
	end select
	
	return ""

end function

function woodenDoorOpenHandler(item as ItemType ptr, message as string) as string

	select case message
		case "open door"
			return "The door is already open."
		case "close door"
			HideItem("wooden-door-open")
			ShowItem("wooden-door-unlocked")
			return "You pull the wooden door closed."
	end select
	
	return ""

end function

function staircaseHandler(item as ItemType ptr, message as string) as string

	select case message
		case "go upstairs", "use staircase", "use stairs", "take stairs"
			HideItem("room.lighthouse")
			ShowItem("room.latern-room")
			HideItem("spiral-staircase")
			ShowItem("spiral-staircase-downward")
			ShowItem("man-in-cloak")
			return "You carefully walk up the creaky staircase."
	end select
	
	return ""

end function

function staircaseDownwardHandler(item as ItemType ptr, message as string) as string

	select case message
		case "south", "go south"
			return "You must go back downstairs first."
		case "go downstairs", "use staircase", "use stairs", "take stairs"
			HideItem("room.latern-room")
			ShowItem("room.lighthouse")
			HideItem("spiral-staircase-downward")
			ShowItem("spiral-staircase")
			HideItem("man-in-cloak")
			return "You carefully walk down the creaky staircase."
	end select
	
	return ""

end function
