#include <stdio.h>
#include <iostream>
#include <fstream>
using namespace std;

////////////////////////////////////////
//isSafe - ASM function called from C++
//UsedInRow, UsedInCol, UsedInBox - ASM functions called from isSafe (ASM function as well)
////////////////////////////////////////

// empty cells in sudoku grid
#define UNASSIGNED 0
#define N 9

// Checks whether it will be legal to assign num to the given row,col
extern "C" bool __stdcall isSafe(int grid[N][N], int row, int col, int num);

int grid[9][9];
 
void inputGrid(string name)
{
	ifstream fin;
	fin.open(name, ios::in);
	for(int i=0; i<N; i++)
		for (int j=0; j<N; j++)
			fin>>grid[i][j];
}

//number of possible values
int SuitableVals(int grid[N][N], int row, int col)
{
	int total = 0;
	int i=1;
	
	for (int i = 1; i < 10; i++)
	{
		if (isSafe(grid, row, col, i))
		total++;
	}
	return total;
}
//Searches for an unassigned entry with the least number of possible values, sets row, col accordingly
bool FindUnassignedLocation(int grid[N][N], int &row, int &col)
{
int min = 10;
int cur = 0;
int currRow, currCol;
bool foundUnassigned = false;
for (currRow = 0; currRow < N; currRow++)
{
	for (currCol = 0; currCol < N; currCol++)
	{
		if (grid[currRow][currCol] == UNASSIGNED)
		{
			foundUnassigned = true;
			cur = SuitableVals(grid, currRow, currCol);
			if (cur < min)
				{
					min = cur;
					row = currRow;
					col = currCol;
				}
			}
		}
	}
return foundUnassigned;
}

//main function
bool SolveSudoku(int grid[N][N])
{
    int row, col;
 
    // If there is no unassigned location, we are done
    if (!FindUnassignedLocation(grid, row, col))
       return true; // success
 
    // try digits 1 to 9
    for (int num = 1; num <= 9; num++)
    {
        // if legal to assign
        if (isSafe(grid, row, col, num))
        {
            // make tentative assignment
            grid[row][col] = num;
 
            // return, if success
            if (SolveSudoku(grid))
                return true;
 
            // failure, clear & try again
            grid[row][col] = UNASSIGNED;
        }
    }
    return false; // this triggers backtracking
}

/* A utility function to print grid  */
void printGrid(int grid[N][N])
{
    for (int row = 0; row < N; row++)
    {
       for (int col = 0; col < N; col++)
             cout<<grid[row][col]<<" ";
        cout<<endl;
    }
}

int main()
{
	
	string file;
	//file="inputNoSolution.txt"
	//file="inputMedium.txt";
	//file="inputKiller.txt";
	file = "inputImpossible.txt";

	inputGrid(file);
    if (SolveSudoku(grid) == true)
          printGrid(grid);
    else
         cout<<"No solution exists"<<endl;
	system("pause");
    return 0;
}