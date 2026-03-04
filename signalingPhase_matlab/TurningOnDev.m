demand(1)=cumulative;
secret(1)= 0;
for i=1:time_lapse
    for j=1:X
        if (measuring_time(i)== Agent(2,j))&&(VecSkips(j)==0);
           cumulative = cumulative + Agent(1,j);
        end
    end
    demand(i+1) = cumulative;
end
if length(secret)==1
    secret= demand;
else
    SecretSize = length(secret);
    demandSize = length(demand);
    secret(SecretSize+1:SecretSize+demandSize)= demand(:);
end
