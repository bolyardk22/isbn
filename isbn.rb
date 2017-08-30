def checkISBNlength (sampleISBN)

	sampleISBN = sampleISBN.delete(' ')

	sampleISBN = sampleISBN.delete('-')

	if sampleISBN.length == 10
		true
	elsif sampleISBN.length == 13
		true
	else
		false
	end
end


def cleanISBN (sampleISBN2)

	sampleISBN2 = sampleISBN2.delete(' ')

	sampleISBN2 = sampleISBN2.delete('-')

	result_sampleISBN2 = sampleISBN2
end


def check_if_last_num_passes(cleanedISBN)

		math_array = []

	if cleanedISBN.length == 10

		arrayISBN = cleanedISBN.split('')

		last_positionISBN = arrayISBN.pop

		arrayISBN.each.with_index do |var, index|
			mult = var.to_f * (index.to_f + 1)
			math_array << mult
		end

		math_array_sum = math_array.inject(0, :+)

		math_array_mod = math_array_sum % 11

		if math_array_mod <= 9
			math_array_mod
		elsif math_array_mod ==10
			math_array_mod = "X"
		else
			false
		end

		if math_array_mod == last_positionISBN
			true
		else
			false
		end

	elsif cleanedISBN.length == 13

		arrayISBN = cleanedISBN.split('')

		last_positionISBN = arrayISBN.pop

		arrayISBN.each.with_index do |var, index|

			if (index + 1) % 2 == 0
				mult = var.to_f * 3
				math_array << mult
			else
				mult = var.to_i
				math_array << mult
			end
		end

		math_array_sum = math_array.inject(0, :+)


		math_array_mod_one = 10 - (math_array_sum % 10)


		math_array_mod = math_array_mod_one % 10


		if math_array_mod == last_positionISBN.to_i
			true
		else
			false
		end
	end
end