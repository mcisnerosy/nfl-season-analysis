function plotTeamELO(app)
[nRowData, ~] = size(app.NFLData);
[nRowMeta, ~] = size(app.Metadata);

% Get the number of teams the user wants
teamNumChoice = app.TeamButtonGroup.SelectedObject.Text;

% Get the Team choice from the Drop Down(s)
teamChoice = app.teamDropDown.Value;
app.TeamNameLabel.Text = teamChoice;

% Get the first team code, logo, and bye week from the metadata
for iRow = 1:nRowMeta
    if strcmp(teamChoice, app.Metadata{iRow, 2})
        teamCode = app.Metadata{iRow, 1};
        app.TeamLogo.ImageSource = app.Metadata{iRow, 5};
    end
end

% Get the Season ELO Values (Team, QB1, QB2)
scheduleData = {};
ELOValues = []; % Team ELO Values
QB_ELOValues = []; % QB ELO Values

for iWeek = 1:22
    gameFound = false;
    for iRow = 2:nRowData
        if (iWeek == app.NFLData{iRow, 34})
            if strcmp(teamCode, app.NFLData{iRow, 5})
                % disp("Game Found for week " + iWeek)
                ELOValues(iWeek) = app.NFLData{iRow, 7};
                QB_ELOValues(iWeek) = app.NFLData{iRow, 13};
                % Add Values to the Schedule Table
                scheduleData{iWeek, 1} = iWeek;
                scheduleData{iWeek, 2} = char(app.NFLData{iRow, 1});
                scheduleData{iWeek, 3} = app.NFLData{iRow, 15};
                scheduleData{iWeek, 4} = app.NFLData{iRow, 6};
                % Check who won
                if app.NFLData{iRow, 29} > app.NFLData{iRow, 30}
                    scheduleData{iWeek, 5} = 'WIN';
                else
                    scheduleData{iWeek, 5} = 'LOSS';
                end
                gameFound = true;
            elseif strcmp(teamCode, app.NFLData{iRow, 6})
                % disp("Game Found for week " + iWeek)
                ELOValues(iWeek) = app.NFLData{iRow, 8};
                QB_ELOValues(iWeek) = app.NFLData{iRow, 14};

                % Add Values to the Schedule Table
                scheduleData{iWeek, 1} = iWeek;
                scheduleData{iWeek, 2} = app.NFLData{iRow, 1};
                scheduleData{iWeek, 3} = app.NFLData{iRow, 16};
                scheduleData{iWeek, 4} = app.NFLData{iRow, 5};
                % Check who won
                if app.NFLData{iRow, 30} > app.NFLData{iRow, 29}
                    scheduleData{iWeek, 5} = 'WIN';
                else
                    scheduleData{iWeek, 5} = 'LOSS';
                end
                gameFound = true;
            end
        end
    end
    if (~gameFound) && ~(iWeek > 18)
        % disp("No Game Found for Week" + iWeek)
        ELOValues(iWeek) = ELOValues(iWeek - 1);
        QB_ELOValues(iWeek) = QB_ELOValues(iWeek - 1);
        % Add Values to the Schedule Table
        scheduleData{iWeek, 1} = iWeek;
        scheduleData{iWeek, 2} = 'No Game Played';
        scheduleData{iWeek, 3} = 'N/A';
        scheduleData{iWeek, 4} = 'N/A';
        scheduleData{iWeek, 5} = 'N/A';
    end
end
app.scheduleTable.Data = scheduleData;

