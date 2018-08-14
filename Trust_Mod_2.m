function [list_user_1 , list_user_2 , list_trust, list_trust_norm] = Trust_Mod_2(trust)

trust_matrix = sparse(trust(: , 1) , trust(: , 2) , 1);

in_deg = full(sum(trust_matrix>0));
out_deg = full(sum(transpose(trust_matrix>0)));

list_user_1 = trust(: , 1);
list_user_2 = trust(: , 2);
[U , ~] = size(list_user_2);
list_trust = ones(U , 1);

list_trust_norm = list_trust .* transpose((in_deg(list_user_2) ./ (in_deg(list_user_2) + out_deg(list_user_1))) .^ 0.5);
