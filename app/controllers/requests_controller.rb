class RequestsController < ApplicationController
  def code
    list = Account.where(ip: params[:ip]).first
    if list
      list = list.list.split(',').map{|p| p.to_i}
      pages = Page.where("id in (?)", list)
      result = 'pages = {};'
      pages.each do |p|
        result+= "page[#{p.name}]=#{p.content}"
      end
      render html: result
    else
      render html: 'error'
    end
  end
end
