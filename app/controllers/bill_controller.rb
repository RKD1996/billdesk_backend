class BillController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    total = 0
    all_bill = Bil.all.order(created_at: :desc);
    last_bill = all_bill[0]
    all_bill.map {|e| total = total + e.amt}
    render :json => {
      :bills => all_bill,
      :total => total,
      :latest => last_bill
    }
  end

  def create
    bills = Bil.new(all_attr)
    raise bills.inspect
  end

  private
  def all_attr
    params.require(:exp).permit
  end

  def permit
  each_pair do |key, value|
    convert_hashes_to_parameters(key, value)
    self[key].permit! if self[key].respond_to? :permit!
  end

  @permitted = true
  self
end


end
