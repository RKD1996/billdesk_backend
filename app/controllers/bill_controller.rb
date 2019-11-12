class BillController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    total = 0
    # all_bill = Bil.all.order(created_at: :desc)
    mon = Time.now.month
    all_bill=Bil.where('extract(month from date) = ?', mon)
    last_bill = all_bill[0]
    all_bill.map {|e| total += e.amt}
    render :json => {
      :bills => all_bill,
      :total => total,
      :latest => last_bill
    }
  end

  def get_month_data
    total = 0;
    all_bill=Bil.where('extract(month from date) = ?', params[:mon])
    last_bill = all_bill[0]
    all_bill.map {|e| total += e.amt}
    render :json => {
      :bills => all_bill,
      :total => total,
      :latest => last_bill
    }
  end

  def create
    bills = Bil.new(bil_params)
    if bills.save
      render :json => {
        :msg => "successufully saved"
      }
    end
  end

  private
  def bil_params
    params.require(:bils).permit(:name, :amt, :date)
  end

end
