require 'spec_helper'

describe RQRCode::CQRCode do
	context ".generateQRcode" do
		context "with default options" do
			it "returns qrcode in svg format" do
				cqrcode = RQRCode::CQRCode.new
				result = cqrcode.generateQRcode
				expect(result).to match(/svg/)
			end
		end
	end
end
