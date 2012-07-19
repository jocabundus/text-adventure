declare sub ShowRoom()

type ItemType
	strId as string
	strName as string
	synonyms as string
	roomId as integer
	context as string
	description as string
	tag as string
	isVisible as integer
	messageHandler as function(item as ItemType ptr, action as string) as string
end type

type Vector
	x as integer
	y as integer
end type

dim shared North as Vector
dim shared South as Vector
dim shared West as Vector
dim shared East as Vector
North.x = 0: North.y = -1
South.x = 0: South.y =  1
West.x = -1: West.y = 0
East.x =  1: East.y = 0

dim shared MapH as integer
dim shared MapW as integer
MapW = 6: MapH = 6

'// all items in the game are put into this array
dim shared Items(100) as ItemType
dim shared NumberOfItems as integer
NumberOfItems = 0

dim shared CurrentRoomId as integer
CurrentRoomId = 0

dim shared Map(MapW, MapH) as integer

sub ReadItems()

	dim n as integer
	dim strId as string
	
	do
		read strId
		if strId = "stop" then exit do
		
		NumberOfItems += 1
		n = NumberOfItems-1
		
		Items(n).strId = strId
		read Items(n).roomId
		read Items(n).isVisible
		read Items(n).strName
		read Items(n).context
		read Items(n).description
		read Items(n).tag
		read Items(n).messageHandler
	loop
	
	dim x as integer
	dim y as integer
	dim row as string
	dim cell as string
	
	for y = 0 to MapH-1
		read row
		for x = 0 to MapW-1
			cell = mid(row, x+1, 1)
			if cell = "." then
				Map(x, y) = -1
			else
				Map(x, y) = val(cell)
			end if
		next
	next

end sub

function SendMessage(item as ItemType ptr, message as string) as string

	dim returnMessage as string
	returnMessage = ""

	select case message
	case "show "+lcase(item->strName)
		returnMessage = item->description
	case "see "+lcase(item->strName)
		returnMessage = item->description
	case "look at "+lcase(item->strName)
		returnMessage = item->description
	case "explore", "explore area"
		if item->tag = "scenery" then returnMessage = item->description
	case "reveal"
		returnMessage = item->context
	case else
		returnMessage = item->messageHandler(item, message)
	end select
	
	return returnMessage

end function

function MessageRoomId(message as string, roomId as integer) as integer

	dim response as string
	dim i as integer
	
	dim copyItems(100) as ItemType
	for i = 0 to NumberOfItems-1: copyItems(i) = Items(i): next i

	response = ""
	for i = 0 to NumberOfItems-1
		if copyItems(i).roomId = roomId and copyItems(i).isVisible = 1 then
			if notEmpty(response) then response += " "
			response += strReplace(Items(i).strName, "["+Items(i).strName+"]", SendMessage(@Items(i), message))
		end if
	next i
	
	if notEmpty(response) then
		print
		printColors(response)
		print
		return true
	else
		return false
	end if

end function

function Move(v as Vector) as integer

	dim x as integer, y as integer
	dim roomX as integer, roomY as integer
	
	for y = 0 to MapH-1
		for x = 0 to MapW-1
			if Map(x, y) = CurrentRoomId then
				roomX = x: roomY = y
			end if
		next x
	next y
	
	dim toX as integer, toY as integer
	toX = roomX+v.x: toY = roomY+v.y
	
	if toX >= 0 and toX < MapW and toY >= 0 and toY < MapH then
		if Map(toX, toY) >= 0 then
			CurrentRoomId = Map(toX, toY)
			return true
		end if
	end if
	
	print
	print "You cannot go that way."
	print
	return false

end function

