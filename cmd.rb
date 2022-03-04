require 'fiber_scheduler'
require 'open-uri'
require 'httparty'
require 'redis'
require 'sequel'

DB = Sequel.connect('postgres://127.0.0.1:5432/postgres?user=postgres&password=postgres')
Sequel.extension(:fiber_concurrency)

Fiber.set_scheduler(FiberScheduler.new)

Fiber.schedule do
  URI.open('https://httpbin.org/delay/2')
end

Fiber.schedule do
  URI.open('https://httpbin.org/delay/2')
end

Fiber.schedule do
  HTTParty.get('https://httpbin.org/delay/2')
end

Fiber.schedule do
  Redis.new.blpop("abc123", 2)
end

Fiber.schedule do
  DB.run('SELECT pg_sleep(2)')
end

10_000.times do
  Fiber.schedule do
    sleep 2
  end
end

Fiber.schedule do
  `sleep 2`
end
