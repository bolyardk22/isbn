def check_isbn (sampleISBN)
	if sampleISBN.length == 10
		true
	elsif sampleISBN.length == 13
		true
	else
		false
	end
end