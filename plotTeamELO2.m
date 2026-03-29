function plotTeamELO2(app)
%% Section 1: Prelimanary Data
[nRowData, ~] = size(app.NFLData);
[nRowMeta, ~] = size(app.Metadata);

% Get the Values for each team
teamChoice{1} = app.teamDropDown.Value;
teamChoice{2} = app.team2DropDown.Value;
app.TeamNameLabel.Text = teamChoice{1};
app.Team2NameLabel.Text = teamChoice{2};

% Set the Schedule Title
app.Team1ScheduleTab.Title = teamChoice{1} + " Season Schedule";

% Get the number of teams
teamNumChoice = app.TeamButtonGroup.SelectedObject.Text;
if strcmp(teamNumChoice, "Two Teams") % If the user selected to show two teams
    numTeams = 2; % Controls how many teams to find data for
    app.Team2ScheduleTab.Title = teamChoice{2} + " Season Schedule"; % Add a title to the schedule table
else
    numTeams = 1;
    app.Team2ScheduleTab.Title = " ";
end

% Cell Arrays for each teams Data, formatted as such { Team 1 Data, Team 2 Data}
scheduleData = {{}, {}}; % Holds the schedule data 
ELOValues = {[], []}; % Team ELO Values
QB_ELOValues = {[], []}; % QB ELO Values

for iSelectedTeam = 1:numTeams
    %% Section 2: Get the Team Codes and Logo File Names from the Metadata
    for iRow = 1:nRowMeta
        if strcmp(teamChoice{iSelectedTeam}, app.Metadata{iRow, 2})
            teamCode{iSelectedTeam} = app.Metadata{iRow, 1};
            teamLogo{iSelectedTeam} = app.Metadata{iRow, 5};
        end
    end

    %% Section 3: Get the ELO values and Schedule Data for each team
    
    gameNotFoundCount = 0; % Shows how many weeks have gone by without a game, if this goes past 2, then the season is over.
    for iWeek = 1:24 % Finds games through weeks 1-22, (24 is needed for teams that played up to the superbowl)
        gameFound = false; % Shows whether or not the function found a game for a given week
        gameNotFoundCount = gameNotFoundCount + 1; % Keeps track of how many games how not been found

        for iRow = 2:nRowData
            if iWeek == app.NFLData{iRow, 34} % Finds the data for a specific week
                if strcmp(teamCode{iSelectedTeam}, app.NFLData{iRow, 5}) % Finds the data for a specific team
                    % Get the ELO Values for the team and QB
                    ELOValues{iSelectedTeam}(iWeek) = app.NFLData{iRow, 7};
                    QB_ELOValues{iSelectedTeam}(iWeek) = app.NFLData{iRow, 13};
                    % Post game ELO that are used for BYE Weeks
                    postTeamELO = app.NFLData{iRow, 11};
                    postQBELO = app.NFLData{iRow, 27};
                    % Add Values to the Schedule Table
                    scheduleData{iSelectedTeam}{iWeek, 1} = iWeek;
                    scheduleData{iSelectedTeam}{iWeek, 2} = char(app.NFLData{iRow, 1});
                    scheduleData{iSelectedTeam}{iWeek, 3} = app.NFLData{iRow, 15};
                    % Finding who they played against
                    opponentCode = app.NFLData{iRow, 6};
                    for iRowMeta = 1:nRowMeta % With the opponentCode, look through the metadata for the full team name
                        if strcmp(opponentCode, app.Metadata{iRowMeta, 1})
                            scheduleData{iSelectedTeam}{iWeek, 4} = app.Metadata{iRowMeta, 2};
                        end
                    end
                    % Check who won
                    if app.NFLData{iRow, 29} > app.NFLData{iRow, 30}
                        scheduleData{iSelectedTeam}{iWeek, 5} = 'WIN';
                    else
                        scheduleData{iSelectedTeam}{iWeek, 5} = 'LOSS';
                    end
                    gameFound = true;
                    gameNotFoundCount = 0;
                elseif strcmp(teamCode{iSelectedTeam}, app.NFLData{iRow, 6}) % If the data is from the desired team, same as previous section
                    ELOValues{iSelectedTeam}(iWeek) = app.NFLData{iRow, 8};
                    QB_ELOValues{iSelectedTeam}(iWeek) = app.NFLData{iRow, 14};
                    % Post game ELO that are used for BYE Weeks
                    postTeamELO = app.NFLData{iRow, 12};
                    postQBELO = app.NFLData{iRow, 28};
                    % Add Values to the Schedule Table
                    scheduleData{iSelectedTeam}{iWeek, 1} = iWeek;
                    scheduleData{iSelectedTeam}{iWeek, 2} = app.NFLData{iRow, 1};
                    scheduleData{iSelectedTeam}{iWeek, 3} = app.NFLData{iRow, 16};
                    opponentCode = app.NFLData{iRow, 5};
                    for iRowMeta = 1:nRowMeta
                        if strcmp(opponentCode, app.Metadata{iRowMeta, 1})
                            scheduleData{iSelectedTeam}{iWeek, 4} = app.Metadata{iRowMeta, 2};
                        end
                    end
                    % Check who won
                    if app.NFLData{iRow, 30} > app.NFLData{iRow, 29}
                        scheduleData{iSelectedTeam}{iWeek, 5} = 'WIN';
                    else
                        scheduleData{iSelectedTeam}{iWeek, 5} = 'LOSS';
                    end
                    gameFound = true;
                    gameNotFoundCount = 0;
                end
            end
        end
        if (~gameFound) && ~(gameNotFoundCount >= 2) % If no game is found (BYE Week or cancellation), the ELO is the previous values
            ELOValues{iSelectedTeam}(iWeek) = postTeamELO;
            QB_ELOValues{iSelectedTeam}(iWeek) = postQBELO;
            % Add Values to the Schedule Table, in this case there are no
            % values to add
            scheduleData{iSelectedTeam}{iWeek, 1} = iWeek;
            scheduleData{iSelectedTeam}{iWeek, 2} = 'No Game Played';
            scheduleData{iSelectedTeam}{iWeek, 3} = 'N/A';
            scheduleData{iSelectedTeam}{iWeek, 4} = 'N/A';
            scheduleData{iSelectedTeam}{iWeek, 5} = 'N/A';
        elseif (~gameFound) && (gameNotFoundCount == 2) % if there are two games not found in a row, the season is over
            % Delete the data of the previous week from the schedule
            ELOValues{iSelectedTeam}(iWeek - 1) = [];
            QB_ELOValues{iSelectedTeam}(iWeek - 1) = [];
            % Add Values to the Schedule Table
            scheduleData{iSelectedTeam}{iWeek - 1, 1} =[];
            scheduleData{iSelectedTeam}{iWeek- 1, 2} = [];
            scheduleData{iSelectedTeam}{iWeek - 1, 3} = [];
            scheduleData{iSelectedTeam}{iWeek - 1, 4} = [];
            scheduleData{iSelectedTeam}{iWeek - 1, 5} = [];
        end
    end
