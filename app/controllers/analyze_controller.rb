class AnalyzeController < ApplicationController

  def get_month_and_year_data
    data = Bil.all.where("username = ?", params[:id])
    month = data.map{|e| e.date.to_s.split("-")[1]}
    year = data.map{|e| e.date.to_s.split("-")[0]}
    render :json => {
      :month => month.uniq.sort,
      :year => year.uniq.sort
    }
  end

  def get_monthly_data
    weekly = [0,0,0,0,0]
    data = Bil.all.where("extract(month from date) = ? AND extract(year from date) = ?  AND username = ?", params[:month], params[:year], params[:id]).order(date: :asc )
    data.each{|d| weekly[d.date.day/7]+=d.amt }
    render :json => {
      :weekly_data => [["week1", weekly[0]], ["week2", weekly[1]], ["week3", weekly[2]], ["week4", weekly[3]], ["week5", weekly[4]]]
    },
    :status => 200

  end

end
