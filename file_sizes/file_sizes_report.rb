require 'find'
require 'optparse'

def generate_file_size_report(root_dir, output_file)
  File.open(output_file, 'w') do |report|
    Find.find(root_dir) do |path|
      if File.file?(path)
        begin
          size = File.size(path)
          report.puts("#{path}\t#{size} байт")
        rescue => e
          puts "Не вдалося отримати доступ до #{path}: #{e}"
        end
      end
    end
  end
end

if __FILE__ == $0
  options = {}

  OptionParser.new do |opts|
    opts.banner = "Використання: ruby file_size_report.rb [опції]"

    opts.on("-dDIRECTORY", "--directory=DIRECTORY", "Коренева директорія для аналізу") do |dir|
      options[:directory] = dir
    end

    opts.on("-oOUTPUT", "--output=OUTPUT", "Файл для збереження звіту") do |out|
      options[:output] = out
    end

    opts.on("-h", "--help", "Вивести цю довідку") do
      puts opts
      exit
    end
  end.parse!

  if options[:directory] && options[:output]
    generate_file_size_report(options[:directory], options[:output])
    puts "Звіт успішно збережено в файл #{options[:output]}"
  else
    puts "Потрібно вказати кореневу директорію та файл звіту."
    puts "Використання: ruby file_size_report.rb -d /шлях/до/директорії -o звіт.txt"
  end
end