end
%% Section 4: Plotting and Displaying the Data

selectedButton = app.PlotTypeButtonGroup.SelectedObject.Text;

if strcmp(teamNumChoice, "One Team") % If the user selected one team
    app.schedule1Table.Data = scheduleData{1}; % Add teams 1's data to the table
    app.TeamLogo.ImageSource = teamLogo{1};% Add team 1's logo 
    xValue = length(ELOValues{1}); % The amount of weeks team 1 played

    if strcmp(selectedButton, "Team ELO") % If the user selected to plot only the Team ELO
        plot(app.ELOAxes, 1:xValue, ELOValues{1}, 'b-');
        legend(app.ELOAxes, teamCode{1} + " ELO", 'location', 'best')
    elseif strcmp(selectedButton, "QB ELO") % If the user selected to plot only the QB ELO
        plot(app.ELOAxes, 1:xValue, QB_ELOValues{1}, 'r-');
        legend(app.ELOAxes, teamCode{1} + " QB ELO", 'location', 'best')
    elseif strcmp(selectedButton, "Both") % If the user selected to plot both
        plot(app.ELOAxes, 1:xValue, ELOValues{1}, 'b-', ...
            1:xValue, QB_ELOValues{1}, 'r-');
        legend(app.ELOAxes, teamCode{1} + " ELO", teamCode{1} + " QB ELO", 'location', 'best')
    end
    axis(app.ELOAxes, [1 xValue -inf inf])

    % Plotting Two teams
elseif strcmp(teamNumChoice, "Two Teams") % If the user selected two team 2
    % Add both schedule data to the table
    app.schedule1Table.Data = scheduleData{1};
    app.schedule2Table.Data = scheduleData{2};
    % Add both logos
    app.TeamLogo.ImageSource = teamLogo{1};
    app.team2Logo.ImageSource = teamLogo{2};
    % Find how many weeks each team played
    xValue = length(ELOValues{1});
    x2Value = length(ELOValues{2});
    if strcmp(selectedButton, "Team ELO") % If the user selected to plot only the Team ELO
        plot(app.ELOAxes, 1:xValue, ELOValues{1}, 'b-', ...
            1:x2Value, ELOValues{2}, 'm--');
        legend(app.ELOAxes, teamCode{1} + " ELO", teamCode{2} + " ELO", 'location', 'best')
    elseif strcmp(selectedButton, "QB ELO") % If the user selected to plot only the QB ELO
        plot(app.ELOAxes, 1:xValue, QB_ELOValues{1}, 'r-', ...
            1:x2Value, QB_ELOValues{2}, 'g--');
        legend(app.ELOAxes, teamCode{1} + " QB ELO", teamCode{2} + " QB ELO", 'location', 'best')
    elseif strcmp(selectedButton, "Both") % If the user selected to plot both
        plot(app.ELOAxes, 1:xValue, ELOValues{1}, 'b-', ...
            1:xValue, QB_ELOValues{1}, 'r-', ...
            1:x2Value, ELOValues{2}, 'm--', ...
            1:x2Value, QB_ELOValues{2}, 'g--');
        legend(app.ELOAxes, teamCode{1} + " ELO", teamCode{1} + " QB ELO", teamCode{2} + " ELO", teamCode{2} + " QB ELO", 'location', 'best')
    end
    if x2Value >= xValue % Check which team played longer to set the x-axis
        axis(app.ELOAxes, [1 x2Value -inf inf])
    else
        axis(app.ELOAxes, [1 xValue -inf inf])
    end
end