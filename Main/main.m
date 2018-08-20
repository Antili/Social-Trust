E = zeros(5 , 1);
Alfa = zeros(5 , 1);
Beta = zeros(5 , 1);

L = 4;

num_user = max(max(trust));
num_item = max(rating(: , 2));

[list_user_R , list_item , list_rate , list_rate_norm] = Rate_Mode(rating , 5);

[trust_to_list , trust_in_list] = trust_list_make(trust , num_user);
[rate_item_list] = rating_list_make(list_user_R ,  list_item , list_rate, num_user);

% Methods: 'unity' , 'PCC' , 'VSS' , and 'CON'
[sim_to] = similarity(trust_to_list , rate_item_list , num_user, 'CON');
[S_to] = S_make(sim_to ,  num_user);

[sim_in] = similarity(trust_in_list , rate_item_list , num_user , 'CON');
[S_in] = S_make(sim_in ,  num_user);

% Methods: 'unity' , 'deg' , 'eigen' , 'katz' with parameter a and b, 'page' with parameter a and b
[Cent] = Centrality(num_user , trust_in_list , 'page' , 1 , 0);
[C_to] = C_make(trust_to_list , Cent ,  num_user);
[C_in] = C_make(trust_in_list , Cent ,  num_user);

i = 0;
for alfa = 0 : 0.25 : 1
    for beta = 0 : 0.25 : 1
        i = i + 1;
        disp([alfa beta]);
            
        [SC_to] = SC_make(S_to , C_to ,  num_user , beta);
        [SC_in] = SC_make(S_in , C_in ,  num_user , beta);
            
        [test_E , steps , U , V] = Fact(list_user_R, list_item , list_rate_norm , trust_to_list , trust_in_list, SC_to , SC_in , alfa , num_user, num_item,  L);
            
		 E(i , 1) = test_E;
         Alfa(i , 1) = alfa;
         Beta(i , 1) = beta;
            
         disp([alfa  beta test_E steps]);
            
          save('output.mat');
     end
end

