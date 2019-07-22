%CW6 Genetic ALgorithm 
%WARNING VERY LONG TIME TO RUN
%Yisi Liu
clear;
%range = 50;
%size = 1;
%no_pop = randperm(range,size) % generates a random number for population size between 1 to 50
no_pop = 100;


%fitness = fit(genotype);  %fitness

pc = 0.5; % Probability crossover
k=2;


range1= -4;
range2= 4;
genotype = (range2-range1).*rand(no_pop, 6) + range1; %generate random value between -4 and +4 for genotype 
g = 100; %number of generations
pmutate = 1.0/6;%probability of mutation
W = [];
L = [];
fitFunc=[];
fitness = [];  %fitness
    
    for i = 1:no_pop
    fitness(i) = fit(genotype(i,:));
    end
%fitness of entire population
for i = 1:1000  %100 generations
        genotype(:,1)=0; %set first gene as zero 
        genotype(:,2)=0; %set second gene as zero 
        p1 = (randi([1 no_pop],1,1)); %picks p1 from population
        p2 = randsample(setdiff(p1:p1+k, p1), 1); %pick p2 within range of p1+k
        if p2 > no_pop
            p2 = p2-no_pop;  %wrap around, if p2 is greater than total population then start from 1
        end
        if fitness(p1)> fitness(p2)
            W = p1;
            L = p2;
        else
            W = p2;
            L = p1;
        end
        for x = 1:6
            if rand(1) < pc 
                genotype(L,x) = genotype(W,x);
            end
            if rand(1) < pmutate
                 
               random = randn*8/100;
               genotype(L,x) = genotype(L,x) + random;
                if genotype(L,x) > 4  %check if it is in range
                    genotype(L,x) = 4; %if exceeding range then make it 4
                end
                if genotype(L,x) < -4
                    genotype(L,x) = -4;
                end
             end
        end

    
    fitness(L) = fit(genotype(L,:)); %reevaluate fitness of loser
  
    maxfit = max(fitness); %get maximum fitness
    [M,I] = max(fitness);
    bestgenotype = genotype(I, :)
    fitFunc = [fitFunc; maxfit];
end

figure;
plot(fitFunc), xlabel('generations'), ylabel('fitness');
figure;
simple_agent(100,[1; 1],90,bestgenotype,true);

function fitness = fit(genotype)
%bearing = randi([0 360]); %generate a random bearing between 0 and 360
pos = simple_agent(100,[1; 1],90,genotype,true);
sum = 0;
T = size(pos,2);
for time = 1:T
    x= pos(1,T);
    y= pos(2,T);
    current = sqrt(x*x+y*y);
    sum = sum + current;
end    
fitness = sum*-1;
end

function mutation = mg(genotype)
    r = randi([1 6],1); %choosing random number betwen 1 to 6
    mutation = genotype; %make a new variable copy of the genotype
    random = randn*8/100;
    mutation(r) = mutation(r) + random;
    if mutation(r) > 4  %check if it is in range
        mutation(r) = 4; %if exceeding range then make it 4
    end
    if mutation(r) < -4
        mutation(r) = -4;
    end
end   
