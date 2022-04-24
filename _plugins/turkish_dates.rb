module Jekyll
module TurkishDates
    MONTHS = {"01" => "Ocak", "02" => "Şubat", "03" => "Mart",
            "04" => "Nisan", "05" => "Mayıs", "06" => "Haziran",
            "07" => "Temmuz", "08" => "Ağustos", "09" => "Eylül",
            "10" => "Ekim", "11" => "Kasım", "12" => "Aralık"}

    # http://man7.org/linux/man-pages/man3/strftime.3.html
    def turkishDate(date)
        day = time(date).strftime("%e") # leading zero is replaced by a space
        month = time(date).strftime("%m")
        year = time(date).strftime("%Y")
        day+' '+MONTHS[month]+' '+year
    end

    def html5date(date)
        day = time(date).strftime("%d")
        month = time(date).strftime("%m")
        year = time(date).strftime("%Y")
        year+'-'+month+'-'+day
    end
end
end

Liquid::Template.register_filter(Jekyll::TurkishDates)