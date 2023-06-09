﻿#include <iostream>
#include "omp.h"

using namespace std;

const int rows_count = 20000;
const int cols_count = 10000;
long long min_sum_row;
/*int num_threads;*/
const int num_threads = 8;

int arr[rows_count][cols_count];

void initialize_array();
long long find_sum_array(int);
int min_sum_and_index_row(int);


int main()
{
	initialize_array();

	//cout << "Enter number of threads: ";
	//cin >> num_threads;

	double t1 = omp_get_wtime();
	omp_set_nested(1);


	#pragma omp parallel sections
	{
		#pragma omp section
		{

			printf("sum_array_%d = %lld \n\n",num_threads, find_sum_array(num_threads));

			//printf("sum_array_1 = %lld \n\n", find_sum_array(1));
			//printf("sum_array_2 = %lld \n\n", find_sum_array(2));
			//printf("sum_array_3 = %lld \n\n", find_sum_array(3));
			//printf("sum_array_4 = %lld \n\n", find_sum_array(4));
			//printf("sum_array_6 = %lld \n\n", find_sum_array(6));
			//printf("sum_array_8 = %lld \n\n", find_sum_array(8));
			//printf("sum_array_16 = %lld \n\n", find_sum_array(16));
			//printf("sum_array_12 = %lld \n\n", find_sum_array(12));
		}

		#pragma omp section
		{
			printf("min_sum_%d = %lld, index = %d \n\n",num_threads, min_sum_row, min_sum_and_index_row(num_threads));

			//printf("min_sum_1 = %lld, index = %d \n\n", min_sum_row, min_sum_and_index_row(1));
			//printf("min_sum_2 = %lld, index = %d \n\n", min_sum_row, min_sum_and_index_row(2));
			//printf("min_sum_3 = %lld, index = %d \n\n", min_sum_row, min_sum_and_index_row(3));
			//printf("min_sum_4 = %lld, index = %d \n\n", min_sum_row, min_sum_and_index_row(4));
			//printf("min_sum_6 = %lld, index = %d \n\n", min_sum_row, min_sum_and_index_row(6));
			//printf("min_sum_8 = %lld, index = %d \n\n", min_sum_row, min_sum_and_index_row(8));
			//printf("min_sum_12 = %lld, index = %d \n\n", min_sum_row, min_sum_and_index_row(12));
			//printf("min_sum_16 = %lld, index = %d \n\n", min_sum_row, min_sum_and_index_row(16));
		}
	}

	double t2 = omp_get_wtime();
	printf("Total time - %f seconds\n\n", t2 - t1);
	return 0;
}


void initialize_array()
{
	for (int i = 0; i < rows_count; i++)
	{
		for (int j = 0; j < cols_count; j++)
		{
			arr[i][j] = i + j;
		}
	}
}

long long find_sum_array(int num_threads)
{
	long long sum = 0;

	double t1 = omp_get_wtime();

	#pragma omp parallel for reduction(+:sum) num_threads(num_threads)
	for (int i = 0; i < rows_count; i++)
	{
		for (int j = 0; j < cols_count; j++)
		{
			sum += arr[i][j];
		}
	}
	double t2 = omp_get_wtime();
	printf("sum_array_time: %d threads worked - %f seconds\n", num_threads, t2 - t1);

	return sum;
}

int min_sum_and_index_row(int num_threads)
{
	min_sum_row = LLONG_MAX;
	long long min_sum = 0;
	int index = -1;

	double t1 = omp_get_wtime();

	#pragma omp parallel for reduction(+:min_sum) num_threads(num_threads)
	for (int i = 0; i < rows_count; i++)
	{
		for (int j = 0; j < cols_count; j++)
		{
			min_sum += arr[i][j];
		}

		if (min_sum_row > min_sum)
		{
			#pragma omp critical
			if (min_sum_row > min_sum)
			{
				min_sum_row = min_sum;
				index = i;
			}
		}	
	}

	double t2 = omp_get_wtime();
	printf("min_sum_time: %d threads worked - %f seconds\n", num_threads, t2 - t1);

	return index;
}


