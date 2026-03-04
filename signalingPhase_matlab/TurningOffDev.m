demand(1) = cumulative;
for i=1:time_lapse
    for j=1:X
        if (measuring_time(i)== Agent(2,j))&&(VecSkips(j)==0);
           cumulative = cumulative - Agent(1,j);
        end
    end
    if cumulative<0
        cumulative=0;
    end
    demand(i+1) = cumulative;
end
SecretSize = length(secret);
demandSize = length(demand);
secret(SecretSize+1:SecretSize+demandSize)= demand(:);