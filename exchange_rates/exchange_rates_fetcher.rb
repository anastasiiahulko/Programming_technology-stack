require 'net/http'
require 'json'
require 'csv'

api_key = 'ccf25ff8875eb0da6fed70b7'
base_currency = 'UAH'

url = "https://v6.exchangerate-api.com/v6/#{api_key}/latest/#{base_currency}"

uri = URI(url)
response = Net::HTTP.get(uri)
data = JSON.parse(response)

if data["result"] == "success"
  rates = data["conversion_rates"]
  time_last_update_utc = data["time_last_update_utc"]
  time_next_update_utc = data["time_next_update_utc"]

  File.open("exchange_rates.csv", "w") do |file|
    file.puts("Час останнього оновлення курсу валют: #{time_last_update_utc}")
    file.puts("Час наступного запланованого оновлення курсу валют: #{time_next_update_utc}")
    file.puts  
  end

  CSV.open("exchange_rates.csv", "a") do |csv|
    csv << ["Currency", "Rate"]
    
    currencies_to_extract = ["EUR", "USD", "GBP", "PLN", "JPY", "AUD", "CAD"]
    currencies_to_extract.each do |currency|
      if rates.key?(currency)
        csv << [currency, rates[currency]]
      end
    end
  end

  puts "Дані успішно збережено у файл exchange_rates.csv"
else
  puts "Помилка: Не вдалося отримати дані. Повідомлення: #{data['error-type']}"
end
