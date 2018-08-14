function [list_user , list_item , list_rate , list_rate_norm]= Rate_Mode_2(rating , max_rate)
list_user = rating(: , 1);
list_item = rating(: , 2);
list_rate = rating(: , 4);
list_rate_norm = (list_rate - 1) / (max_rate - 1);

