module Illiad
  module AR
    class Transaction < Illiad::AR::Base
      set_table_name 'Transactions'
      set_primary_key 'TransactionNumber'

      def charged?
        status = read_attribute(:TransactionStatus)
        (status == 'Checked Out to Customer' or
         status == 'Renewal Denied' or
         status =~ /Renewed by Customer to .*/ or
         status =~ /Renewed by ILL Staff to .*/ or
         status == 'Loans Recalled from Patrons') ? true : false
      end
    end
  end
end
