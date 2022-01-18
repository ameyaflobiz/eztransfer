namespace :cron_tasks do
    desc "Will update the currency conversion rate at midnight"
    
    task fetch_new_rates: :environment do
        puts "idhar redis aayega"
        response= RestClient.get("http://api.exchangeratesapi.io/v1/latest?access_key=ed8c3664907e4efd86e2a0f089be1e87&symbols=INR,USD,JPY,EUR,CHF&format=1").to_json
        response_json= JSON.parse(response)

        # use hashset and also rescue exception if api fails
        REDIS.set("inr", response_json["rates"]["INR"])
        REDIS.set("usd", response_json["rates"]["USD"])
        REDIS.set("yen", response_json["rates"]["JPY"])
        REDIS.set("eur", response_json["rates"]["EUR"])
        REDIS.set("chf", response_json["rates"]["CHF"])

        puts response_json
        
    end

end