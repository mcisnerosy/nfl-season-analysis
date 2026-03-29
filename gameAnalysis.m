function gameAnalysis(app)

% This function is used directly for visualization 4, in which it will plot
% the ELO ratings of the game selected from the user, along with the win
% percentages for each team to win. 


% Get number of rows of NFLData and Metadata files
[nRowData, ~] = size(app.NFLData);
[nRowMeta, ~] = size(app.Metadata);

% Initiliaze variables to hold list of weeks
listWeeks = {};

% Iterate through listWeeks and add the week number as a string
weekCount = 1;
for i = 1:22
    weekName = 'Week ' + string(weekCount);
    listWeeks{1, i} = weekName;
    weekCount = weekCount + 1;
end

% Convert listWeeks into a string array so it can be held in 
% the app.WeekDropDown.Items property
listWeeks = string(listWeeks);
app.WeekDropDown.Items = listWeeks;

% Store the user's selection of the week into a variable
weekSelection = string(app.WeekDropDown.Value);
app.WeekLabel.Text = weekSelection;

% Initialize the cell array to store the list of games corresponding to
% the selected week
listGames = {};

% Split between the white spaces of weekNumberString in order to 
% get the number from the string
weekNumberString = split(weekSelection);
weekNumberString = weekNumberString(2);

% weekNumber will hold the num version of the week number
weekNumber = str2num(weekNumberString);

% firstTeam and secondTeam will hold the full names of the teams playing
% for the user's selected week
firstTeam = "";
secondTeam = "";

% firstTeamAbriv and secondTeamAbriv will hold the abbreviations of their 
% team names for the games corresponding to the user's selected week
firstTeamAbriv = "";
secondTeamAbriv = "";

% abrivNameList will hold the list of abreviations for the team names for 
% the user's selected week
abrivNameList = {};

% countWeeks will serve as a variable to store the team abreviations and
% team names into abrivNameList 
countWeeks = 1;

% The following for loop will loop through the NFL Data file in order to
% find the team abbreviations and team names corresponding to the user's
% selected week. These abbreviations will be added in a corresponding order
% in order to help figure out the game that the user wants to plot for that
% week. 

for i = 2:nRowData
    if(weekNumber == app.NFLData{i, 34})
        firstTeamAbriv = app.NFLData{i, 5};
        secondTeamAbriv = app.NFLData{i, 6};
        abrivNameList{1, countWeeks} = string(firstTeamAbriv) + " " + string(secondTeamAbriv);
        for x = 1:nRowMeta
            if(string(firstTeamAbriv) == string(app.Metadata{x, 1}))
                firstTeam = app.Metadata{x, 2};
            end
            if(string(secondTeamAbriv) == string(app.Metadata{x, 1}))
                secondTeam = app.Metadata{x, 2};
            end
        end    
        listGames{1, countWeeks} = string(firstTeam) + " VS. " + string(secondTeam);
        countWeeks = countWeeks + 1;
    end
end

% Insert the listGames as a string into the items of the WeekGameDropDown
% dropdown
app.WeekGameDropDown.Items = string(listGames);

% indexHold will hold the index that the user's selected game will be found
% in within listGames
indexHold = 0;

% gameSelected will contain the user's game selected in the form of the
% team's abbreviations
gameSelected = app.WeekGameDropDown.Value;

% The following for loop will loop through list games and store the index
% of the game that corresponds to the user's selected game into indexHold
for i = 1:length(listGames)
    if(listGames{1, i} == string(gameSelected))
        indexHold = i;
    end
end

% listAbriv will contain the two team abreviations of the game the user
% wants to plot
listAbriv = abrivNameList{1, indexHold};
listAbriv = split(listAbriv);

% firstTeamAbriv and secondTeamAbriv will contain the abbreviations of the
% teams playing in the user's selected game
firstTeamAbriv = listAbriv(1);
secondTeamAbriv = listAbriv(2);

% The following for loop will loop through the Metadata file to extract the
% team's names corresponding to the team's abbreviations of the game
% selected. The team names will be stored in firstTeam and secondTeam
for i = 1:nRowMeta
    if(firstTeamAbriv == app.Metadata{i, 1})
        firstTeam = app.Metadata{i, 2};
    end
    if(secondTeamAbriv == app.Metadata{i, 1})
        secondTeam = app.Metadata{i, 2};
    end
end

