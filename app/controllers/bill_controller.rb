class BillController < ApplicationController

  def show
    total = 0
    all_bill = Bil.all.order(created_at: :desc);
    last_bill = all_bill.fist
    all_bill.map {|e| total = total + e.amt}
    render :json => {
      :bills => all_bill,
      :total => total,
      :latest => last_bill
    }
  end

  def create
    params[:bills].each do |e|
      bill = Bil.new(e)
      if bill.save
        render :json => {
          :data => bill
        }
      end
    end
  end

end
