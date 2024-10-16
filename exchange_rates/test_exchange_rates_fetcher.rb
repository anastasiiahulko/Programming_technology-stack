# frozen_string_literal: true

require 'minitest/autorun'
require 'net/http'
require 'json'
require 'csv'
require 'stringio'

class TestExchangeRateAPI < Minitest::Test
  def setup
    @api_key = 'ccf25ff8875eb0da6fed70b7'
    @base_currency = 'UAH'
    @url = "https://v6.exchangerate-api.com/v6/#{@api_key}/latest/#{@base_currency}"

    @successful_response = {
      "result" => "success",
      "conversion_rates" => {
        "EUR" => 0.85,
        "USD" => 1.00,
        "GBP" => 0.75,
        "PLN" => 3.85,
        "JPY" => 110.0,
        "AUD" => 1.35,
        "CAD" => 1.25
      },
      "time_last_update_utc" => "2023-01-01T00:00:00Z",
      "time_next_update_utc" => "2023-01-02T00:00:00Z"
    }.to_json

    @error_response = {
      "result" => "error",
      "error-type" => "invalid-key"
    }.to_json

    @original_stdout = $stdout
    $stdout = StringIO.new
  end

  def teardown
    $stdout = @original_stdout
    File.delete('exchange_rates.csv') if File.exist?('exchange_rates.csv')
  end

  def test_successful_api_response
    Net::HTTP.stub(:get, @successful_response) do
      uri = URI(@url)
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
      end

      assert File.exist?('exchange_rates.csv')
      csv_content = CSV.read('exchange_rates.csv')
      expected_content = [
        ["Час останнього оновлення курсу валют: 2023-01-01T00:00:00Z"],
        ["Час наступного запланованого оновлення курсу валют: 2023-01-02T00:00:00Z"],
        [],
        ["Currency", "Rate"],
        ["EUR", "0.85"],
        ["USD", "1.0"],
        ["GBP", "0.75"],
        ["PLN", "3.85"],
        ["JPY", "110.0"],
        ["AUD", "1.35"],
        ["CAD", "1.25"]
      ]
      assert_equal expected_content.map(&:to_s), csv_content.map(&:to_s)
    end
  end

  def test_error_api_response
    Net::HTTP.stub(:get, @error_response) do
      uri = URI(@url)
      response = Net::HTTP.get(uri)
      data = JSON.parse(response)

      if data["result"] != "success"
        puts "Помилка: Не вдалося отримати дані. Повідомлення: #{data['error-type']}"
      end

      assert_match(/Помилка: Не вдалося отримати дані. Повідомлення: invalid-key/, $stdout.string)
    end
  end
end