% xaxisLabels will hold the x axis values for the bar graphs being ploted
xaxisLabels = ["ELO Rating Before (Team)", "ELO Rating After (Team)", "ELO Rating Before (QB)", "ELO Rating After (QB)"];

% indexNumber will hold the index value of the eloNumbers and eloNumbers2
% lists that will be initialized and hold the values corresponding to the
% x-axis values
indexNumber = 1;

% eloNumbers and eloNumbers2 will hold the ELO values corresponding to the
% user's selected game

eloNumbers = [];
eloNumbers2 = [];

% percentage1 and percentage2 will hold the winning percentages prior to
% the game selected for each team
percentage1 = 0;
percentage2 = 0;

% team1result and team2result will hold the result each team held following
% the game, such as a win, loss, or draw
team1result = "";
team2result = "";

% score1 and score2 will hold the teams points for the game being plotted
score1 = 0;
score2 = 0;

% The following for loop will loop through the NFLData file to determine
% which abbreviations and week numbers correspond to the correct row in the
% NFL data file. When found, the eloNumbers and eloNumbers2 lists will be
% filled with the ELO ratings while the indexNumber gets iterated in order
% to place then in the correct index positions. Along with that, the
% results will be determined based on the score comparisions that will be
% made with if-elseif statements. 
for i = 1:nRowData
    if(string(firstTeamAbriv) == string(app.NFLData{i, 5})) && (string(secondTeamAbriv) == string(app.NFLData{i, 6})) && (string(weekNumberString) == string(app.NFLData{i, 34}))
         eloNumbers(1, indexNumber) = app.NFLData{i, 7};
         eloNumbers2(1, indexNumber) = app.NFLData{i, 8};
         indexNumber = indexNumber + 1;
         eloNumbers(1, indexNumber) = app.NFLData{i, 11};
         eloNumbers2(1, indexNumber) = app.NFLData{i, 12};
         indexNumber = indexNumber + 1;
         eloNumbers(1, indexNumber) = app.NFLData{i, 13};
         eloNumbers2(1, indexNumber) = app.NFLData{i, 14};
         indexNumber = indexNumber + 1;
         eloNumbers(1, indexNumber) = app.NFLData{i, 27};
         eloNumbers2(1, indexNumber) = app.NFLData{i, 28};
         percentage1 = app.NFLData{i, 9};
         percentage2 = app.NFLData{i, 10};
         score1 = app.NFLData{i, 29};
         score2 = app.NFLData{i, 30};
         if(app.NFLData{i, 29} > app.NFLData{i, 30})
             team1result = "WIN";
             team2result = "LOSS";
         elseif(app.NFLData{i, 29} < app.NFLData{i, 30})
             team1result = "LOSS";
             team2result = "WIN";
         else
             team1result = "DRAW";
             team2result = "DRAW";
         end
    end
end

% A bar chart will be ploted into the Team1GameAxes and Team2GameAxes with
% the xaxisLabels as the x-axis and the eloNumbers and eloNumbers2 lists as
% the y-axis 
bar(app.Team1GameAxes, xaxisLabels, eloNumbers)
bar(app.Team2GameAxes, xaxisLabels, eloNumbers2)

% Titles of the bar charts will be changed to correspond to the names of
% the teams playing with the variables firstTeam and secondTeam
title(app.Team1GameAxes, firstTeam)
title(app.Team2GameAxes, secondTeam)

% y-axis limit values are set in order for user's to see a difference in
% the bar graph
ylim(app.Team1GameAxes, [1250 1800])
ylim(app.Team2GameAxes, [1250 1800])

% A pie chart is ploted on the PieChartAxes with the team percentages of
% winning the game
pie(app.PieChartAxes, [percentage1 percentage2])

% The pie chart is titled
title(app.PieChartAxes, "Win Percentages Prior to Game")

% A legend is created for the pie chart
legend(app.PieChartAxes, firstTeam, secondTeam, "Location", "Southeast")

% firstTeam and secondTeam variables are added with a semi-colon to clearly
% portray the result of the game
firstTeam = firstTeam + ":";
secondTeam = secondTeam + ":";

% Team1NameLabel and Team2NameLabel are changed to correspond to the teams
% playing in the game
app.Team1NameLabel.Text = firstTeam;
app.Team2NameLabelSingleGame.Text = secondTeam;

% Result1Label and Result2Label are changed to correspond to the result of
% the game for each team
app.Result1Label.Text = num2str(score1) + " (" + team1result + ")";
app.Result2Label.Text = num2str(score2) + " (" + team2result + ")";



