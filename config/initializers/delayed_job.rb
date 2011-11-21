Delayed::Worker.destroy_failed_jobs = false
#Delayed::Worker.sleep_delay = 60
#Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 12.hours
Delayed::Worker.delay_jobs = !Rails.env.test?