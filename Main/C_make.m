function [C] = C_make(trust_to_list , Cent ,  num_user)
C = cell(num_user , 1);
for i = 1 : num_user
    sum_Cent = sum(Cent(1 , trust_to_list{i}));
    if sum_Cent > 0
        C{i}(: , 1) = Cent(1 , trust_to_list{i}) / sum_Cent;
    else
        C{i}(: , 1) = Cent(1 , trust_to_list{i}) ;
    end
end