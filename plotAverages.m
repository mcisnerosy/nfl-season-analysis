function plotAverages(app)
% This function will plot the averages for the game qualities and scores
% for the user's selected data type. Such data type includes all teams,
% certain teams, divisions, and conferences

% The following lines will store the rows of the NFLData and Metadata files
% into variables
[nRowData, ~] = size(app.NFLData);
[nRowMeta, ~] = size(app.Metadata);

% Get the time frame the user wants to plot the averages for
timeFrameStart = 0;
timeFrameEnd = 0;

% Iterate through an if-elseif statement in order to determine the
% timeFrame values for the selected time frame
if(app.TimeFrameDropDown.Value == "Regular Season")
    timeFrameStart = 1;
    timeFrameEnd = 18;
elseif(app.TimeFrameDropDown.Value == "Playoffs")
    timeFrameStart = 19;
    timeFrameEnd = 22;
elseif(app.TimeFrameDropDown.Value == "Both")
    timeFrameStart = 1;
    timeFrameEnd = 22;
end

% Week 17 Disclamer to display to the user about potential data missing or
% not plotting accurately due to the Cincinnati Bengals vs. Buffalo Bills
% game cancelled. 
if(app.SpecificDataType1DropDown.Value == "Cincinnati Bengals") || (app.SpecificDataType1DropDown.Value == "AFC") || (app.SpecificDataType1DropDown.Value == "AFC East") || (app.SpecificDataType1DropDown.Value == "AFC North") || (app.SpecificDataType1DropDown.Value == "Buffalo Bills") || app.DataTypeDropDown.Value == "All Teams"
    app.NoticeLabel.Visible = "on";
elseif(app.SpecificDataType2DropDown.Value == "Cincinnati Bengals") || (app.SpecificDataType2DropDown.Value == "AFC") || (app.SpecificDataType2DropDown.Value == "AFC East") || (app.SpecificDataType2DropDown.Value == "AFC North") || (app.SpecificDataType2DropDown.Value == "Buffalo Bills") || app.DataTypeDropDown.Value == "All Teams"
    app.NoticeLabel.Visible = "on";
else
    app.NoticeLabel.Visible = "off";
end

% Get the data type the user wants to plot
dataType = app.DataTypeDropDown.Value;

% Change label and items based on the data type selection of "All Teams"
% This will made all images and labels unvisible as necessary and display
% the dropdowns and labels needed
if(string(dataType) == "All Teams")
    app.Team1Label.Visible = "off";
    app.Team2Label.Visible = "off";
    app.Team1Image.Visible = "off";
    app.Team2Image.Visible = "off";
    app.SpecificDataType1Label.Visible = "off";
    app.SpecificDataType2Label.Visible = "off";
    app.SpecificDataType1DropDown.Visible = "off";
    app.SpecificDataType2DropDown.Visible = "off";
    app.ComparetwoCheckBox.Visible = "off";
    app.Team1Label.Visible = "off";
    app.Team2Label.Visible = "off";
    app.Team1Image.Visible = "off";
    app.Team2Image.Visible = "off";
% Change label and items based on the data type selection of "Teams"
% This will made all images and labels unvisible as necessary and display
% the dropdowns and labels needed. In addition, the necessary labels and
% images will display if the checkbox for comparing two teams is selected
elseif(string(dataType) == "Teams")
    app.Team1Image.Visible = "on";
    app.SpecificDataType1Label.Text = "Team 1";
    app.SpecificDataType1Label.Visible = "on";
    app.SpecificDataType1DropDown.Visible = "on";
    app.ComparetwoCheckBox.Visible = "on";
    app.Team1Label.Visible = "on";
    app.SpecificDataType1DropDown.Items = app.Metadata(1:32, 2)';
    if(app.ComparetwoCheckBox.Value)
        app.SpecificDataType2DropDown.Items = app.Metadata(1:32, 2)';
        app.Team2Image.Visible = "on";
        app.SpecificDataType2Label.Text = "Team 2";
        app.SpecificDataType2Label.Visible = "on";
        app.SpecificDataType2DropDown.Visible = "on";
        app.Team2Label.Visible = "on";
    else
        app.SpecificDataType2Label.Visible = "off";
        app.SpecificDataType2DropDown.Visible = "off";
        app.Team2Image.Visible = "off";
        app.Team2Label.Visible = "off";
    end
