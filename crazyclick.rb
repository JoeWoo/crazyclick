require "selenium-webdriver"

firefox = Selenium::WebDriver.for :ff

firefox.get "http://learn.swcontest.net/home/noframe"
#等待js执行结束
sleep 3
#填充登录信息
username_input = firefox.find_element(css: '#user-login-name')
username_input.send_keys "username"
password_input = firefox.find_element(css: '#user-login-password')
password_input.send_keys "password"
#确定登录
submit_button=firefox.find_element(xpath: "//*[@id='user-login-section']/ul/li[3]/button")
submit_button.click

#等待页面刷新
sleep 2
#选定题目�?questionset= firefox.find_element(xpath: "//*[@id='contest-lib-dir-1']/a")
questionset.click
#开始答�?@i=0
while(true) do
    sleep 1
    if (@i==4)#�?题提交一�?      firefox.find_element(xpath: "//*[@id='0']").click
      sleep 0.2
      firefox.find_element(xpath: "//*[@id='contest-test-control']/button[3]").click
      sleep 2
      firefox.find_element(xpath: "//*[@id='dialog']/div[4]/button[1]").click
      sleep 1#等待对话框刷�?      @i=0
    else
      firefox.find_element(xpath: "//*[@id='0']").click
      sleep 0.2
      firefox.find_element(xpath: "//*[@id='contest-test-control']/button[2]").click
      @i+=1
    end
    puts firefox.current_url
end
