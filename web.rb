
require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'net/http'
#encoding=utf-8


agent = Mechanize.new

uri = 'http://xueshu.baidu.com/s?wd=%E5%B2%A9%E5%9C%9F%E5%B7%A5%E7%A8%8B&sort=sc_cited'
uri2 = 'http://xueshu.baidu.com/s?wd=软件测试&sort=sc_cited'

page = agent.get(uri)
p "starting"
page.links.each do |link|
    #p 'start clicking'
    if link.text.length > 5
     if link.href.include?"s?wd=paperuri"
        p link.text
         newlink = "http://xueshu.baidu.com"+link.href
        newpage = agent.get(newlink)#打开详细页面
        newpage.links.each do |newlink|
            if newlink.href.include?".pdf"
                if newlink.href.include?"cameo"
                p "pdf find！！！"
                p newlink.text
                p newlink.href
                end
            end
        end
        puts "\n"

     end
    end
end