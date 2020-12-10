tasks = [
  { title: 'Task #1' },
  { title: 'Task #2' }
]

tasks.each do |t|
  Task.create(t)
end
