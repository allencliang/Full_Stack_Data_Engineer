library(rvest)
library(stringr)
basicURL <- "http://shenzhen.qfang.com/garden"


WebSpider <- function(m){
  url <- str_c(basicURL,"/n",m)
  
  web <- read_html(url,encoding = "UTF-8")
  write
  name <- web %>% html_nodes("p.house-title")  %>%  html_text() #��ȡС����
  
  num_sale <- web %>% html_nodes("p.garden-houses.clearfix")  %>% html_text() 
  #��ȡ����ʱ�䣬��ҳ�����в㼶��ϵadderess��clearfix�пո���ô����Ӣ��С����Ŵ��棬��������
  
  num_sale <- num_sale  %>% str_extract("[0-9]+") %>% as.numeric()

  #str_extract()Ϊstringr��������[0-9]+ Ϊ�������ʽ����ʾ���ƥ�䲢��ȡ����
  
  address <- web %>% html_nodes("p.garden-address.text.clearfix span") %>% html_text()#С����ַ
  

  #�ϲ������ݿ�
  data.frame(name,num_sale,address)
}

results <- data.frame()
for(m in 1:78){ #78ΪС����Ϣ����ҳ�� 
  results <- rbind(results,WebSpider(m))#�ϲ�ÿһ��ѭ�����������
  
}

write.csv(results, file = 'data/house.csv', row.names = F)