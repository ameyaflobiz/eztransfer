class NotifyWorker
	include Sidekiq::Worker
	sidekiq_options retry:false

	def perform (transaction_id,transaction_status)

		message = "Transaction status was unclear"

		if transaction_status == "success"
			message = "Your transaction with id #{transaction_id} was successful!"

		elsif transaction_status == "failed"
			message = "Your transaction with id #{transaction_id} was unsuccessful!"
		end

		puts message


	end
end