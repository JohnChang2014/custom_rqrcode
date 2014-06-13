require 'spec_helper'

describe RQRCode::CQRCode do
	context ".generateQRcode" do		
		context "with default options but different format" do
			it "returns qrcode in svg format" do
				cqrcode = RQRCode::CQRCode.new
				result = cqrcode.generateQRcode
				expect(result).to match(/svg/)
			end
			
			it "returns qrcode in png format with :png" do
				expect {
					cqrcode = RQRCode::CQRCode.new
					cqrcode.generateQRcode({}, :png)
				}.to_not raise_error
			end
		end
	end
end
