function [Cent_new] = Centrality(num_user , trust_in_list, Method , a , b)
if strcmp(Method , 'unity')
    Cent_new = ones(1 , num_user);
elseif strcmp(Method , 'deg')
    Cent_new = ones(1 , num_user);
    for i = 1 : num_user
        Cent_new(1 , i) = sum(Cent_new(1 , trust_in_list{i}));
    end
    Cent_new = Cent_new ./ max(Cent_new);
elseif strcmp(Method , 'eigen')
    Cent_old = ones(1 , num_user);
    Cent_new = ones(1 , num_user);
    for it = 1 : 10
        for i = 1 : num_user
            Cent_new(1 , i) = sum(Cent_old(1 , trust_in_list{i}));
        end
        Cent_new = Cent_new ./ max(Cent_new);
        Cent_old = Cent_new;
    end
    
elseif strcmp(Method , 'katz')
    Cent_old = ones(1 , num_user);
    Cent_new = ones(1 , num_user);
    for it = 1 : 10
        for i = 1 : num_user
            Cent_new(1 , i) = a * sum(Cent_old(1 , trust_in_list{i})) + b;
        end
        Cent_new = Cent_new ./ max(Cent_new);
        Cent_old = Cent_new;
    end
    
elseif strcmp(Method , 'page')
    Cent_old = ones(1 , num_user);
    Cent_new = ones(1 , num_user);
    outdeg = ones(1 , num_user);
    for i = 1 : num_user
        outdeg(1 , i) = size(trust_in_list{i} , 1) + 1;
    end
    for it = 1 : 10
        for i = 1 : num_user
            Cent_new(1 , i) = a * sum(Cent_old(1 , trust_in_list{i}) ./ outdeg(1 , trust_in_list{i})) + b;
        end
        Cent_new = Cent_new ./ max(Cent_new);
        Cent_old = Cent_new;
    end
end
