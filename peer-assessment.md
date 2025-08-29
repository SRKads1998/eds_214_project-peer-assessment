Automate
[ ] Running the entire analysis requires rendering one Quarto document
Meets spec, it ran successfully, would recommend adding a few more details to the different section of the Quarto doc

[ ] The analysis runs without errors
Meets spec, but would recommend filtering out the warnings/ and the package notifications
[ ] The analysis produces the expected output
Not yet, just would say that a bit more redrafting of the code formatting and data segments will help make sure we're getting exactly what we're looking for
[ ] Data import/cleaning is handled in its own script(s)
Meets spec, Data folder contains 3 CSVs, and the import_cleaning_script has the file for formatting
Organize
[ ] Raw data is contained in its own folder
Not Yet, really close, but just a bit confused on teh difference on the 3 CSVs in the data folder, and if there is anywhere else where raw data may be stored. 
[ ] Intermediate outputs are created and saved to a separate folder from raw data
Meets spec, import_cleaing_script serves as good output location
[ ] At least one piece of functionality has been refactored into a function in its own file
Meets spec, rolling_mean function meets the requirement
Document
[ ] The repo has a README that explains where to find (1) data, (2) analysis script, (3) supporting code, and (4) outputs
not yet, some naming discrepancies between the ReadMe and what folders are present in the project
[ ] The README includes a flowchart and text explaining how the analysis works
Meets spec, I think the write-up is fairly good, and I liked that you included the figure, but would like to see a flowchart, if possible
[ ] The code is appropriately commented
Meets spec, but to go to next level maybe include some more detailed header comments at the top of the R files.
[ ] Variable and function names are descriptive and follow a consistent naming convention
Meets spec, clear names for each function and variable. Maybe for the final data frames see if you can seperate out non-relevant columns, but just an idea
Scale
After cloning the repo on Workbench:

[ ] Running the environment initialization script installs all required packages
Meets spec, looks like the doc would run successfully
[ ] The analysis script runs without errors