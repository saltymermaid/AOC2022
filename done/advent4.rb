assignments = File.open("advent4data.txt")

# assignment: 12-80,12-81

pairs = []
assignments.each do |ass|
  pairs << ass.chomp.split(',')
end

# pair: ["12-80", "12-81"]

jobs = []
i = 0
pairs.each do |pair|
  jobs[i] = []
  jobs[i] << pair[0].split('-')
  jobs[i] << pair[1].split('-')
  i += 1
end

# job: [["12", "80"], ["12", "81"]]

full_jobs = []
jobs.each_with_index do |job_pair, i|
  full_jobs[i] = []
  job_pair.each_with_index do |job, j|
    start = job[0].to_i
    stop = job[1].to_i
    full_jobs[i][j] = []
    for k in start..stop
      full_jobs[i][j] << k
    end
  end
end

# full_jobs: [[12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80], 
# [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]]

overlap = 0
full_jobs.each do |job|
  # puts "#{job[0]} & #{job[1]} = #{job[0] & job[1]}"
  if ((job[0] & job[1]) == job[0]) || ((job[0] & job[1]) == job[1])
    overlap += 1
  end
end

puts overlap