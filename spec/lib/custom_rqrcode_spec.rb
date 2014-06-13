require 'spec_helper'

describe RQRCode::CQRCode do
	context ".generateQRcode" do
		let (:cqrcode) { RQRCode::CQRCode.new }	
			
		context "with default options but different format" do
			it "returns qrcode in svg format" do
				result = cqrcode.generateQRcode
				expect(result).to match(/svg/)
			end
			
			it "returns qrcode in png format with :png" do
				expect {
					cqrcode.generateQRcode({}, :png)
				}.to_not raise_error
			end
			
		end
	end
end
