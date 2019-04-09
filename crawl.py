import scrapy
import csv

class TTSprider(scrapy.Spider):
    name = "TT_spider"

    def start_requests(self):
        urls = [
            'http://www.singaporepools.com.sg/DataFileArchive/Lottery/Output/toto_result_draw_list_en.html?v=2019y4m8d19h0m'
        ]
        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse)

    def parse(self, response):
        for option in response.css('select option'):
            query_string = option.css('::attr(querystring)').get()
            if query_string is not None:
                next_page = 'http://www.singaporepools.com.sg/en/product/sr/Pages/toto_results.aspx?' + query_string
                yield scrapy.Request(next_page, callback=self.parse_result)

    def parse_result(self, response):
        row = []
        for number in range(1, 7):
            row.append(response.css('table tbody tr td.win' + str(number) + '::text').get())
        with open('result.csv', 'a') as csvFile:
            writer = csv.writer(csvFile)
            writer.writerow(row)
        csvFile.close()
