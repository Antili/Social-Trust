function [min_E_test , steps , U , V] = Fact(list_user_R  , list_item  , list_rate_norm ,trust_to_list , trust_in_list, S_to , S_in , alfa , num_user, num_item , L)

step_size = -0.05;

LambdaU = 0.001;
LambdaV = 0.001;

N = num_item;
M = num_user;

%[M , N] = size(R);

U = ones(L , M);
V = ones(L , N);

[num_R , ~] =  size(list_user_R);

min_E_test = 10;
step = 0;
steps = 10;
while step <= steps

    T_U = transpose(U);
    step = step + 1;
    Lap = 0;
    
    dV = zeros(L , N);
    dU = zeros(L , M);
    
    
    for r = 1 : num_R
        i = list_user_R(r);
        j = list_item(r);
        
        V_j = V(: , j);
        T_U_i = T_U(i , :);
        U_i = U(: , i);
        R_r = list_rate_norm(r);
        
        UV = T_U_i * V_j;
        
        temp_trust_to = trust_to_list{i};
        temp_S_to = S_to{i};
        [N_p , ~] = size(temp_trust_to);
        
        SUV = 0;
        SU = zeros(L , 1);
        
        for p = 1 : N_p
            temp_S = temp_S_to(p , 1);
            k = temp_trust_to(p , 1);
            temp_UVK = T_U(k , :) * V_j;
            temp_UVK = temp_S * temp_UVK;
            SUV = SUV + temp_UVK;
            
            SU = SU + temp_S * U(: , k);
        end
        
        temp_E = alfa * UV + (1 - alfa) * SUV;
        dg_temp_E = dg(temp_E);
        g_temp_E = g(temp_E);
        dV(: , j) = dV(: , j) + dg_temp_E * (g_temp_E - R_r) * (alfa * U_i + (1 - alfa) * SU);
        dU(: , i) = dU(: , i) + alfa * dg_temp_E * V_j * (g_temp_E - R_r);
        
        temp_EE = (1 - alfa) * dg_temp_E * (g_temp_E - R_r) * V_j;
        
        temp_trust_in = trust_in_list{i};
        temp_S_in = S_in{i};
        [N_c , ~] = size(temp_trust_in);
        for c = 1 : N_c
            p = temp_trust_in(c , 1);
            dU(: , p) = dU(: , p) + temp_S_in(c , 1) * temp_EE;
        end
        Lap = Lap + 0.5  * (g(temp_E) - R_r) ^ 2;
    end
    dV = dV + LambdaV * V;
    dU = dU + LambdaU * U;
    
    U = U + step_size * dU;
    V = V + step_size * dV;
    %     Lap = Lap +  0.5 * LambdaU * norm(U,'fro') +  0.5 * LambdaV * norm(V,'fro');
    %     E_all = rate_performace(U , V ,alfa, trust_to_list , S ,  list_user_R , list_item , list_rate_norm);

    E_test = rate_performace(U , V ,alfa, trust_to_list , S_to ,  list_user_R , list_item , list_rate_norm);

    if  E_test < min_E_test
        min_E_test = E_test;
        steps = step + 10;
    end
    
    disp([step min_E_test E_test steps])
end

function E = rate_performace(U , V , alfa, trust_to_list, S_to ,  list_user_R , list_item , list_rate_norm)
E = 0;
[num_R , ~] =  size(list_user_R);
T_U = transpose(U);

for r = 1 : num_R
    i = list_user_R(r);
    j = list_item(r);
    
    V_j = V(: , j);
    T_U_i = T_U(i , :);
    R_r = list_rate_norm(r);
    
    UV = T_U_i * V_j;
    
    temp_trust_to = trust_to_list{i};
    temp_S_to = S_to{i};
    [N_p , ~] = size(temp_trust_to);
    
    SUV = 0;
    for p = 1 : N_p
        temp_S = temp_S_to(p , 1);
        k = temp_trust_to(p , 1);
        temp_UVK = T_U(k , :) * V_j;
        temp_UVK = temp_S * temp_UVK;
        SUV = SUV + temp_UVK;
    end
    
    temp_E = alfa * UV + (1 - alfa) * SUV;
    E = E + abs(g(temp_E) - R_r);
    
end

E = (E / num_R) * 4;


function y = g(x)
y = 1 ./ (1 + exp(-x));

function y = dg(x)
y = exp(x) ./ (1 + exp(x)) .^ 2;