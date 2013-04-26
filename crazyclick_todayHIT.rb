require 'net/http'
require 'rchardet19'

#获得网页内容
def query_url(url)
  return Net::HTTP.get(URI.parse(url));
end

def toUtf8(_string)
  cd = CharDet.detect(_string)
  if cd.confidence > 0.6
    _string.force_encoding(cd.encoding)
  end
  _string.encode!("utf-8", :undef => :replace, :replace => "?", :invalid => :replace)
  return  _string
end

#抓取cnproxy上所有的代理列表,并将结果保存到proxy.txt中去
def find_all_proxy
#模拟执行js
z="3" 
m="4"
a="2"
l="9"
f="0"
b="5"
i="7"
w="6"
x="8"
c="1"

#你可以修改这块代码获取其他的代理服务器列表
  pf = File.new("proxy.txt","w+")
  for page_no in 1..10
    url = "http://www.cnproxy.com/proxy#{page_no}"
    htmk = query_url(url)
    content=toUtf8(htmk)
    puts content
    for array in content.scan(/<td>(.*?)<SCRIPT type=text\/javascript>document.write\(":"\+(.*?)\)<\/SCRIPT><\/td>/)
      if array.length == 2 && (array[1]=~/[rdk]+/)==nil              #排除包含未定义字符的结果item
        pf.write("#{array[0]}:#{eval(array[1])}\n")
      end
    end
  end
  pf.close
end

##处理请求
def open_url_with_proxy(url)
  pf = File.open("proxyedu.txt","r")
  d = []
  pf.each { |line| d << line }
  for var in d
    print "User Proxy #{var}\n"
    begin
      proxy = Net::HTTP::Proxy(var.split(":")[0],var.split(":")[1].to_i)
      content=proxy.get(URI.parse(url))
      puts content
    rescue
      ##吃掉异常
      puts "error!!!"
    end
  end
end


##主程序
begin
  ##刷投票目标地址
    url='http://today.hit.edu.cn/commend/91413_1.htm'
  #if !FileTest.exist?( "proxy.txt" )
    find_all_proxy
  #end
    open_url_with_proxy(url)
end
