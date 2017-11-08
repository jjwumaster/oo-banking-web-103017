require "pry"
class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  def initialize(sender, receiver, amount, status = 'pending')
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = status
  end
  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    # binding.pry
    if @status == 'pending'  && @sender.balance - @amount > 0 && @receiver.balance - @amount > 0
      @sender.balance = @sender.balance - @amount
      @receiver.deposit(@amount)
      @status = 'complete'
    else
      @status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == 'complete'
      @sender.balance = @sender.balance + @amount
      @receiver.balance -= @amount
      @status = 'reversed'
    end
  end
end
