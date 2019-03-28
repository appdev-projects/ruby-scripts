require "rails_helper"

Rails.application.load_tasks

describe "bye.rake" do
  it "outputs 'See you next time, AppDev!'", points: 1 do
    rake_task_output = capture_rake_task_output(task_name: 'bye')
    expect(rake_task_output.index(/See you next time, AppDev!/i)).to be_truthy
  end
end

describe "todays_date.rake" do
  it "outputs todays date in a format that looks like 'Wed, 11 Apr 2018'", points: 1 do
    rake_task_output = capture_rake_task_output(task_name: 'todays_date')
    expect(rake_task_output.index(/#{Date.today.strftime("%a, %e %b %Y")}/)).to be_truthy
  end
end

describe "tgif.rake" do
  it "outputs whether or not it's Friday", points: 1 do
    rake_task_output = capture_rake_task_output(task_name: 'tgif')
    if Date.today.friday?
      expect(rake_task_output.index(/Yay, it's Friday!/i)).to be_truthy
    else
      expect(rake_task_output.index(/Nope, not yet :\//i)).to be_truthy
    end
  end
end

describe "fortune.rake" do
  it "outputs a random fortune", points: 1 do
    fortunes = [
      "Do not mistake temptation for opportunity",
      "A friend asks only for your time not your money",
      "Do not confuse recklessness with confidence",
      "Bide your time, for success is near",
      "Every day in your life is a special occasion"
    ]
    outputted_fortunes = []
    10.times do
      outputted_fortunes.push(
        capture_rake_task_output(task_name: 'fortune')
      )
    end
    unique_outputted_fortunes_count = 0
    fortunes.each do |fortune|
      if outputted_fortunes.grep(/#{fortune}/).count > 0
        unique_outputted_fortunes_count += 1
      end
    end

    expect(unique_outputted_fortunes_count).to be > 1
  end
end

describe "quote.rake" do
  it "outputs a random quote", points: 1 do
    quotations = [
      {
        :quote => "Amateurs sit and wait for inspiration, the rest of us just get up and go to work.",
        :citation => "Stephen King"
      },
      {
        :quote => "Action is the foundational key to all success.",
        :citation => "Pablo Picasso"
      },
      {
        :quote => "There is no substitute for hard work.",
        :citation => "Thomas Edison"
      },
      {
        :quote => "Focused, hard work is the real key to success. Keep your eyes on the goal, and just keep taking the next step towards completing it.",
        :citation => "John Carmack"
      },
      {
        :quote => "It's hard to beat a person who never gives up.",
        :citation => "Babe Ruth"
      },
      {
        :quote => "The mind is everything. What you think you become.",
        :citation => "Buddha"
      },
      {
        :quote => "The best time to plant a tree is 20 years ago. The second best time is now.",
        :citation => "Chinese Proverb"
      },
      {
        :quote => "A person who chases two rabbits catches neither.",
        :citation => "Confucius"
      },
      {
        :quote => "Inspiration exists, but it has to find you working.",
        :citation => "Pablo Picasso"
      },
      {
        :quote => "If there is no wind, row.",
        :citation => "Latin Proverb"
      },
      {
        :quote => "The secret of getting ahead is getting started.",
        :citation => "Author unknown"
      },
      {
        :quote => "Journey of a thousand miles begins with one step.",
        :citation => "Lao Tzu"
      },
    ]

    outputted_quotes = []
    10.times do
      outputted_quotes.push(
        capture_rake_task_output(task_name: 'quote')
      )
    end

    unique_outputted_quotes_count = 0
    quotations.each do |quote_hash|
      formatted_quote = "#{quote_hash[:quote]} -- #{quote_hash[:citation]}"
      if outputted_quotes.grep(/#{formatted_quote}/).count > 0
        unique_outputted_quotes_count += 1
      end
    end

    expect(unique_outputted_quotes_count).to be > 1
  end
end

describe "rps.rake" do
  it "works when the user plays rock", points: 1 do
    working = false
    5.times do
      printed_output_array = capture_rake_task_output(task_name: 'play_rock').split
      if printed_output_array.grep(/rock/i).count > 1
        if printed_output_array.grep(/(tie|tied)/i).count == 0
          working = false
        else
          working = true
        end
      elsif printed_output_array.grep(/paper/i).count == 1
        if printed_output_array.grep(/(lose|lost)/i).count == 0
          working = false
        else
          working = true
        end
      elsif printed_output_array.grep(/scissors/i).count == 1
        if printed_output_array.grep(/(win|won)/i).count == 0
          working = false
        else
          working = true
        end
      end
    end
    expect(working).to be true
  end

  it "works when the user plays paper", points: 1 do
    working = false
    5.times do
      printed_output_array = capture_rake_task_output(task_name: 'play_paper').split
      if printed_output_array.grep(/paper/i).count > 1
        if printed_output_array.grep(/(tie|tied)/i).count == 0
          working = false
        else
          working = true
        end
      elsif printed_output_array.grep(/scissors/i).count == 1
        if printed_output_array.grep(/(lose|lost)/i).count == 0
          working = false
        else
          working = true
        end
      elsif printed_output_array.grep(/rock/i).count == 1
        if printed_output_array.grep(/(win|won)/i).count == 0
          working = false
        else
          working = true
        end
      end
    end
    expect(working).to be true
  end

  it "works when the user plays paper", points: 1 do
    working = false
    5.times do
      printed_output_array = capture_rake_task_output(task_name: 'play_scissors').split
      if printed_output_array.grep(/scissors/i).count > 1
        if printed_output_array.grep(/(tie|tied)/i).count == 0
          working = false
        else
          working = true
        end
      elsif printed_output_array.grep(/rock/i).count == 1
        if printed_output_array.grep(/(lose|lost)/i).count == 0
          working = false
        else
          working = true
        end
      elsif printed_output_array.grep(/paper/i).count == 1
        if printed_output_array.grep(/(win|won)/i).count == 0
          working = false
        else
          working = true
        end
      end
    end
    expect(working).to be true
  end
end

describe "word_count.rake" do
  it "outputs word count statistics", points: 1 do
    path_to_text = Rails.root + "lib/input_files/word_count_text.txt"
    text = open(path_to_text).read

    path_to_special_word = Rails.root + "lib/input_files/word_count_special_word.txt"
    special_word = open(path_to_special_word).read

    character_count_without_spaces = text.gsub(/\s+/, "").length
    special_word_count = text.gsub(/[^a-z0-9\s]/i, '').split.count(special_word.chomp)

    rake_task_output = capture_rake_task_output(task_name: 'word_count')

    expect(rake_task_output.index(/#{text.chomp}/)).to be_truthy
    expect(rake_task_output.index(/#{character_count_without_spaces}/)).to be_truthy
    expect(rake_task_output.index(/#{special_word.chomp}/)).to be_truthy
    expect(rake_task_output.index(/#{special_word.chomp}/)).to be_truthy
    expect(rake_task_output.index(/#{special_word_count}/)).to be_truthy
  end
end

describe "loan_payment.rake" do
  it "outputs loan payment statistics", points: 1 do
    apr = open(Rails.root + 'lib/input_files/loan_payment_apr.txt').read.chomp.to_f
    years = open(Rails.root + 'lib/input_files/loan_payment_years.txt').read.chomp.to_i
    principal = open(Rails.root + 'lib/input_files/loan_payment_principal.txt').read.chomp.to_f

    rate = apr / 100 / 12
    nper = years * 12
    monthly_payment = (rate * principal)/(1 - (1 + rate)**-nper)

    rake_task_output = capture_rake_task_output(task_name: 'loan_payment')

    expect(rake_task_output.index(/#{apr}/)).to be_truthy
    expect(rake_task_output.index(/#{years}/)).to be_truthy
    expect(rake_task_output.index(/#{principal}/)).to be_truthy
    expect(rake_task_output.index(/#{monthly_payment.round(2)}/)).to be_truthy
  end
end

describe "count_and_sort.rake" do
  it "outputs list of sorted numbers with a count", points: 1 do
    path_to_file = Rails.root + "lib/input_files/descriptive_statistics_numbers.txt"
    string_input = open(path_to_file).read.chomp
    numbers = string_input.gsub(",", "").split.map(&:to_f)

    sorted_numbers = numbers.sort
    count = numbers.count

    rake_task_output = capture_rake_task_output(task_name: 'count_and_sort')
    expect(rake_task_output).to include(numbers.awesome_inspect)
    expect(rake_task_output).to include("Count: #{count}")
    expect(rake_task_output).to include(sorted_numbers.awesome_inspect)

  end
end

describe "minimum.rake" do
  it "calculates the minimum from a list of numbers", points: 1 do
    path_to_file = Rails.root + "lib/input_files/descriptive_statistics_numbers.txt"
    input = open(path_to_file).read.chomp
    numbers = input.gsub(",", "").split.map(&:to_f)
    minimum = numbers.first
    numbers.each do |num|
      if num < minimum
        minimum = num
      end
    end
    rake_task_output = capture_rake_task_output(task_name: 'minimum')
    expect(rake_task_output.index(/:.*#{minimum}/)).to be_truthy
  end
end

describe "maximum.rake" do
  it "calculates the maximum from a list of numbers", points: 1 do
    path_to_file = Rails.root + "lib/input_files/descriptive_statistics_numbers.txt"
    input = open(path_to_file).read.chomp
    numbers = input.gsub(",", "").split.map(&:to_f)
    maximum = numbers.first
    numbers.each do |num|
      if num > maximum
        maximum = num
      end
    end
    rake_task_output = capture_rake_task_output(task_name: 'maximum')
    expect(rake_task_output.index(/:.*#{maximum}/)).to be_truthy
  end
end

describe "range.rake" do
  it "calculates the range from a list of numbers", points: 1 do
    path_to_file = Rails.root + "lib/input_files/descriptive_statistics_numbers.txt"
    input = open(path_to_file).read.chomp
    numbers = input.gsub(",", "").split.map(&:to_f)
    minimum = numbers.first
    numbers.each do |num|
      if num < minimum
        minimum = num
      end
    end

    maximum = numbers.first
    numbers.each do |num|
      if num > maximum
        maximum = num
      end
    end

    range = maximum - minimum
    rake_task_output = capture_rake_task_output(task_name: 'range')
    expect(rake_task_output.index(/#{range}/)).to be_truthy
  end
end

describe "sum.rake" do
  it "calculates the sum from a list of numbers", points: 1 do
    path_to_file = Rails.root + "lib/input_files/descriptive_statistics_numbers.txt"
    input = open(path_to_file).read.chomp
    numbers = input.gsub(",", "").split.map(&:to_f)

    sum = 0
    numbers.each do |num|
      sum = sum + num
    end
    rake_task_output = capture_rake_task_output(task_name: 'sum')
    expect(rake_task_output.index(/#{sum}/)).to be_truthy
  end
end

describe "mean.rake" do
  it "calculates the mean from a list of numbers", points: 1 do
    path_to_file = Rails.root + "lib/input_files/descriptive_statistics_numbers.txt"
    input = open(path_to_file).read.chomp
    numbers = input.gsub(",", "").split.map(&:to_f)

    sum = 0
    numbers.each do |num|
      sum = sum + num
    end

    count = numbers.count

    mean = sum/count
    rake_task_output = capture_rake_task_output(task_name: 'mean')
    expect(rake_task_output.index(/#{mean.round(2)}/)).to be_truthy
  end
end

describe "median.rake" do
  it "calculates the median from a list of numbers", points: 1 do
    path_to_file = Rails.root + "lib/input_files/descriptive_statistics_numbers.txt"
    input = open(path_to_file).read.chomp
    numbers = input.gsub(",", "").split.map(&:to_f)

    sorted_numbers = numbers.sort
    count = numbers.count
    if count.odd?
      median = sorted_numbers[count / 2]
    else
      left_of_middle = sorted_numbers[(count / 2) - 1]
      right_of_middle = sorted_numbers[(count / 2)]
      median = (left_of_middle + right_of_middle) / 2
    end
    rake_task_output = capture_rake_task_output(task_name: 'median')
    expect(rake_task_output.index(/:.*#{median}/)).to be_truthy
  end
end

describe "standard_deviation.rake" do
  it "calculates the standard_deviation from a list of numbers", points: 1 do
    path_to_file = Rails.root + "lib/input_files/descriptive_statistics_numbers.txt"
    input = open(path_to_file).read.chomp
    numbers = input.gsub(",", "").split.map(&:to_f)

    count = numbers.count
    sum = 0
    numbers.each do |num|
      sum = sum + num
    end
    mean = sum/count
    squared_differences = []

    numbers.each do |num|
      difference = num - mean
      squared_difference = difference ** 2
      squared_differences.push(squared_difference)
    end

    variance = squared_differences.sum / count

    standard_deviation = Math.sqrt(variance)

    rake_task_output = capture_rake_task_output(task_name: 'standard_deviation')
    expect(rake_task_output.index(/#{standard_deviation}/)).to be_truthy
  end
end

describe "mode.rake" do
  it "calculates the mode from a list of numbers", points: 1 do
    path_to_file = Rails.root + "lib/input_files/descriptive_statistics_numbers.txt"
    input = open(path_to_file).read.chomp
    numbers = input.gsub(",", "").split.map(&:to_f)

    leader = nil
    leader_count = 0

    numbers.each do |num|
      occurrences = numbers.count(num)
      if occurrences > leader_count
        leader = num
        leader_count = occurrences
      end
    end

    mode = leader

    rake_task_output = capture_rake_task_output(task_name: 'mode')
    expect(rake_task_output.index(/#{mode}/)).to be_truthy
  end
end

def capture_rake_task_output(task_name:)
  stdout = StringIO.new
  $stdout = stdout
  Rake::Task[task_name].invoke
  $stdout = STDOUT
  Rake.application[task_name].reenable
  return stdout.string
end
