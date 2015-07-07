def run_spec(file)
  unless File.exists?(file)
    puts "#{file} does not exist"
    return
  end

  puts "*" * 60
  puts "#{DateTime.now} Running #{file}"
  system "bundle exec rspec #{file}"
  puts
end

def run_all_specs
  puts "*" * 60
  puts "#{DateTime.now} Running all Specs"
  system "bundle exec rspec"
  puts
end

watch("spec/.*/*_spec.rb") do |match|
  run_spec match[0]
end
watch("spec/.*/*s.rb") do |match|
  run_spec match[0]
end

watch("app/(.*/.*).rb") do |match|
  run_spec %{spec/#{match[1]}_spec.rb}
end

Signal.trap('QUIT') do
  run_all_specs
end

Signal.trap('INT') do
  abort("Exiting Watchr...\n")
end
