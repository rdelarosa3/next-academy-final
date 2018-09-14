module BusinessHoursHelper


	def open_now
		start = '09:30'
		close = '18:00'
		Time.zone = 'Central Time (US & Canada)'
		current_time = Time.zone.now
		opened = current_time.strftime('%H:%M')

		if opened.between?(start ,close)
			"Open Now"
		end
	end
end
