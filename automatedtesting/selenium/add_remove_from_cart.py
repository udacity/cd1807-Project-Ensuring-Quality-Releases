# #!/usr/bin/env python
from selenium import webdriver
from selenium.webdriver.chrome.options import Options as ChromeOptions

# Start the browser and navigate to webpage
driver = webdriver.Chrome()
driver.get('http://wswebapplication-appservice.azurewebsites.net')
