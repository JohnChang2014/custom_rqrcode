require 'action_controller'
require 'rqrcode'
require 'rqrcode-rails3/size_calculator.rb'
require 'rqrcode-rails3/renderers/svg.rb'

module RQRCode
	Mime::Type.register "image/svg+xml", :svg  unless Mime::Type.lookup_by_extension(:svg)
	Mime::Type.register "image/png",     :png  unless Mime::Type.lookup_by_extension(:png)
	Mime::Type.register "image/jpeg",    :jpeg unless Mime::Type.lookup_by_extension(:jpeg)
	Mime::Type.register "image/gif",     :gif  unless Mime::Type.lookup_by_extension(:gif)

	extend SizeCalculator

	ActionController::Renderers.add :qrcode do |string, options|
		format         = self.request.format.symbol
		cqrcode        = RQRCode::CQRCode.new
		options[:info] = string
		data           = cqrcode.generateQRcode(options, format)

		self.response_body = render_to_string(:text => data, :template => nil)
	end

	class CQRCode
		@@defaults = {
			:info     => "no data",
			:bg       => false,
			:bsize    => false,
			:gravity  => "north",
			:geometry => "+00+00",
			:fsize    => false,
			:fsave    => false
		}

		def generateQRcode(options={}, format=:svg)
			options  = @@defaults.merge(options)
			string   = options[:info]
			size     = options[:size]  || RQRCode.minimum_qr_size_from_string(string)
			level    = options[:level] || :h

			bg       = options[:bg]
			bsize    = options[:bsize]
			geometry = options[:geometry]
			gravity  = options[:gravity]
			fsize    = options[:fsize]
			fsave    = options[:fsave] 

			qrcode = RQRCode::QRCode.new(string, :size => size, :level => level)
			svg    = RQRCode::Renderers::SVG::render(qrcode, options)

			data   = \
			if format && format == :svg
				svg
			else
				image = MiniMagick::Image.read(svg) { |i| i.format "svg" }
				image.format format

				if bg
					bg_image = MiniMagick::Image.open bg
					bg_image.resize bsize if bsize
					image    =  bg_image.composite(image) do |c|
						c.gravity gravity
						c.geometry geometry
					end
				end
				image.resize fsize if fsize
				image.write fsave if fsave

				image.to_blob
			end
			return data
		end
	end
end