% If there are two teams
if strcmp(teamNumChoice, "Two Teams")
    disp("Second Team ELO")
    % Get second team choice
    team2Choice = app.team2DropDown.Value;
    disp(team2Choice)
    app.Team2NameLabel.Text = team2Choice;
    % Get the Second team code and logo from the metadata
    for iRow = 1:nRowMeta
        if strcmp(team2Choice, app.Metadata{iRow, 2})
            team2Code = app.Metadata{iRow, 1};
            disp(team2Code);
            app.team2Logo.ImageSource = app.Metadata{iRow, 5};
        end
    end
    % Get the ELO values for the second team
    ELO2Values = []; % Team ELO Values
    QB_ELO2Values = []; % QB ELO Values

    for jWeek = 1:22
        gameFound = false;
        for jRow = 2:nRowData
            if jWeek == app.NFLData{jRow, 34}
                if strcmp(team2Code, app.NFLData{jRow, 5})
                    disp("Game Found for Week " + jWeek)
                    ELO2Values(jWeek) = app.NFLData{jRow, 7};
                    QB_ELO2Values(jWeek) = app.NFLData{jRow, 13};
                    gameFound = true;
                elseif strcmp(team2Code, app.NFLData{jRow, 6})
                    disp("Game Found for Week " + jWeek)
                    ELO2Values(jWeek) = app.NFLData{jRow, 8};
                    QB_ELO2Values(jWeek) = app.NFLData{jRow, 14};
                    gameFound = true;
                end
            end
        end
        if (~gameFound) && ~(jWeek > 18)
            disp("No Game found for week " + jWeek)
            ELO2Values(jWeek) = ELO2Values(jWeek - 1);
            QB_ELO2Values(jWeek) = QB_ELO2Values(jWeek - 1);
        end
    end
end

% Plot the Data
selectedButton = app.PlotTypeButtonGroup.SelectedObject.Text;
if strcmp(teamNumChoice, "One Team")
    disp("Plotting One Team")
    xValue = length(ELOValues);
    if strcmp(selectedButton, "Team ELO")
        plot(app.ELOAxes, 1:xValue, ELOValues, 'b-');
        % axis(app.ELOAxes, [1 xValue -inf inf])
        legend(app.ELOAxes, "Team ELO", 'location', 'best')
    elseif strcmp(selectedButton, "QB ELO")
        plot(app.ELOAxes, 1:xValue, QB_ELOValues, 'r-');
        % axis(app.ELOAxes, [1 xValue -inf inf])
        legend(app.ELOAxes, "QB ELO", 'location', 'best')
    elseif strcmp(selectedButton, "Both")
        plot(app.ELOAxes, 1:xValue, ELOValues, 'b-', ...
            1:xValue, QB_ELOValues, 'r-');
        % axis(app.ELOAxes, [1 xValue -inf inf])
        legend(app.ELOAxes, "Team ELO", "QB ELO", 'location', 'best')
    end
elseif strcmp(teamNumChoice, "Two Teams")
    disp("Plotting Two Teams")
    xValue = length(ELOValues);
    disp(xValue)
    x2Value = length(ELO2Values);
    disp(x2Value)
    if strcmp(selectedButton, "Team ELO")
        plot(app.ELOAxes, 1:xValue, ELOValues, 'b-', ...
            1:x2Value, ELO2Values, 'y');
        % axis(app.ELOAxes, [1 xValue -inf inf])
        legend(app.ELOAxes, "Team ELO", "Team 2 ELO", 'location', 'best')
    elseif strcmp(selectedButton, "QB ELO")
        plot(app.ELOAxes, 1:xValue, QB_ELOValues, 'r-', ...
            1:x2Value, QB_ELO2Values, 'c');
        % axis(app.ELOAxes, [1 xValue -inf inf])
        legend(app.ELOAxes, "QB ELO", "QB 2 ELO", 'location', 'best')
    elseif strcmp(selectedButton, "Both")
        plot(app.ELOAxes, 1:xValue, ELOValues, 'b-', ...
            1:xValue, QB_ELOValues, 'r-', ...
            1:x2Value, ELO2Values, 'y', ...
            1:x2Value, QB_ELO2Values, 'c');
        % axis(app.ELOAxes, [1 xValue -inf inf])
        legend(app.ELOAxes, "Team ELO", "QB ELO", "Team 2 ELO", "QB 2 ELO", 'location', 'best')
    end
end
