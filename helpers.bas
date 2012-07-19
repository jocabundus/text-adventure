const true = 1
const false = 0

function indexOf(needle as string, haystack as string) as integer

	return instr(haystack, needle)

end function

function lastIndexOf(needle as string, haystack as string, postart as integer) as integer

	dim substr as string
	dim n as integer
	
	if postart = 0 then postart = len(haystack)
	
	for n = postart to 1 step -1
		substr = mid(haystack, n, postart-n+1)
		if instr(substr, needle) then
			return n
		end if
	next n

end function

function inPipe(needle as string, haystack as string) as integer

	dim postart as integer
	dim postop as integer
	dim substr as string
	postart = 1
	
	do
		postop = instr(postart, haystack, "|")
		
		if postop = 0 then
			if postart = 1 then
				if needle = haystack then
					return true
				else
					return false
				end if
			else
				postop = len(haystack)+1
			end if
		end if
		
		substr = mid(haystack, postart, postop-postart)
		
		if needle = substr then return 1
		
		postart = postop+1
		if postart > len(haystack) then exit do
	loop
	
	return false

end function

function strReplace(replace as string, replacement as string, subject as string) as string

	dim newString as string
	dim strLeft as string
	dim strRight as string
	dim i as integer
	
	newString = subject
	
	i = 1
	do
		i = instr(i, newString, replace)
		if i then
			strLeft = left(newString, i-1)
			strRight = right(newString, len(newString)-i-len(replace)+1)
			newString = strLeft+replacement+strRight
			i = len(strLeft)+len(replacement)+1
		else
			exit do
		end if
	loop
	
	return newString

end function

function substi(text as string, substitute as string) as string

	return strReplace("%s", substitute, text)

end function

function empty(text as string) as integer

	if len(text) = 0 then return true
	if len(trim(text)) = 0 then return true
	
	return false

end function

function notEmpty(text as string) as integer

	if empty(text) then return false else return true
	
end function
