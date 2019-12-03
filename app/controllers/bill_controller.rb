class BillController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    total = 0.0
    # all_bill = Bil.all.order(created_at: :desc)
    mon = Time.now.month
    all_bill=Bil.where('extract(month from date) = ? AND username = ?', mon, params[:id]).order(date: :desc)
    last_bill = all_bill[0]
    puts "#{all_bill}"
    all_bill.map {|e| total += e.amt}
    render :json => {
      :bills => all_bill,
      :total => total,
      :latest => last_bill,
      :month_code => mon
    },
    :status => 200
  end

  def get_month_data
    total = 0;
    all_bill=Bil.where('extract(month from date) = ? AND username = ?', params[:mon], params[:id]).order(date: :desc)
    last_bill = all_bill[0]
    all_bill.map {|e| total += e.amt}
    render :json => {
      :bills => all_bill,
      :total => total,
      :latest => last_bill,
      :month_code => params[:mon]
    },
    :status => 200
  end

  def update
    edit_bill = Bil.find_by_id(params[:id])
    if edit_bill.update_attributes(edit_params)
      render :json => {
        :msg => "Bill Updated"
      },
      :status => 200
    end
  end

  def create
    bills = Bil.new(bil_params)
    if bills.save
      render :json => {
        :msg => "successufully saved"
      },
      :status => 200
    end
  end

  private
  def bil_params
    params.require(:bils).permit(:name, :amt, :date, :username)
  end

  def edit_params
    params.permit(:name, :amt, :date)
  end
end
