namespace :cron_tasks do
    desc "Will update the currency conversion rate at midnight"
    
    task fetch_new_rates: :environment do
        puts "idhar redis aayega"
        
        begin
            response = RestClient.get(Settings[:api][:url]+Settings[:api][:key]+Settings[:api][:currencies])

            response = response.body
            response_json= JSON.parse(response)

            # used hashset and also rescue exception if api fails

            REDIS.hset("rates",{
                        "inr" => response_json["rates"]["INR"],
                        "usd" => response_json["rates"]["USD"],
                        "yen" => response_json["rates"]["JPY"],
                        "eur" => response_json["rates"]["EUR"],
                        "chf" => response_json["rates"]["CHF"]
                    }   
                      )

            puts response_json
            puts "API CALL WAS SUCCESSFUL AND REDIS IS UPDATED"

        rescue RestClient::ExceptionWithResponse => exception
                puts "RESTCLIENT EXCEPTION RESCUED WITH DETAILS"
                puts exception

        rescue Exception => exception
                puts "UNCHECKED EXCEPTION"
                puts exception

        end        


        
    end

end