% Change label and items based on the data type selection of "Divisions"
% This will made all images and labels unvisible as necessary and display
% the dropdowns and labels needed. In addition, the necessary labels and
% images will display if the checkbox for comparing two divisions is selected
elseif(string(dataType) == "Divisions")
    app.Team1Label.Visible = "off";
    app.Team2Label.Visible = "off";
    app.Team1Image.Visible = "off";
    app.Team2Image.Visible = "off";
    app.SpecificDataType1Label.Text = "Division 1";
    app.SpecificDataType1DropDown.Visible = "on";
    app.SpecificDataType1DropDown.Items = ["AFC North", "AFC East", "AFC South", "AFC West", "NFC North", "NFC East", "NFC South", "NFC West"];
    app.ComparetwoCheckBox.Visible = "on";
    if(app.ComparetwoCheckBox.Value)
        app.SpecificDataType2Label.Text = "Division 2";
        app.SpecificDataType2Label.Visible = "on";
        app.SpecificDataType2DropDown.Visible = "on";
        app.SpecificDataType2DropDown.Items = ["AFC North", "AFC East", "AFC South", "AFC West", "NFC North", "NFC East", "NFC South", "NFC West"];
    else
        app.SpecificDataType2Label.Visible = "off";
        app.SpecificDataType2DropDown.Visible = "off";
    end
% Change label and items based on the data type selection of "Conferences"
% This will made all images and labels unvisible as necessary and display
% the dropdowns and labels needed. In addition, the necessary labels and
% images will display if the checkbox for comparing two conferences is selected
elseif(string(dataType) == "Conferences")
    app.Team1Label.Visible = "off";
    app.Team2Label.Visible = "off";
    app.Team1Image.Visible = "off";
    app.Team2Image.Visible = "off";
    app.SpecificDataType1Label.Text = "Conference 1";
    app.SpecificDataType1Label.Visible = "on";
    app.ComparetwoCheckBox.Visible = "on";
    app.SpecificDataType1DropDown.Items = ["AFC", "NFC"];
    if(app.ComparetwoCheckBox.Value)
        app.SpecificDataType2Label.Text = "Conference 2";
        app.SpecificDataType2Label.Visible = "on";
        app.SpecificDataType2DropDown.Visible = "on";
        app.SpecificDataType2DropDown.Items = ["AFC", "NFC"];
    else
        app.SpecificDataType2Label.Visible = "off";
        app.SpecificDataType2DropDown.Visible = "off";
    end
end

%% Compute the averages for each data type
% The following if-elseif statement wil check through the specific data
% type selected by the user in order to perform the necessary computations
% corresponding to that data type along with the multiple teams, divisions, and
% conferences they want to view the average scores and game qualities for

%% "All Teams" Data Type Selected

% The following if statement will consists of variables to keep track of
% the total qualities and the number of games counted. This is necessary
% in order to compute the average game scores and qualities for each team's
% games. 
if(string(dataType) == "All Teams")
    countTeamsWeek = 0;
    countScores = 0;
    vectorIndex = 1;
    weekValue = timeFrameStart;
    countQualities = 0;
    allTeamsVecAverage = [];
    allTeamsVecQualities = [];
    weekVec = [];
    % The following for loop will iterate through the NFLData file in order
    % to extract the responding scores and game qualities to the
    % corresponding week the loop is on right now. Within the for loop is
    % another for loop that will iterate through each week number in order
    % to extract the values corresponding with each week
    for week = timeFrameStart:timeFrameEnd
        for i = 1:nRowData
            if(week == app.NFLData{i, 34})
                countScores = countScores + ((app.NFLData{i, 29} + app.NFLData{i, 30}) / 2);
                countQualities = countQualities + app.NFLData{i, 31};
                countTeamsWeek = countTeamsWeek + 1;
            end
        end
        allTeamsVecAverage(1, vectorIndex) = countScores / countTeamsWeek;
        allTeamsVecQualities(1, vectorIndex) = countQualities / countTeamsWeek;
        weekVec(1, vectorIndex) = weekValue;
        vectorIndex = vectorIndex + 1;
        weekValue = weekValue + 1;
        countQualities = 0;
        countTeamsWeek = 0;
        countScores = 0;
    end
    % Once the values have been selected and appended into their
    % corresponding vectors, the vectors are then plotted onto their axes
    % in the app. 
    plot(app.AverageScoreAxes, weekVec, allTeamsVecAverage)
    plot(app.AverageQualitiesAxes, weekVec, allTeamsVecQualities)
    legend(app.AverageScoreAxes, "All Teams")
    legend(app.AverageQualitiesAxes, "All Teams")

