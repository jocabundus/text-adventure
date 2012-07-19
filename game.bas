#include once "helpers.bas"
#include once "output.bas"
#include once "globals.bas"
#include once "handlers.bas"
#include once "data.bas"

print "NAME OF GAME HERE"
print

ReadItems()
ShowRoom()

dim whatToDo as string
do
	
	input "? ", whatToDo
	
	if whatToDo = "exit" then exit do
	if inpipe(whatToDo, "show|show room|see|see room|look|where am I|where am I?") then
		ShowRoom()
		continue do
	end if
	
	if MessageRoom(whatToDo) = 0 and MessageInventory(whatToDo) = 0 then
		print
		print "Nothing happened. Try again"
		print
	end if
	
loop

print "Goodbye!"

do: loop while inkey <> ""

end
