using System;

namespace LAB_2_Csharp
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int lenghtOfArray = 1000000000;
            int numOfThreads = 8;
            int[] array = ArrayFiller(lenghtOfArray);

            MinElementFinder minElementFinder = new MinElementFinder(array, numOfThreads);
            minElementFinder.ArrayDivider();

            Console.WriteLine($"Min number of array: {minElementFinder.MinNumber}");
            Console.WriteLine($"Index this number: {minElementFinder.IndexMinNumber}");
        }

        private static int[] ArrayFiller(int lenghtOfArray) 
        {
            int[] array = new int[lenghtOfArray];

            Random random = new Random();
            for (int i = 0; i < lenghtOfArray; i++)
            {
                array[i] = random.Next();
                //array[i] = i;

            }

            array[random.Next(lenghtOfArray)] *= -1;
            //array[random.Next(lenghtOfArray)] = -10000;


            return array;
        }
    }
}
