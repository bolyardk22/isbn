require 'csv'
require 'aws-sdk'
require 'rubygems'
load './local_env.rb' if File.exist?('./local_env.rb')
Aws.use_bundled_cert!

def connect_to_s3()
	Aws::S3::Client.new(
	access_key_id: ENV['AWS_ACCESS_KEY_ID'],
	secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
	region: ENV['AWS_REGION'],
	)

	file = "output_isbn_file.csv"
	bucket = 'isbnbucket'
	s3 = Aws::S3::Resource.new(region: 'us-east-2')
	obj = s3.bucket(bucket).object(file)

	# string data
	obj.put(body: '"some code here to show something being added to the bucket."+ "\n"')
	# push entire file 
	File.open('output_isbn_file.csv', 'rb') do |file|
		obj.put(body: file)
	end
end

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

def numbers_only(number)
	if number !~ /\D/    
		true
	elsif number.chop !~ /\D/
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

def one_big_isbn_function(inputISBN)

	inputISBN = inputISBN.delete(' ')
	inputISBN = inputISBN.delete('-')
	inputISBN = inputISBN.delete('%')

	math_array = []

	if inputISBN !~ /\D/    

		if inputISBN.length == 10

			arrayISBN = inputISBN.split('')

			last_positionISBN = arrayISBN.pop

			arrayISBN.each.with_index do |var, index|

				mult = var.to_f * (index.to_f + 1)

				math_array << mult
			end

			math_array_sum = math_array.inject(0, :+)

			math_array_mod = math_array_sum % 11

			if math_array_mod == last_positionISBN
				returnvar = "true"

			else
				returnvar = "false"
			end

		elsif inputISBN.length == 13

			arrayISBN = inputISBN.split('')

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
				returnvar = "true"

			else
				returnvar = "false"
			end

		else
			returnvar = "false"
		end

	elsif inputISBN.chop !~ /\D/

			if inputISBN.length == 10

				arrayISBN = inputISBN.split('')

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
				math_array_mod = "x"

			else
				returnvar = "false"
			end

			if math_array_mod == last_positionISBN.downcase
				returnvar = "true"

			else
				returnvar = "false"
			end

		elsif inputISBN.length == 13

			arrayISBN = inputISBN.split('')

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
				returnvar = "true"

			else
				returnvar = "false"
			end

		else
			returnvar = "false"
		end

	else
		returnvar = "false"
	end

	returnvar
end

def isbn_results(bigfunctionresults)
	if bigfunctionresults == "true"
		the_answer = 'Congratulations, '

	else
		the_answer = 'Sorry, '
	end

	the_answer
end

def isbn_results_pt_two(bigfuncresults)
	if bigfuncresults == "true"
		answered = ' is a valid ISBN number!'

	else
		answered = ' is not a valid ISBN number.'
	end
	answered
end

def check_through_csv_file()

 	write_file = File.open("output_isbn_file.csv", "w")
	sample_array = CSV.read('input_isbn_file.csv')
	
	header = sample_array.shift

	sample_array.each do |value|
		
		something = []

		if one_big_isbn_function(value[1]) == "true"
			value.push("valid\n")
			something.push("#{value[0]},#{value[1]},#{value[2]}")

		else
			value.push("invalid\n")
			something.push("#{value[0]},#{value[1]},#{value[2]}")

		end

		write_file.puts something

	end
end

def make_it_say_valid(trueorfalse)
	if trueorfalse == "true"
		ends_up = "valid"
	else
		ends_up = "invalid"
	end
end

def push_to_bucket(user_given_isbn, result_message)
    Aws::S3::Client.new(
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_REGION']
    )
    file = 'output_isbn_file.csv'

    write_file = File.open(file, "a")
    write_file << user_given_isbn + ", " + result_message + "\n"
    write_file.close
   
    bucket = 'isbnbucket'

    s3 = Aws::S3::Resource.new(region: 'us-east-2')

    obj = s3.bucket(bucket).object(file)
    
    File.open(file, 'rb') do |file|
        obj.put(body: file)
    end
end

def get_file()
    Aws::S3::Client.new(
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        region: ENV['AWS_REGION']
        )
    s3 = Aws::S3::Client.new
    csv_file_from_bucket = s3.get_object(bucket: 'isbnbucket', key: 'output_isbn_file.csv')
    csv_file_read = csv_file_from_bucket.body.read

    split_csv = csv_file_read.split
    list = []
    split_csv.each do |item|
        item.gsub(/"/, '')
        list << item
    end
    list
end

p get_file

# check_through_csv_file
# connect_to_s3