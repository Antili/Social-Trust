function [trust_in_list , trust_to_list] = trust_list_make(trust , num_user)
trust_in_list = cell(num_user , 1);
trust_to_list = cell(num_user , 1);

for u = 1 : num_user
    trust_in_list{u} = trust(trust(: , 2) == u , 1);
    trust_to_list{u} = trust(trust(: , 1) == u , 2);
end
