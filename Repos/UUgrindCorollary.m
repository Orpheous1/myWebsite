%Anything marked with double %% after it can be changed according to UUgrind.ahk code

%%%%%%%%%%%%%%%%%%Average time spent on system plots%%%%%%%%%%%%%%%%%%%%%%%

figure
abreakpoint = 99300; %% The breakpoint of our a in UUgrind.ahk
seed = 5; %% Our eagerness seed in UUgrind.ahk
b = 1:seed; %We set this instead of "for s = 1:seed <<code>> end" because we'll need to grab the lowest value later to get the highest line while inside the loop
Color = rand(length(b),3); %Randomize colors of the lines. We have to choose 3 for the second dimension because plot uses RGB triplets
for s = b
    M = strcat("s=",num2str(s)); %We have to feed the names of the lines as strings. A different implementation is used in the next cdf figures
    y = (1/(1-(abreakpoint/100000)))*(((10000/s)+5)/2) * 1.66666667 * 10^(-5); %Perases pi8anothtes 1 e? ;)
    xlim([0 1]); %Doesn't matter, they're all horizontal lines
    ylim([0 1.1*(1/(1-(abreakpoint/100000)))*(((10000/(min(b))+5)/2) * 1.66666667 * 10^(-5))]); %We expand the plot vertically to 110% of the height of our highest line for visibility
    yline(y, '-', M, 'color', Color(s,:));
    hold on;
end
ylabel('Average time until breaking in minutes')

%%%%%%%%%%%%%%%%%%%%%%CDF PLOTS%%%%%%%%%%%%%%%%%%%%%%
figure
astart = 99300; %%to plot various values of breakpoints set the starting point
astep = 100;    %%set the jump
astop = 99900;  %%set the stop point
%This means that with the default values it will plot 7 lines. One for 99300, one for 99300+astep=99400, one for 99300+2*astep=99500 etc until it reaches astop=99900
abreakpoint = [astart:astep:astop];  %Transform the values above into a row matrix so we can manipulate it in the for loop
Color = rand(length(abreakpoint),3);
for i=1:length(abreakpoint);
    x = [1:0.01:700];        %1 step works just as fine, it just won't be as accurate if you zoom in enough. If on a slow pc/online IDE set x = [1:400];
    y = 100 * geocdf(x,(1-(abreakpoint(i)/100000))); %Our function y=f(x) is the CDF(A8roistikh Synarthsh Katanomhs) of the various breakpoints
    txt = ['a>',num2str(abreakpoint(i))];  %We have to feed the legend titles as strings so we create the appropriate string(char in MATLAB)
    plot(x,y,'DisplayName', txt, 'color', Color(i,:))
    title('Chance of stopping over time')
    xlabel({'Number of iterations','Each iteration takes 5 ms to 10/seed sec'})
    ylabel('% Chance of stopping in the first n interations')
    hold on;
end
legend show