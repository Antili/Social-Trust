function [S] = S_make(sim ,  num_user)
S = cell(num_user , 1);
for i = 1 : num_user
    if max(size(sim{i})) > 0
        sum_sim = sum(sim{i}(: , 1));
        if sum_sim > 0
            S{i}(: , 1) = sim{i}(: , 1) / sum_sim;
        else
            S{i}(: , 1) = sim{i}(: , 1);
        end
    end
end