function [learn_list_user_R , check_list_user_R , learn_list_item , check_list_item ,...
    learn_list_rate , check_list_rate , learn_list_rate_norm , check_list_rate_norm] = learning_select (list_user_R , list_item , list_rate , list_rate_norm , learn_perc)
[N , ~] = size(list_user_R);
N_learn = fix (N * learn_perc);

learn_index = randperm(N , N_learn);
learn_index = sort(learn_index);

ii = 1;
learn_i = learn_index(ii);
check_index = [];
for i = 1 : N
    if i ~= learn_i
        check_index = cat(1 , check_index , i);
    else
        ii = ii + 1;
        if ii <= N_learn
            learn_i = learn_index(ii);
        end
    end
end


learn_list_user_R = list_user_R(learn_index);
check_list_user_R = list_user_R(check_index);

learn_list_item = list_item(learn_index);
check_list_item = list_item(check_index);

learn_list_rate = list_rate(learn_index);
check_list_rate = list_rate(check_index);

learn_list_rate_norm = list_rate_norm(learn_index);
check_list_rate_norm = list_rate_norm(check_index);



