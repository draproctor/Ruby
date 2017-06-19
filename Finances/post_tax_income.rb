def post_tax_income()
  puts "How much is earned per year?"
  yearly = gets.chomp.to_i
  puts "How much is rent per month?"
  rent = gets.chomp.to_i
  puts "How many miscellaneous bills are there per month?"
  bills = gets.chomp.to_i

  # This is assuming single taxable income for 2017.
  first_bracket = yearly - (0.10 * yearly)
  second_bracket = yearly - (932 + 0.15 * (yearly - 9325))
  third_bracket = yearly - (5226 + 0.24 * (yearly - 37950))
  fourth_bracket = yearly - (18713 + 0.28 * (yearly - 91900))
  fifth_bracket = yearly - (46643 + 0.33 * (yearly - 191650))
  sixth_bracket = yearly - (120910 + 0.35 * (yearly - 416700))
  seventh_bracket = yearly - (121505 + 0.396 * (yearly - 418400))

  case
  when yearly < 9325
    post_tax = first_bracket
  when yearly > 9326 && yearly < 37950
    post_tax = second_bracket
  when yearly > 37951 && yearly < 91900
    post_tax = third_bracket
  when yearly > 91901 && yearly < 191650
    post_tax = fourth_bracket
  when yearly > 191651 && yearly < 416700
    post_tax = fifth_bracket
  when yearly > 416701 && yearly < 418400
    post_tax = sixth_bracket
  when yearly > 418400
    post_tax = seventh_bracket
  else
    puts 'Invalid yearly income entered. Please enter a valid integer.'
  end

  paycheck_pre = yearly / 26
  paycheck_post = post_tax / 26
  puts "\n$#{paycheck_pre} per paycheck pre-taxes."
  puts "$#{paycheck_post} per paycheck post-taxes."

  monthly = post_tax / 12
  max_rent = monthly / 3
  puts "\n$#{monthly} per month after taxes."
  puts "$#{max_rent} is the maximum rent cost."

  monthly_post_rent = monthly - rent
  puts "$#{monthly_post_rent} per month after rent."

  monthly_post_bills = monthly - rent - bills
  puts "$#{monthly_post_bills} per month after all expenses."

  # Assuming 30 days in a month.
  daily_post = monthly_post_bills / 30
  puts "\n$#{daily_post} can be spent on whatever you want per day."
end

post_tax_income()
