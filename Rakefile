require 'rake/testtask'

Rake::TestTask.new('test') do |t|
  t.libs << ['lib', 'test']
  t.test_files = FileList['test/*/*_test.rb']
  t.verbose = true
  t.warning = true
end

Rake::TestTask.new('test:unit') do |t|
  t.libs << ['lib', 'test']
  t.test_files = FileList['test/unit/*_test.rb']
  t.verbose = true
  t.warning = true
end

Rake::TestTask.new('test:integration') do |t|
  t.libs << ['lib', 'test']
  t.test_files = FileList['test/integration/*_test.rb']
  t.verbose = true
  t.warning = true
end
