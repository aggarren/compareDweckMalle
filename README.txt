Contents:

	~compareDweckMalle/
	DweckSimilartoMalleData.R: creates dataframes of Dweck data using combinations of 
		16 items, 40 items, 21 characters, and 3 characters
	compareItemCharNums.R: runs PCA's of output of DweckSimilartoMalleData.R and stores 
		loadings in processed data directory
	comparingDweckMalle.R: compares item loadings of Dweck and Malle data qualitatively
	comparingDweckMalleRaw.R: creates a csv of the distributions of data from different
		combinations of characters and items
	CFA.R: runs a confirmatory factor analysis on four Dweck dataframes

		~compareDweckMalle/data/raw/
		dweckRawData.csv: Dweck's raw data without identifying information
		simulatedDataDweck: Malle's raw data without identifying information
		top_match_rotated.csv: output from comparingDweckMalle.R
		comparison.csv: output from comparingDweckMalleRaw.R
		items...: output from DweckSimilartoMalleData.R

		~compareDweckMalle/R/
		GetData.R: reads in all CSV's
		helper.R: helper functions for GetData

	~compareDweckMallegraphs/


	~data/processed/compareDweckMalle/: contains output from compareItemCharNums.R

	~Write ups/: conclusions from data outputs

To run:
	1. Export all directories in this repository to the same directory
	2. Run any of the .R files in any order except must run 
		DweckSimilartoMalleData.R before compareItemCharNums.R
		and DweckSimilartoMalleData.R before CFA.R