%% "Teams" Data Type Selected
% The following elseif statement will check for the Teams datatype. This
% elseif statement will differ from the All Teams data selection since the
% option to compare two teams will be available. The elseif statement will
% begin with the variables initilaized that will hold the total qualities
% and scores of the games, which will be divided by the count of those
% games in order to get the averages. 
elseif(string(dataType) == "Teams")
    % This if-statement will determine if the checkbox to compare two teams
    % is selected. If it is, the following codes will run. 
    if(app.ComparetwoCheckBox.Value)
        countTeamsWeek = 0;
        countTeamsWeek2 = 0;
        firstteamcountScores = 0;
        secondteamcountScores = 0;
        firstteamcountQualities = 0;
        secondteamcountQualities = 0;
        vectorIndex = 1;
        weekValue = timeFrameStart;
        team1Name = app.SpecificDataType1DropDown.Value;
        team1Abriv = "";
        % This for loop will loop through the Metadata file to extract the
        % imagesource string and team 1 abbreviation for team 2
        for i = 1:nRowMeta
            if(string(team1Name) == string(app.Metadata{i, 2}))
                app.Team1Image.ImageSource = app.Metadata{i, 5};
                team1Abriv = app.Metadata{i, 1};
            end
        end
        team2Name = app.SpecificDataType2DropDown.Value;
        team2Abriv = "";
        % This for loop will loop through the Metadata file to extract the
        % imagesource string and team 2 abbreviation for team 2
        for i = 1:nRowMeta
            if(string(team2Name) == string(app.Metadata{i, 2}))
                app.Team2Image.ImageSource = app.Metadata{i, 5};
                team2Abriv = app.Metadata{i, 1};
            end
        end

        % There will be two vectors for both teams for the score averages
        % and score qualities. 
        firstTeamVecAverage = [];
        secondTeamVecAverage = [];
        firstTeamVecQualities = [];
        secondTeamVecQualities = [];
        % Week vec will hold the week values based on the time frames
        % selected, which will be used as the x-axis of the plot
        weekVec = [];

        % The following for loop will determine which games to plot based
        % on the corresponding week number and the team abbreviations. The
        % if-statements wiithin the for loop will be used to determine
        % which scores and qualities to extract 
        for week = timeFrameStart:timeFrameEnd
            for i = 1:nRowData
                if(week == app.NFLData{i, 34})
                    if(string(team1Abriv) == string(app.NFLData{i, 5}) && string(team2Abriv) == string(app.NFLData{i, 6})) || (string(team2Abriv) == string(app.NFLData{i, 5}) && string(team1Abriv) == string(app.NFLData{i, 6}))
                        firstteamcountScores = firstteamcountScores + (app.NFLData{i, 29} + app.NFLData{i, 30} / 2);
                        secondteamcountScores = secondteamcountScores + (app.NFLData{i, 29} + app.NFLData{i, 30} / 2);
                        firstteamcountQualities = firstteamcountQualities + app.NFLData{i, 31};
                        secondteamcountQualities = secondteamcountQualities + app.NFLData{i, 31};
                        countTeamsWeek = countTeamsWeek + 1;
                        countTeamsWeek2 = countTeamsWeek2 + 1;
                    else
                        if(string(team1Abriv) == string(app.NFLData{i, 5})) || (string(team1Abriv) == string(app.NFLData{i, 6}))
                            firstteamcountScores = firstteamcountScores + (app.NFLData{i, 29} + app.NFLData{i, 30} / 2);
                            firstteamcountQualities = firstteamcountQualities + app.NFLData{i, 31};
                            countTeamsWeek = countTeamsWeek + 1;
                        end
                        if(string(team2Abriv) == string(app.NFLData{i, 5})) || (string(team2Abriv) == string(app.NFLData{i, 6}))
                            secondteamcountScores = secondteamcountScores + (app.NFLData{i, 29} + app.NFLData{i, 30} / 2);
                            secondteamcountQualities = secondteamcountQualities + app.NFLData{i, 31};
                            countTeamsWeek2 = countTeamsWeek2 + 1;
                        end
                    end
                end
            end
            firstTeamVecAverage(1, vectorIndex) = firstteamcountScores / countTeamsWeek;
            firstTeamVecQualities(1, vectorIndex) = firstteamcountQualities / countTeamsWeek;
            secondTeamVecAverage(1, vectorIndex) = secondteamcountScores / countTeamsWeek2;
            secondTeamVecQualities(1, vectorIndex) = secondteamcountQualities / countTeamsWeek2;
            weekVec(1, vectorIndex) = weekValue;
            vectorIndex = vectorIndex + 1;
            weekValue = weekValue + 1;
            firstteamcountQualities = 0;
            firstteamcountScores = 0;
            countTeamsWeek = 0;
            countTeamsWeek2 = 0;
            secondteamcountScores = 0;
            secondteamcountQualities = 0;
        end
        % The vectors are then ploted to their corresponding axes with a
        % legend to distinct between the two teams being compared 
        plot(app.AverageScoreAxes, weekVec, firstTeamVecAverage,...
            weekVec, secondTeamVecAverage)
        plot(app.AverageQualitiesAxes, weekVec, firstTeamVecQualities,...
            weekVec, secondTeamVecQualities)
        legend(app.AverageScoreAxes, team1Name, team2Name)
        legend(app.AverageQualitiesAxes, team1Name, team2Name)
        
    % The following else statement is used to calculate the values for just
    % one team being plotted. 
    else
        countTeamsWeek = 0;
        firstteamcountScores = 0;
        firstteamcountQualities = 0;
        vectorIndex = 1;
        weekValue = timeFrameStart;
        team1Name = app.SpecificDataType1DropDown.Value;
        team1Abriv = "";
        for i = 1:nRowMeta
            if(string(team1Name) == string(app.Metadata{i, 2}))
                app.Team1Image.ImageSource = app.Metadata{i, 5};
                team1Abriv = app.Metadata{i, 1};
            end
        end
        firstTeamVecAverage = [];
        firstTeamVecQualities = [];
        weekVec = [];
        for week = timeFrameStart:timeFrameEnd
            for i = 1:nRowData
                if(week == app.NFLData{i, 34})
                     if(string(team1Abriv) == string(app.NFLData{i, 5})) || (string(team1Abriv) == string(app.NFLData{i, 6}))
                            firstteamcountScores = firstteamcountScores + (app.NFLData{i, 29} + app.NFLData{i, 30} / 2);
                            firstteamcountQualities = firstteamcountQualities + app.NFLData{i, 31};
                            countTeamsWeek = countTeamsWeek + 1;
                     end
                end
            end
            firstTeamVecAverage(1, vectorIndex) = firstteamcountScores / countTeamsWeek;
            firstTeamVecQualities(1, vectorIndex) = firstteamcountQualities / countTeamsWeek;
            weekVec(1, vectorIndex) = weekValue;
            vectorIndex = vectorIndex + 1;
            weekValue = weekValue + 1;
            firstteamcountQualities = 0;
            firstteamcountScores = 0;
            countTeamsWeek = 0;
        end
        plot(app.AverageScoreAxes, weekVec, firstTeamVecAverage)
        plot(app.AverageQualitiesAxes, weekVec, firstTeamVecQualities)
        legend(app.AverageScoreAxes, team1Name)
        legend(app.AverageQualitiesAxes, team1Name)
    end
