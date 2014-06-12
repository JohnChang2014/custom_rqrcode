require 'action_controller'
require 'rqrcode'
require 'rqrcode-rails3/size_calculator.rb'
require 'rqrcode-rails3/renderers/svg.rb'

module RQRCode
	ActionController::Renderers.add :qrcode do |string, options|
		format         = self.request.format.symbol
		cqrcode        = RQRCode::CQRCode.new
		options[:info] = string
		data           = cqrcode.generateQRcode(options, format)

		self.response_body = render_to_string(:text => data, :template => nil)
	end

	class CQRCode
		@@defaults = {
			:info     => "this is custom_rqrcode gem",
			:gravity  => "north",
			:geometry => "+00+00",
		}

		def generateQRcode(options={}, format=:svg)
			options  = @@defaults.merge(options)
			string   = options[:info]
			size     = options[:size]  || RQRCode.minimum_qr_size_from_string(string)
			level    = options[:level] || :h

			qrcode = RQRCode::QRCode.new(string, :size => size, :level => level)
			svg    = RQRCode::Renderers::SVG::render(qrcode, options)

			data   = \
			if format && format == :svg
				svg
			else
				image = MiniMagick::Image.read(svg) { |i| i.format "svg" }
				image.format format

				mergeBackgroundImage(image, options) if options.key? :bg
				image.resize options[:fsize] if options.key? :fsize
				image.write options[:fsave] if options.key? :fsave

				image.to_blob
			end
			return data
		end

		private

		def mergeBackgroundImage(image, options)
			bg_image = MiniMagick::Image.open bg
			bg_image.resize options[:bsize] if options.key? :bsize
			image = bg_image.composite(image) do |c|
				c.gravity options[:gravity]
				c.geometry options[:geometry]
			end
		end
	end
end
