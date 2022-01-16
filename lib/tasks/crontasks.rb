namespace :cron_tasks do
    desc "Will update the currency conversion rate at midnight"
    
    task :fetch_new_rates do
        puts "idhar redis aayega"
        response= HTTParty.get("http://api.exchangeratesapi.io/v1/latest?access_key=ed8c3664907e4efd86e2a0f089be1e87&symbols=INR,USD,YEN,EUR,CHF&format=1").to_json
        response_json= JSON.parse(response)
        puts response_json
        
    end

end