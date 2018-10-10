def generate_pairs(code)
  letter_codes =
    {"0" => ["к", "г"],
     "1" => ["м", "ж"],
     "2" => ["д", "х"],
     "3" => ["т", "ц"],
     "4" => ["н", "ч"],
     "5" => ["п", "б"],
     "6" => ["р", "щ"],
     "7" => ["с", "з"],
     "8" => ["в", "ф"],
     "9" => ["л", "ш"]}

  pairs = []
  letter_codes[code[0]].each do |letter1|
    letter_codes[code[1]].each do |letter2|
      pairs << "#{letter1}#{letter2}"
    end
  end
  pairs
end

codes = (0..99).map { |num| num.to_s.rjust(2, "0") }
words = File.read("dictionary.txt").split("\n")

codes.each do |code|
  File.open("associations/#{code}.txt", "w") do |file|
    pairs = generate_pairs(code)
    pairs.each do |pair|
      letter1, letter2 = pair.split("")
      regexp = Regexp.new("\\A[йаяеёэиыуоюьъ]*#{letter1}[йаяеёэиыуоюьъ]*#{letter2}[а-яА-Я]*\\Z")
      file.puts words.select { |word| regexp.match?(word) }
      file.write "\n----------------\n"
    end
  end
end
