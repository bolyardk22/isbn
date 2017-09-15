require 'sinatra'
require_relative 'isbn.rb'
require 'aws-sdk'
load './local_env.rb' if File.exist?('./local_env.rb')

get '/' do
	erb :index
end

post '/results' do
	isbn_input = params[:isbn_input]
	isbn_func = params[:isbn_func]
	isbn_func = one_big_isbn_function(isbn_input)
	redirect '/true_or_false?isbn_input=' + isbn_input + '&isbn_func=' + isbn_func
end

get '/true_or_false' do
	isbn_input = params[:isbn_input]
	isbn_func = params[:isbn_func]
	result_statement = isbn_results(isbn_func)
	second_statement = isbn_results_pt_two(isbn_func)
	push_to_bucket(isbn_input, make_it_say_valid(isbn_func))
	erb :the_end, locals: {isbn_input: isbn_input, isbn_func: isbn_func, result_statement: result_statement, second_statement: second_statement}
end

post '/the_results_page' do
	isbn_input = params[:isbn_input]
	isbn_func = params[:isbn_func]
	result_statement = params[:result_statement]
end