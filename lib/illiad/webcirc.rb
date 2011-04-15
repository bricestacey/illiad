require 'mechanize'

module Illiad
  class Webcirc

    def initialize(url, username, password)
      @url = url
      @username = username
      @password = password
      @conn = Mechanize.new
    end

    def connect
      # Load Illiad Web Circulation
      page = @conn.get(@url + '/Logon.aspx')

      # Select, fill in, and submit the logon form.
      page = page.form('formLogon') do |f|
        f.TextBoxUsername = @username
        f.TextBoxPassword = @password
      end.click_button

      # A successful login will redirect to /illiad/WebCirc/Default.aspx
      # A failed login will return to /illiadWebCirc/Logon.aspx
      page.uri.request_uri == '/illiad/WebCirc/Default.aspx'
    end

    def charge!(id)
      page = @conn.get(@url + '/Default.aspx')
      page = page.form('aspnetForm') do |f|
        f['ctl00$TextBoxCheckOutTransaction'] = id
      end.click_button page.form('aspnetForm').button_with(:value => "Check Out")

      msg = page.at("#ctl00_UpdatePanelStatusMessages .failure, #ctl00_UpdatePanelStatusMessages .success, #ctl00_UpdatePanelStatusMessages .warning").inner_html

      raise msg if page.at("#ctl00_UpdatePanelStatusMessages .success").nil?

      true
    end

    def discharge!(id)
      page = @conn.get(@url + '/Default.aspx')
      page = page.form('aspnetForm') do |f|
        f['ctl00$TextBoxCheckInTransaction'] = id
      end.click_button page.form('aspnetForm').button_with(:value => "Check In")

      msg = page.at("#ctl00_UpdatePanelStatusMessages .failure, #ctl00_UpdatePanelStatusMessages .success, #ctl00_UpdatePanelStatusMessages .warning").inner_html

      raise msg if page.at("#ctl00_UpdatePanelStatusMessages .success").nil?

      true
    end
  end
end
