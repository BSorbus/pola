module BusinessTripHelper

  def business_trip_payment_approved_info(bt)
    if bt.payment_on_account_approved_id.present?
      "Zatwierdzono: #{bt.payment_on_account_approved_date_time.strftime("%Y-%m-%d %H:%M:%S")}, <i>~ #{bt.payment_on_account_approved.fullname}</i>".html_safe
    else
      ''
    end
  end

end
