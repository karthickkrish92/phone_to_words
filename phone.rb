class PhoneNumber
  def initialize
    @letters = {"2" => ["a", "b", "c"],"3" => ["d", "e", "f"],"4" => ["g", "h", "i"],"5" => ["j", "k", "l"],"6" => ["m", "n", "o"],"7" => ["p", "q", "r", "s"],"8" => ["t", "u", "v"],"9" => ["w", "x", "y", "z"]}
    file = File.read("dictionary.txt")
    
      @dic_words = file.split("\n").map(&:downcase)
      puts "Please enter a 10 digit phone number not contain 0 / 1"
      phone_no = gets.chomp
      get_word_combinations(phone_no)
  end 

  def check_valid_phone_no(phone_no)
    unless (phone_no.length == 10 && phone_no.match(/^[2-9]*$/))
      puts "The phone number you have entered is not a valid number. Please enter a 10 digit phone number not contain 0 / 1"
      phone_no = gets.chomp
      get_word_combinations(phone_no)
    end
  end


  def get_word_combinations(phone_no)
    check_valid_phone_no(phone_no)
    phone_no_array = phone_no.split("")

    key_letter = phone_no_array.map{|n| @letters[n]}
    p key_letter
    begin
      word_list = key_letter.shift.product(*key_letter).map(&:join)
    rescue TypeError
      puts "The phone number you have entered is not a valid number. Please enter a 10 digit phone number not contain 0 / 1"
      phone_no = gets.chomp
      get_word_combinations(phone_no)
    end
   
    #if word_list.try(:present?)
      final_combination = []
      total_number = word_list.length - 1 
      i = 2
      while i < 5 do
        a = word_list.map{|x| x[0..i]}.uniq
        b = word_list.map{|y| y[i+1..-1]}.uniq
        first_array = @dic_words & a
        second_array = @dic_words & b
        combine_array = first_array.product(second_array)
        final_combination << combine_array unless combine_array.empty?
        i += 1
      end
      matches = @dic_words & word_list
      final_combination << matches
      
      final_combination.flatten(1).reverse!.each do |v|
        p v
      end

      # final_words = []
      # final_combination.each do |key, combinataions|
      #   p combinataions
      #   next if combinataions.first.nil? || combinataions.last.nil?
      #   combinataions.first.product(combinataions.last).each do |combo_words|
      #     final_words << combo_words
      #   end
      # end
      # puts final_words

    #end
  end
end

PhoneNumber.new
