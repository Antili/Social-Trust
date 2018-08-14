function sim = similarity(trust_to_list , rate_item_list , num_user , option)
if strcmp(option , 'unity') == 1
    sim = cell(num_user , 1);
    for i = 1 : num_user
        [num_conn , ~] = size(trust_to_list{i});
        for c_j = 1 : num_conn
            sim{i}(c_j , 1) = 1;
        end
    end
elseif strcmp(option , 'PCC') == 1
    sim = cell(num_user , 1);
    for i = 1 : num_user
        [num_conn , ~] = size(trust_to_list{i});
        for c_j = 1 : num_conn
            sum_1 = 0;
            sum_2 = 0;
            sum_3 = 0;
            j = trust_to_list{i}(c_j);
            item_com = intersect(rate_item_list{i}(: , 1) , rate_item_list{j}(: , 1));
            [N_item , ~] = size(item_com);
            if min(size(item_com)) > 0
                for k = 1 : N_item
                    R_1 = rate_item_list{i}(rate_item_list{i}(: , 1) == item_com(k ,1) , 2);
                    R_1 = mean(R_1);
                    R_2 = rate_item_list{j}(rate_item_list{j}(: , 1) == item_com(k ,1) , 2);
                    R_2 = mean(R_2);
                    sum_1 = sum_1 + R_1 * R_2;
                    sum_2 = sum_2 + R_1 ^ 2;
                    sum_3 = sum_3 + R_2 ^ 2;
                end
                sim{i}(c_j , 1) = sum_1 / (sum_2 ^ 0.5 * sum_3 ^ 0.5);
            else
                sim{i}(c_j , 1) = 0;
            end
        end
    end
elseif strcmp(option , 'VSS') == 1
    ave_R = zeros(num_user , 1);
    for i = 1 : num_user
        ave_R(i , 1) = mean(rate_item_list{i}(: , 1));
    end
    
    sim = cell(num_user , 1);
    for i = 1 : num_user
        [num_conn , ~] = size(trust_to_list{i});
        for c_j = 1 : num_conn
            sum_1 = 0;
            sum_2 = 0;
            sum_3 = 0;
            j = trust_to_list{i}(c_j);
            item_com = intersect(rate_item_list{i}(: , 1) , rate_item_list{j}(: , 1));
            [N_item , ~] = size(item_com);
            if min(size(item_com)) > 0
                for k = 1 : N_item
                    R_1 = rate_item_list{i}(rate_item_list{i}(: , 1) == item_com(k ,1) , 2);
                    R_1 = mean(R_1);
                    R_2 = rate_item_list{j}(rate_item_list{j}(: , 1) == item_com(k ,1) , 2);
                    R_2 = mean(R_2);
                    sum_1 = sum_1 + (R_1 - ave_R(i , 1)) * (R_2 - ave_R(j , 1));
                    sum_2 = sum_2 + (R_1 - ave_R(i , 1)) ^ 2;
                    sum_3 = sum_3 + (R_2 - ave_R(j , 1)) ^ 2;
                end
                sim{i}(c_j , 1) = sum_1 / (sum_2 ^ 0.5 * sum_3 ^ 0.5);
            else
                sim{i}(c_j , 1) = 0;
            end
        end
    end
elseif strcmp(option , 'CON') == 1
    sim = cell(num_user , 1);
    for i = 1 : num_user
        [num_conn , ~] = size(trust_to_list{i});
        for c_j = 1 : num_conn
            conn_com = intersect(trust_to_list{i} , trust_to_list{c_j});
            [num_conn_o , ~] = size(conn_com);
            if min(size(conn_com)) > 0
                sim{i}(c_j , 1) = num_conn_o / num_conn;
            else
                sim{i}(c_j , 1) = 0;
            end
        end
    end
    
end

