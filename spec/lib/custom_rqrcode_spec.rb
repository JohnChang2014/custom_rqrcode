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
			
			it "returns qrcode in jpeg format with :jpeg" do
				expect {
					cqrcode.generateQRcode({}, :jpeg)
				}.to_not raise_error
			end
			
			it "returns qrcode in gif format with :gif" do
				expect {
					cqrcode.generateQRcode({}, :gif)
				}.to_not raise_error
			end
		end
		
		context "with options[:fsave] = current root path" do
			it "does not raise error" do
				filename = Time.now.nsec.to_s + '.png'
				path     = Dir.pwd
				filepath = [path, filename].join('/')
				options = { :fsave => filepath }
				expect { 
					cqrcode.generateQRcode(options, :png)
				}.to_not raise_error
				File.delete filepath
			end
			
			it "outputs image file in the current root path" do
				filename = Time.now.nsec.to_s + '.png'
				path     = Dir.pwd
				filepath = [path, filename].join('/')
				options = { :fsave => filepath }
				cqrcode.generateQRcode(options, :png)
				expect { 
					File.exist? filepath
				}.to be_true
				File.delete filepath
			end
		end
	end
end
