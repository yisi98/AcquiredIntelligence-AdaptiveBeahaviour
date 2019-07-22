%CW4 Genetic ALgorithm 
%
%Yisi Liu
clear
range = 50;
size = 1;
no_pop = randperm(range,size); % generates a random number for population size between 1 to 50
repeats = 100; %number of times the entire algorithm iterates for calculating mean


currentFit = zeros(1000, 1); %stores the current fitness for 1000 generations
meanDivide = ones(1000, 1)*repeats; %for dividing by the number of repeats for working out mean



for m = 1:repeats %loop which runs the algorithm a few times for working out mean
    
    g = 100; %number of generations
    benefit = [6 19 7 1 13 17 3 18 16 20 5 15 12 11 9 2 14 4 10 8]; %Benefit
    vol = [10 5 15 18 1 17 12 19 16 4 9 20 13 7 3 2 6 11 8 14]; %Volume
    W = [];
    L = [];
    fitness = [];  %fitness
    genotype = randi([0 1], no_pop, 10); %producing a random genotype 1x10 matrix
    

    fitFunc=[]; %fitness function
    for i = 1:no_pop
    fitness(i) = fit(genotype(i,:), benefit, vol);
    end
    %fitness of entire population
    
    for i = 1:1000  %1000 generations

        p1 = randi([1 no_pop],1,1); %selects a random individual
        p2 = randsample(setdiff(1:no_pop, p1), 1); %select a second individual

        if fit(genotype(p1,:), benefit, vol)> fit(genotype(p2,:), benefit, vol) %compare fitness of two
            W = p1; %set p1 as winner
            L = p2; %set p2 as loser
        else
            W = p2; %set p2 as winner
            L = p1; %set p1 as loser
        end
        genotype(L,:) = mg(genotype(L,:)); %loser mutates from the winner

        fitness(L) = fit(genotype(L,:), benefit, vol);
        maxfit = max(fitness);
        fitFunc = [fitFunc; maxfit];
    end
currentFit = [currentFit + fitFunc];
end
meanFit = currentFit./meanDivide;
plot(meanFit), xlabel('generations'), ylabel('fitness');


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
