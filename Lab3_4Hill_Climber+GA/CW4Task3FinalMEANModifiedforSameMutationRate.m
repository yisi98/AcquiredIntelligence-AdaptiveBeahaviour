%CW4 Genetic ALgorithm 
%
%Yisi Liu
clear
%range = 50;
%size = 1;
%no_pop = randperm(range,size); % generates a random number for population size between 1 to 50
no_pop = 50;
repeats = 100; %number of repeats for working out average
k=2; %size of local neighbourhood
pc = 1; % Probability crossover



currentFit = zeros(1000, 1); %stores the current fitness of each generation
meanDivide = ones(1000, 1)*repeats; %divide total fitness with number of repeats to work out mean

for m = 1:repeats %repeats a number of times for working out mean

    g = 100; %number of generations
    benefit = [6 19 7 1 13 17 3 18 16 20 5 15 12 11 9 2 14 4 10 8]; %benefit
    vol = [10 5 15 18 1 17 12 19 16 4 9 20 13 7 3 2 6 11 8 14]; %Volume
    W = [];
    L = [];
    fitFunc=[];
    fitness = [];  %fitness
    genotype = randi([0 1], no_pop, 10); %producing a random genotype 1x10 matrix
   
    
    for i = 1:no_pop
    fitness(i) = fit(genotype(i,:), benefit, vol);
    end
    %fitness of entire population
    for i = 1:1000  %100 generations

        p1 = (randi([1 no_pop],1,1)); %picks p1 from population
        p2 = randsample(setdiff(p1:p1+k, p1), 1); %pick p2 within range of p1+k
        if p2 > no_pop
            p2 = p2-no_pop;  %wrap around, if p2 is greater than total population then start from 1
        end
        if fit(genotype(p1,:), benefit, vol)> fit(genotype(p2,:), benefit, vol) %compare fitness
            W = p1;
            L = p2;
        else
            W = p2;
            L = p1;
        end
        for x = 1:10 %going through all genes
            if rand(1) < pc %check if random number is smaller than PCrossover
                genotype(L,x) = genotype(W,x); %Copy over genotype from winner to loser
            end
        end
         


        genotype(L,:) = mg(genotype(L,:)); %add a mutation to Loser

        fitness(L) = fit(genotype(L,:), benefit, vol); %reevaluating loser fitness
        maxfit = max(fitness); %obtaining the maximum fitness
        fitFunc = [fitFunc; maxfit];
    end
currentFit = [currentFit + fitFunc];
end
meanFit = currentFit./meanDivide; %working out mean
plot(meanFit), xlabel('generations'), ylabel('fitness'); %plots the graph for mean fitness


function mutation = mg(genotype)
    r = randi([1 10],1); %choosing random number betwen 1 to 10
    mutation = genotype; %make a new variable copy of the genotype
    if genotype(r) == 0  %checks if the index value is 0
        mutation(r) = 1; %if zero update the value to 1 in mutation variable
    else
        mutation(r) = 0; %otherwise update zero if value in index was 1
    end
    
end   

function fitness = fit(g, benefit, vol)
    cap = 50;  %capacity of 20
    if cap > sum(vol(g==1))   %if the total volume doesn't exceed capacity
        fitness = sum(benefit(g==1));%then store in fitness
    else
        fitness = 0; %otherwise fitness is zero
    end
end
