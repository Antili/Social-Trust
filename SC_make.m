function [SC] = SC_make(S , C ,  num_user , beta)

SC = cell(num_user , 1);
for i = 1 : num_user
    if max(size(S{i})) > 0
        SC{i} = beta * S{i} + (1 - beta) * C{i};
    end
end
