require 'mechanize'

module Illiad
  module WebCirc
    class Base
      attr_accessor :conn

      URL_PATH_DEFAULT = '/illiad/WebCirc/Default.aspx'
      URL_PATH_LOGON = '/illiad/WebCirc/Logon.aspx'

      def initialize(url, username, password)
        @url = url
        @username = username
        @password = password
        @conn = Mechanize.new
      end

      def establish_connection
        begin
          # Load Illiad Web Circulation
          page = @conn.get(@url + URL_PATH_LOGON)

          # Select, fill in, and submit the logon form.
          page = page.form('formLogon') do |f|
            f.TextBoxUsername = @username
            f.TextBoxPassword = @password
          end.click_button

          # A successful login will redirect to /illiad/WebCirc/Default.aspx
          # A failed login will return to /illiadWebCirc/Logon.aspx
          page.uri.request_uri == URL_PATH_DEFAULT
        rescue
          # TODO: log error
          false
        end
      end

      def disconnect
        # Rather than actually sign off, we just toss the old Mechanize agent
        @conn = Mechanize.new
        true
      end

      def connected?
        begin
          page = @conn.get(@url + URL_PATH_DEFAULT)
        rescue
          # Assume not if there are any errors fetching page
          # TODO: log
          return false
        end

        page.uri.request_uri == URL_PATH_DEFAULT
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
end
