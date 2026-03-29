function [barELOVec, barTeamVec] = barELOFunction(app)

app.ELOBarPlot.Title.String = "";
% Get the Game Week Choice from the dropdown
gameWeek = round(app.GameWeeksSlider.Value);

% Get the Plot Type
plotType = app.TeamsDropDown.Value;

% Add a disclaimer for week 17, Bills and Bengals did not have a game
% because of Demar Hamlin
if (gameWeek == 17) && (strcmp(plotType, "All Teams") || strcmp(plotType, "AFC") || strcmp(plotType, "AFC East") || strcmp(plotType, "AFC North") )
     app.ELOBarPlot.Title.String = "NOTICE: The Bills vs Bengals game was canceled this week";
end

%  Special Game weeks
switch gameWeek
    case 19
        playoff = "(Wildcard)";
    case 20
        playoff = "(Divisional)";
    case 21
        playoff  = "(Conference)";
    case 22
        playoff = "(Superbowl)";
    otherwise
        playoff = "";
end
app.PlotDescription.Text = "Week " + gameWeek + playoff + " ELO Rating for " + plotType;

% Size of each dataset
[nRowData, ~] = size(app.NFLData);
[nRowMeta, ~] = size(app.Metadata);

% Get the ELO for a week
barTeamVec = [""];
index = 1;

% Create a Vector of the Teams included
if strcmp(plotType, "All Teams")
    for iRow = 2:nRowData
        if app.NFLData{iRow, 34} == gameWeek
            barTeamVec(index) = app.NFLData{iRow, 5};
            index = index + 1;
            barTeamVec(index) = app.NFLData{iRow, 6};
            index = index + 1;
        end
    end
    % Generate Bye Week Teams
    byeTeams = [""];
    byeindex = 1;
    for jRow = 1:nRowMeta
        if app.Metadata{jRow, 6} == gameWeek
            byeTeams(byeindex) = app.Metadata{jRow, 2};
            byeindex = byeindex + 1;
        end
    end

else
    for kRow = 1:nRowMeta
        if strcmp(plotType, app.Metadata{kRow, 3}) || strcmp(plotType, app.Metadata{kRow, 4})
            barTeamVec(index) = app.Metadata{kRow, 1};
            index = index + 1;
        end
    end
    % Generate Bye Week Teams
    byeTeams = [""];
    byeindex = 1;
    for jTeam = 1:length(barTeamVec)
        for jRow = 1:nRowMeta
            if (app.Metadata{jRow, 6} == gameWeek) && strcmp(barTeamVec(jTeam), app.Metadata{jRow, 1})
                byeTeams(byeindex) = app.Metadata{jRow, 2};
                byeindex = byeindex + 1;
            end
        end
    end
end

% Get the ELO Values for the Teams
barELOVec = zeros(1, length(barTeamVec));
ELOindex = 1;

for iTeam = 1:length(barTeamVec)
    for iRow = 2:nRowData
        if (app.NFLData{iRow, 34} == gameWeek) && (strcmp(app.NFLData{iRow, 5}, barTeamVec(iTeam) ) )
            barELOVec(ELOindex) = app.NFLData{iRow,11};
        elseif (app.NFLData{iRow, 34} == gameWeek) && (strcmp(app.NFLData{iRow, 6}, barTeamVec(iTeam) ) )
            barELOVec(ELOindex) = app.NFLData{iRow, 12};
        end
    end
    ELOindex = ELOindex + 1;
end


% Find the Average value for a given week
totalELO = 0;
numTeams = 0;
for i = 1:length(barELOVec)
    if barELOVec(i) ~= 0
        numTeams = numTeams + 1;
    end
    totalELO = totalELO + barELOVec(i);
end
averageELO = totalELO / numTeams;

if sum(barELOVec) == 0
    app.ELOBarPlot.Title.String = "No " + plotType + " Teams played this week";
end


% Display Data
app.ByesList.Items = byeTeams;

% X = categorical(barTeamVec);
% X = reordercats(X, barTeamVec);
bar(app.ELOBarPlot,barTeamVec, barELOVec);
yline(app.ELOBarPlot, averageELO, 'r-')


