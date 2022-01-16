class ConversionService

    def self.convert( base_curr, target_curr, sender_amount )
        # Idhar redis bulaayenge
        # Since base here is EURO, toh BASE --> EURO --> TARGET
        base_curr = base_curr.downcase
        target_curr = target_curr.downcase
        
        euro_to_base_curr = REDIS.get(base_curr).to_d
        euro_to_target_curr= REDIS.get(target_curr).to_d
        
        sender_amount_in_euro = sender_amount / euro_to_base_curr
        
        @reciever_amount_converted = sender_amount_in_euro * euro_to_target_curr
        
        
    end
end