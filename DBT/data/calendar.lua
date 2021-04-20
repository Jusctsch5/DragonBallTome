-- Just for fun, let's start the year of the end of the Mayan calendar.
-- But...for simplicity, let's start on January 1st, instead of Dec 26th

time.start_year = 2012
time.start_day = 1
-- Sunrise
time.start_minute = 360
time.dawnhour = 6
time.duskhour = 18

time.set_calendar
{
	{ 31, "January", },
	{ 28, "February", },
	{ 31, "March", },
	{ 30, "April", },
	{ 31, "May", },
	{ 30, "June", },
	{ 31, "July", },
	{ 31, "August", },
	{ 30, "September", },
	{ 31, "October", },
	{ 30, "November", },
	{ 31, "December", },
}

-- Rewrite the formating of a date
time.get_date_string = function(t)
	local turn = time.display_turn(t)
	local year = time.display_year(t)
	local dayofyear = time(time.DAY, turn)
	local month = time.get_month_name(dayofyear)
	local day = time.ordinal(time.get_day_of_month(dayofyear))

	return "Today is the "..day.." of "..month..", "..year..""
end
