require "selenium-webdriver"

begin
  firefox = Selenium::WebDriver.for :ff
  firefox.get "http://learn.swcontest.net/home/noframe"
  #等待js执行结束
  sleep 3
  #填充登录信息
  username_input = firefox.find_element(css: '#user-login-name')
  username_input.send_keys "#username"
  password_input = firefox.find_element(css: '#user-login-password')
  password_input.send_keys "password"
  #确定登录
  submit_button=firefox.find_element(xpath: "//*[@id='user-login-section']/ul/li[3]/button")
  submit_button.click
  #等待页面刷新
  sleep 3
  #选定题目集
  questionset= firefox.find_element(xpath: "//*[@id='contest-lib-dir-1']/a")
  questionset.click
  #开始答题
  @i=0
  while(true) do
       sleep 2
      if (@i==4)#5题一提交    
        firefox.find_element(xpath: "//*[@id='#{@i/2}']").click
        #sleep 0.5
        firefox.execute_script("document.getElementById('contest-test-control').children[2].click()")
        sleep 1
        firefox.find_element(xpath: "//*[@id='dialog']/div[4]/button[1]").click
        sleep 2#等待对话框刷新
        @i=0
      else
        firefox.find_element(xpath: "//*[@id='#{@i/2}']").click
       # sleep 0.5
        #firefox.find_element(xpath: "//*[@id='contest-test-control']/button[2]").click
        firefox.execute_script("document.getElementById('contest-test-control').children[1].click()")
        @i+=1
      end
  end
rescue Exception => e
   yanzheng=@firefox.find_element(css: "#dialog;.component_poping_animation")
    if yanzheng==nil
        puts @firefox.current_url
        puts '出错了~'
        @firefox.close
        puts '正在重启程序~'
       system('ruby TheFile`sPATH')
    end
end