%% "Divisions" Data Type Selected
% The following elseif statement will be used to compute the values
% necessary for when the user wants to look at data within certain
% divisions or just one division 

elseif(string(dataType) == "Divisions")
    % The following if-statement will be used to determine if the checkbox
    % for comparing two divisions is checked. The following code will be
    % ran if the checkbox is checked
    if(app.ComparetwoCheckBox.Value)
        divisionSelection = app.SpecificDataType1DropDown.Value;
        divisionSelection2 = app.SpecificDataType2DropDown.Value;
        % The countTeamsWeek variables will hold the amount of games
        % counted within a certain week, which will be used to divide the
        % total qualities and scores by to get the averages
        countTeamsWeek = 0;
        countTeamsWeek2 = 0;
        countScores = 0;
        countScores2 = 0;
        vectorIndex = 1;
        weekValue = timeFrameStart;
        countQualities = 0;
        countQualities2 = 0;
        countTeams = 1;
        % Instead of having two teams to compare, there will be four teams
        % within each cell array that will average out their values based
        % on the length of the cell array. Each cell array will contain the
        % team abbreviations corresponding to their division
        teamsVec = {};
        teamsVec2 = {};
        for i = 1:nRowMeta
            if(string(divisionSelection) == string(app.Metadata{i, 4}))
                teamsVec{1, countTeams} = string(app.Metadata{i, 1});
                countTeams = countTeams + 1;
            end
        end
        countTeams = 1;
        for i = 1:nRowMeta
            if(string(divisionSelection2) == string(app.Metadata{i, 4}))
                teamsVec2{1, countTeams} = string(app.Metadata{i, 1});
                countTeams = countTeams + 1;
            end
        end
        divisionTeamsVecAverage = [];
        divisionTeamsVecQualities = [];
        divisionTeamsVecAverage2 = [];
        divisionTeamsVecQualities2 = [];
        weekVec = [];
        for week = timeFrameStart:timeFrameEnd
            for i = 1:nRowData
                if(week == app.NFLData{i, 34})
                    for x = 1:length(teamsVec)
                        if(string(teamsVec{1, x}) == string(app.NFLData{i, 5})) || (string(teamsVec{1, x}) == string(app.NFLData{i, 6}))
                            countScores = countScores + ((app.NFLData{i, 29} + app.NFLData{i, 30}) / 2);
                            countQualities = countQualities + app.NFLData{i, 31};
                            countTeamsWeek = countTeamsWeek + 1;
                        end
                        if(string(teamsVec2{1, x}) == string(app.NFLData{i, 5})) || (string(teamsVec2{1, x}) == string(app.NFLData{i, 6}))
                            countScores2 = countScores2 + ((app.NFLData{i, 29} + app.NFLData{i, 30}) / 2);
                            countQualities2 = countQualities2 + app.NFLData{i, 31};
                            countTeamsWeek2 = countTeamsWeek2 + 1;
                        end
                    end
                end
            end
            divisionTeamsVecAverage(1, vectorIndex) = countScores / countTeamsWeek;
            divisionTeamsVecQualities(1, vectorIndex) = countQualities / countTeamsWeek;
            divisionTeamsVecAverage2(1, vectorIndex) = countScores2 / countTeamsWeek2;
            divisionTeamsVecQualities2(1, vectorIndex) = countQualities2 / countTeamsWeek2;
            weekVec(1, vectorIndex) = weekValue;
            vectorIndex = vectorIndex + 1;
            weekValue = weekValue + 1;
            countQualities = 0;
            countTeamsWeek = 0;
            countScores = 0;
            countQualities2 = 0;
            countTeamsWeek2 = 0;
            countScores2 = 0;
        end
        plot(app.AverageScoreAxes, weekVec, divisionTeamsVecAverage,...
            weekVec, divisionTeamsVecAverage2)
        plot(app.AverageQualitiesAxes, weekVec, divisionTeamsVecQualities,...
            weekVec, divisionTeamsVecQualities2)
        legend(app.AverageScoreAxes, divisionSelection, divisionSelection2)
        legend(app.AverageQualitiesAxes, divisionSelection, divisionSelection2)
    % The following else statement will plot and compute the necessary
    % averages for the one division selected
    else
        divisionSelection = app.SpecificDataType1DropDown.Value;
        countTeamsWeek = 0;
        countScores = 0;
        vectorIndex = 1;
        weekValue = timeFrameStart;
        countQualities = 0;
        countTeams = 1;
        teamsVec = {};
        for i = 1:nRowMeta
            if(string(divisionSelection) == string(app.Metadata{i, 4}))
                teamsVec{1, countTeams} = string(app.Metadata{i, 1});
                countTeams = countTeams + 1;
            end
        end
        divisionTeamsVecAverage = [];
        divisionTeamsVecQualities = [];
        weekVec = [];
        for week = timeFrameStart:timeFrameEnd
            for i = 1:nRowData
                if(week == app.NFLData{i, 34})
                    for x = 1:length(teamsVec)
                        if(string(teamsVec{1, x}) == string(app.NFLData{i, 5})) || (string(teamsVec{1, x}) == string(app.NFLData{i, 6}))
                            countScores = countScores + ((app.NFLData{i, 29} + app.NFLData{i, 30}) / 2);
                            countQualities = countQualities + app.NFLData{i, 31};
                            countTeamsWeek = countTeamsWeek + 1;
                        end
                    end
                end
            end
            divisionTeamsVecAverage(1, vectorIndex) = countScores / countTeamsWeek;
            divisionTeamsVecQualities(1, vectorIndex) = countQualities / countTeamsWeek;
            weekVec(1, vectorIndex) = weekValue;
            vectorIndex = vectorIndex + 1;
            weekValue = weekValue + 1;
            countQualities = 0;
            countTeamsWeek = 0;
            countScores = 0;
        end
        plot(app.AverageScoreAxes, weekVec, divisionTeamsVecAverage)
        plot(app.AverageQualitiesAxes, weekVec, divisionTeamsVecQualities)
        legend(app.AverageScoreAxes, divisionSelection)
        legend(app.AverageQualitiesAxes, divisionSelection)
    end
