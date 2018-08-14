function [rate_item_list , rate_list] = rating_list_make(list_user_R ,  list_item , list_rate, num_user)
rate_item_list = cell(num_user , 1);
rate_list = cell(num_user , 1);

for u = 1 : num_user
    rate_item_list{u}(: , 1) = list_item(list_user_R(: , 1) == u , 1);
    rate_item_list{u}(: , 2) = list_rate(list_user_R(: , 1) == u , 1);
end