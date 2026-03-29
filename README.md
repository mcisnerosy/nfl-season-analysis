# nfl-season-analysis

Interactive MATLAB application analyzing the 2022 NFL season, uncovering performance trends between ELO ratings, yardage metrics, and win probability across all 32 teams.

## Overview
This project analyzes the 2022 NFL season using ELO ratings and team statistics to identify performance trends and visualize team success across the full season. Built as an interactive MATLAB App Designer application, users can explore team-by-team breakdowns and compare offensive metrics against win outcomes.

Key questions explored:
- How do ELO ratings track with team win totals across the 2022 season?
- Which teams outperformed or underperformed their offensive metrics?
- How do yardage averages and efficiency compare across all 32 NFL teams?

## Tech Stack
- MATLAB App Designer (.mlapp)
- MATLAB (.m scripts)
- Excel data files (.xlsx)
- Vectorized data operations for visualization efficiency

## How to Run
1. Clone or download the repo
2. Open MATLAB
3. Open `NFL2022Analysis_Final_Version.mlapp` in App Designer
4. Click **Run** to launch the interactive application
5. For specific visualizations, open `question3and4Visualization.mlapp` separately

> **Note:** MATLAB license required to run. All 32 NFL team logos and datasets are included in the repo.

## Project Structure
```
nfl-season-analysis/
├── NFL2022Analysis_Final_Version.mlapp   # Main interactive application
├── question3and4Visualization.mlapp      # Secondary visualization app
├── dataLoading.m                         # Data loading and preprocessing
├── gameAnalysis.m                        # Game-level analysis functions
├── plotAverages.m                        # Team averages visualization
├── plotTeamELO.m                         # ELO rating plots
├── plotTeamELO2.m                        # ELO rating comparison plots
├── barELOFunction.m                      # ELO bar chart functions
├── barELOFunction2.m                     # ELO bar chart helper functions
├── NFL_ELO_2022-2023_Season.xlsx         # ELO ratings dataset
├── NFL_Team_Metadata.xlsx                # Team metadata and stats
└── [32 NFL team logo .jpg files]         # Team logos for visualizations
```

## Data Sources
- `NFL_ELO_2022-2023_Season.xlsx` — ELO ratings for all 32 teams across the 2022-2023 season
- `NFL_Team_Metadata.xlsx` — Team statistics and metadata

## Visualizations
<img width="947" height="785" alt="image" src="https://github.com/user-attachments/assets/9cb0b648-2b40-4df3-9781-3de776fa0be4" />
<img width="942" height="787" alt="image" src="https://github.com/user-attachments/assets/df0a29a5-8231-41ff-9cd5-9ba10e9cd3ed" />
<img width="942" height="777" alt="image" src="https://github.com/user-attachments/assets/fd400a3d-b246-4c1e-8955-e84865701865" />
<img width="945" height="780" alt="image" src="https://github.com/user-attachments/assets/3b3a4def-2ea7-45b2-b91e-fef1fbf956ed" />

## Collaborators
Completed in collaboration with a partner as part of EG 10118 - Engineering Computing at the University of Notre Dame (Spring 2024).

## Acknowledgements
University of Notre Dame — EG 10118 Engineering Computing
