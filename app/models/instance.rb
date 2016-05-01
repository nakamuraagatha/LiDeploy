class Instance < ActiveRecord::Base
  belongs_to :user
  def paypal_url(return_path,inst)
    if inst.duration == 1
      if inst.size == "512mb"
        price = '6'
      elsif inst.size == '1gb'
        price = '11'
      elsif inst.size == '2gb'
        price = '22'
      end
    elsif inst.duration == 3
      if inst.size == "512mb"
        price = '15.99'
      elsif inst.size == '1gb'
        price = '28.99'
      elsif inst.size == '2gb'
        price = '57.99'
      end
    elsif inst.duration == 6
      if inst.size == "512mb"
        price = '31.99'
      elsif inst.size == '1gb'
        price = '59.99'
      elsif inst.size == '2gb'
        price = '121.99'
      end
    end
    values = {
        business: "support@lideploy.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}/instances/show",
        invoice: inst.id,
        amount: price,
        item_name: "#{inst.size} Server on Lideploy.com",
        item_number: inst.id,
        quantity: '1',
        notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end
