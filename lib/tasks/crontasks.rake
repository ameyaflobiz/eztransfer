namespace :cron_tasks do
    desc "Will update the currency conversion rate at midnight"
    
    task fetch_new_rates: :environment do
        puts "idhar redis aayega"
        
        begin
            response = RestClient.get("http://api.exchangeratesapi.io/v1/latest?access_key=ed8c3664907e4efd86e2a0f089be1e87&symbols=INR,USD,JPY,EUR,CHF&format=1")

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

        rescue Exception => exception
            if exception.is_a?(RestClient::ExceptionWithResponse)
                puts "RESTCLIENT EXCEPTION RESCUED WITH DETAILS"

            elsif exception.class==SocketError
                puts "SITE CAN'T BE REACHED"
               
            else
                puts "UNCHECKED EXCEPTION"
                
            end
            puts exception
        
        end
        


        
    end

end