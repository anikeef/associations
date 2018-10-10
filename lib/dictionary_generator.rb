unless File.exists?("dictionary/dictionary.txt", "w")
  File.open("dictionary/words-russian-nouns.sql", "r") do |file|
    words = file.read.scan(/^\(\d+, '([а-яА-Я]+)',/).flatten
    File.open("dictionary/dictionary.txt", "w") do |file|
      words.each { |word| file.puts "#{word}\n"}
    end
  end
end