%% "Conferences" Data Type Selected
% The following elseif statement will be used to run code for the user when
% they want to look at a data for a certain conference or both conferences
% being compared to each other
elseif(string(dataType) == "Conferences")
    if(app.ComparetwoCheckBox.Value)
        conferenceSelection = app.SpecificDataType1DropDown.Value;
        conferenceSelection2 = app.SpecificDataType2DropDown.Value;
        countTeamsWeek = 0;
        countTeamsWeek2 = 0;
        countScores = 0;
        countScores2 = 0;
        vectorIndex = 1;
        weekValue = timeFrameStart;
        countQualities = 0;
        countQualities2 = 0;
        countTeams = 1;
        teamsVec = {};
        teamsVec2 = {};
        for i = 1:nRowMeta
            if(string(conferenceSelection) == string(app.Metadata{i, 3}))
                teamsVec{1, countTeams} = string(app.Metadata{i, 1});
                countTeams = countTeams + 1;
            end
        end
        countTeams = 1;
        for i = 1:nRowMeta
            if(string(conferenceSelection2) == string(app.Metadata{i, 3}))
                teamsVec2{1, countTeams} = string(app.Metadata{i, 1});
                countTeams = countTeams + 1;
            end
        end
        conferenceTeamsVecAverage = [];
        conferenceTeamsVecQualities = [];
        conferenceTeamsVecAverage2 = [];
        conferenceTeamsVecQualities2 = [];
        weekVec = [];
        for week = timeFrameStart:timeFrameEnd
            for i = 1:nRowData
                if(week == app.NFLData{i, 34})
                    for x = 1:length(teamsVec)
                        if(string(teamsVec{1, x}) == string(app.NFLData{i, 5})) || (string(teamsVec{1, x}) == string(app.NFLData{i, 6}))
                            countScores = countScores + ((app.NFLData{i, 29} + app.NFLData{i, 30}) / 2);
                            countQualities = countQualities + app.NFLData{i, 31};
                            countTeamsWeek = countTeamsWeek + 1;
                        end
                        if(string(teamsVec2{1, x}) == string(app.NFLData{i, 5})) || (string(teamsVec2{1, x}) == string(app.NFLData{i, 6}))
                            countScores2 = countScores2 + ((app.NFLData{i, 29} + app.NFLData{i, 30}) / 2);
                            countQualities2 = countQualities2 + app.NFLData{i, 31};
                            countTeamsWeek2 = countTeamsWeek2 + 1;
                        end
                    end
                end
            end
            conferenceTeamsVecAverage(1, vectorIndex) = countScores / countTeamsWeek;
            conferenceTeamsVecQualities(1, vectorIndex) = countQualities / countTeamsWeek;
            conferenceTeamsVecAverage2(1, vectorIndex) = countScores2 / countTeamsWeek2;
            conferenceTeamsVecQualities2(1, vectorIndex) = countQualities2 / countTeamsWeek2;
            weekVec(1, vectorIndex) = weekValue;
            vectorIndex = vectorIndex + 1;
            weekValue = weekValue + 1;
            countQualities = 0;
            countTeamsWeek = 0;
            countScores = 0;
            countQualities2 = 0;
            countTeamsWeek2 = 0;
            countScores2 = 0;
        end
        plot(app.AverageScoreAxes, weekVec, conferenceTeamsVecAverage,...
            weekVec, conferenceTeamsVecAverage2)
        plot(app.AverageQualitiesAxes, weekVec, conferenceTeamsVecQualities,...
            weekVec, conferenceTeamsVecQualities2)
        legend(app.AverageScoreAxes, conferenceSelection, conferenceSelection2)
        legend(app.AverageQualitiesAxes, conferenceSelection, conferenceSelection2)
    else
        conferenceSelection = app.SpecificDataType1DropDown.Value;
        countTeamsWeek = 0;
        countScores = 0;
        vectorIndex = 1;
        weekValue = timeFrameStart;
        countQualities = 0;
        countTeams = 1;
        teamsVec = {};
        for i = 1:nRowMeta
            if(string(conferenceSelection) == string(app.Metadata{i, 3}))
                teamsVec{1, countTeams} = string(app.Metadata{i, 1});
                countTeams = countTeams + 1;
            end
        end
        conferenceTeamsVecAverage = [];
        conferenceTeamsVecQualities = [];
        weekVec = [];
        for week = timeFrameStart:timeFrameEnd
            for i = 1:nRowData
                if(week == app.NFLData{i, 34})
                    for x = 1:length(teamsVec)
                        if(string(teamsVec{1, x}) == string(app.NFLData{i, 5})) || (string(teamsVec{1, x}) == string(app.NFLData{i, 6}))
                            countScores = countScores + ((app.NFLData{i, 29} + app.NFLData{i, 30}) / 2);
                            countQualities = countQualities + app.NFLData{i, 31};
                            countTeamsWeek = countTeamsWeek + 1;
                        end
                    end
                end
            end
            conferenceTeamsVecAverage(1, vectorIndex) = countScores / countTeamsWeek;
            conferenceTeamsVecQualities(1, vectorIndex) = countQualities / countTeamsWeek;
            weekVec(1, vectorIndex) = weekValue;
            vectorIndex = vectorIndex + 1;
            weekValue = weekValue + 1;
            countQualities = 0;
            countTeamsWeek = 0;
            countScores = 0;
        end
        plot(app.AverageScoreAxes, weekVec, conferenceTeamsVecAverage)
        plot(app.AverageQualitiesAxes, weekVec, conferenceTeamsVecQualities)
        legend(app.AverageScoreAxes, conferenceSelection)
        legend(app.AverageQualitiesAxes, conferenceSelection)
    end
end
