require 'sinatra'
require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'net/http'
#encoding=utf-8
agent = Mechanize.new

uri = 'http://xueshu.baidu.com/s?wd=%E5%B2%A9%E5%9C%9F%E5%B7%A5%E7%A8%8B&sort=sc_cited'
uri2 = 'http://xueshu.baidu.com/s?wd=软件测试&sort=sc_cited'
countPdfs = 0
while(1)
page = agent.get(uri)
p "starting"
page.links.each do |link|
	if link.text.length > 5
		if link.href.include?"s?wd=paperuri"
			n = 0 #判断是否输出了标题和目录
			m = 0
			newlink = "http://xueshu.baidu.com"+link.href
			newpage = agent.get(newlink)
			newpage.links.each do |nlink|#遍历二级页面
				if nlink.href.include?".pdf"
				#发现有下载链接
					p link.text if n== 0  #输出标题-下面输出摘要
					p n = 1 
					newpage.search('.abstract').each do |link_abstract|
						puts link_abstract.content if m == 0
						p m = 1
					end
					p nlink.href #输出可以下载的链接
					countPdfs+=1
				end
			end			
		end
	end
end
page.links.each do|link|
			if link.text == '下一页>'
				p 'true'
        page = agent.get(link.href)
			end
  end
  break if countPdfs == 20
  end