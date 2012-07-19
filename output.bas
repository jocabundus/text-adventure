const FG_TEXT = &hdddddd
const BG_TEXT = &h335588
const FG_KEYWORD = &hffdd55
const BG_KEYWORD = &h335588

sub PrintColors(text as string)

	dim word as string
	dim char as string
	dim i as integer
	dim w as integer
	dim cstop as integer
	dim caps as integer
	
	w = 79
	caps = 0
	
	cstop = 0
	for i = 1 to len(text)
	
		if cstop = 0 then
			if len(text) > i+w then
				if mid(text, i+w, 1) = " " then
					cstop = i+w
				else
					cstop = lastIndexOf(" ", text, i+w-1)
				end if
			else
				cstop = len(text)
			end if
		end if
	
		char = mid(text, i, 1)
		if char = "[" then
			caps = 1
			continue for
		end if
		if char = "]" then
			caps = 0
			continue for
		end if
		
		if caps then
			print ucase(char);
		else
			print char;
		end if
		
		if i >= cstop then
			print
			cstop = 0
		end if
	
	next i

end sub
