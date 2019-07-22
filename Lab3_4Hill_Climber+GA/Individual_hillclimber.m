%CW3 Genetic algorithms
%Yisi Liu
g = 100; %number of generations
benefit = [5 6 1 9 2 8 4 3 7 10]; %benefit 
vol = [3 2 4 5 8 9 10 1 6 7]; %Volume
fitness = [];  %fitness
genotype = randi([0 1], 1, 10); %producing a random genotype 1x10 matrix

for i = 1:100  %100 generations
    
    mutated_g = mg(genotype);
    if fit(mutated_g, benefit, vol) > fit(genotype, benefit, vol)
        genotype = mutated_g;
    end
    ff = [ fit(genotype, benefit, vol)];
    fitness = [fitness; ff];
end

plot(fitness), xlabel('generations'), ylabel('fitness');


function fitness = fit(g, benefit, vol)
    cap = 20;  %capacity of 20
    if cap > sum(vol(g==1))   %if the total volume doesn't exceed capacity
        fitness = sum(benefit(g==1));%then store in fitness
    else
        fitness = 0; %otherwise fitness is zero
    end
end

function mutation = mg(genotype)
    r = randi([1 10],1); %choosing random number betwen 1 to 10
    mutation = genotype; %make a new variable copy of the genotype
    if genotype(r) == 0  %checks if the index value is 0
        mutation(r) = 1 %if zero update the value to 1 in mutation variable
    else
        mutation(r) = 0 %otherwise update zero if value in index was 1
    end
    
end   


