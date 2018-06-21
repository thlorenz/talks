-- HOWTO:
-- after saving it, open with Script Editor (default) and run it

-- PREREQUISITES:
-- make sure your Keynote presentation is open in the background 

-- AFTER EXPORT:
-- if you can't open the file due to encoding errors, open with Sublime (or another a text editor) and then "File / Save with encoding / UTF8"

tell application "Keynote"
	activate
	-- open (choose file)
	tell front document
		-- Get the name of the presentation.
		set thePresentationName to name
		
		-- Retrieve the titles of all slides.
		set theTitles to object text of default title item of every slide
		
		-- Retrieve the presenter notes for all slides.
		set theNotes to presenter notes of every slide
	end tell
end tell
set presenterNotes to ""
repeat with a from 1 to length of theTitles
	-- skip slides with empty notes
	if not (item a of theNotes) = "" then
		set presenterNotes to presenterNotes & "#### Slide " & a & ": " & item a of theTitles & return & return
		set presenterNotes to presenterNotes & "##### Presenter Notes: " & return & item a of theNotes & return & return
	end if
end repeat

set the clipboard to presenterNotes
do shell script "pbpaste > ~/Desktop/keynote-notes-" & thePresentationName & ".md"

-- based on http://apple.stackexchange.com/questions/136118/how-to-print-full-presenter-notes-without-slides-in-keynote