sub ShowExits()

	dim x as integer, y as integer
	dim roomX as integer, roomY as integer
	
	for y = 0 to MapH-1
		for x = 0 to MapW-1
			if Map(x, y) = CurrentRoomId then
				roomX = x: roomY = y
			end if
		next x
	next y
	
	dim row as integer, col as integer
	dim exits as string = ""
	for y = -1 to 1
		for x = -1 to 1
			if x = 0 and y = 0 then continue for
			if x = 0 or y = 0 then
				row = roomY+y
				col = roomX+x
				if col >= 0 and col < MapW and row >= 0 and row < MapH then
					if Map(col, row) >= 0 then
						if notEmpty(exits) then exits += ", "
						if y < 0 then exits += "[north]"
						if y > 0 then exits += "[south]"
						if x < 0 then exits += "[west]"
						if x > 0 then exits += "[east]"
					end if
				end if
			end if
		next x
	next y
	
	if notEmpty(exits) then
		printColors("exits are: "+exits)
		print
	else
		print "no visible exits"
		print
	end if
	
	print

end sub

sub ShowInventory()

	dim itemNames as string
	
	itemNames = ""

	dim i as integer
	for i = 0 to NumberOfItems-1
		if Items(i).roomId = -1 and Items(i).isVisible = 1 then
			if notEmpty(itemNames) then
				itemNames += ", "
			end if
			itemNames += "["+Items(i).strName+"]"
		end if
	next i
	
	if notEmpty(itemNames) then
		print
		printColors(itemNames)
		print
		print
	else
		print
		print "Your inventory is empty."
		print
	end if

end sub

function MessageRoom(message as string) as integer

	if MessageRoomId(message, CurrentRoomId) then
		return true
	else
		if inpipe(message, "i|inventory|show inventory|see inventory") then
			ShowInventory()
			return true
		elseif inpipe(message, "north|go north") then
			if Move(North) then ShowRoom()
			return true
		elseif inpipe(message, "south|go south") then
			if Move(South) then ShowRoom()
			return true
		elseif inpipe(message, "west|go west") then
			if Move(West) then ShowRoom()
			return true
		elseif inpipe(message, "east|go east") then
			if Move(East) then ShowRoom()
			return true
		end if
	end if
	
	return false
	
end function

function MessageInventory(message as string) as integer
	return MessageRoomId(message, -1)
end function

function FindItem(strId as string) as ItemType ptr

	dim i as integer
	for i = -1 to NumberOfItems-1
		if Items(i).strId = strId then
			return @Items(i)
		end if
	next i
	
	return false

end function

function FindRoomItem(strId as string) as ItemType ptr

	dim i as integer
	for i = 0 to NumberOfItems-1
		if Items(i).roomId = CurrentRoomId and Items(i).strId = strId then
			return @Items(i)
		end if
	next i
	
	return false

end function

function InRoom(strId as string) as integer

	if FindRoomItem(strId) then
		return true
	else
		return false
	end if

end function

function GetRoomTitle() as string

	dim i as integer
	for i = 0 to NumberOfItems-1
		if Items(i).roomId = CurrentRoomId and Items(i).tag = "scenery" then
			return Items(i).strName
		end if
	next i

end function

sub ShowRoom()

	cls
	print GetRoomTitle
	print "--------------------------------------------------------------------------------";
	MessageRoom("reveal")
	
	ShowExits()

end sub

sub StoreItem(item as ItemType ptr)

	item->roomId = -1

end sub

sub DropItem(item as ItemType ptr)

	item->roomId = CurrentRoomId

end sub

function InInventory(strId as string) as integer

	dim item as ItemType ptr
	
	item = FindItem(strId)
	if item then
		if item->roomId = -1 then
			return true
		else
			return false
		end if
	else
		return false
	end if

end function

function AddToInventory(strId as string) as integer

	dim item as ItemType ptr
	
	if InInventory(strId) = 0 then
		item = FindItem(strId)
		if item then
			StoreItem(item)
			return true
		end if
	end if
	
	return false

end function

function RemoveFromInventory(strId as string) as integer

	dim item as ItemType ptr

	if InInventory(strId) then
		item = FindItem(strId)
		if item then
			DropItem(item)
			return true
		end if
	end if
	
	return false

end function

function ShowItem(strId as string) as integer

	dim item as ItemType ptr
	
	item = FindItem(strId)
	if item > 0 then
		item->isVisible = 1
		return true
	end if
	
	return false

end function

function HideItem(strId as string) as integer

	dim item as ItemType ptr
	
	item = FindItem(strId)
	if item > 0 then
		item->isVisible = 0
		return true
	end if
	
	return false

end function
