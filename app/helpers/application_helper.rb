module ApplicationHelper

	def sexybutton(label, href='#', icon='', options={})
		options[:class] ||= ""
		options[:class] += " sexybutton"
		link_to raw("<span><span><span class=\"#{icon}\">#{label}</span></span></span>"), href, options
		#raw("<a href=\"#{href}\" class=\"sexybutton\"><span><span><span class=\"#{icon}\">#{label}</span></span></span></a>")
	end

end
