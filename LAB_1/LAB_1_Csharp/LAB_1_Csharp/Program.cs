using System;
using System.Threading;

namespace LAB_1_Csharp
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Counter[] counters =
            {
                new Counter(1, 1, 1000),
                new Counter(2, 2, 2000),
                new Counter(3, 4, 5000),
                new Counter(4, 6, 4000),
                new Counter(5, 8, 7000),
                new Counter(6, 12, 3000),
                new Counter(7, 16, 6000),
                new Counter(8, 32, 8000),
            };

            Thread[] threads = new Thread[counters.Length];
            ThreadBreaker threadBreaker = new ThreadBreaker(counters);

            for (int i = 0; i < counters.Length; i++)
            {
                threads[i] = new Thread(counters[i].CounterOfSumAndItems);
                threads[i].Start();
            }
            new Thread(threadBreaker.Stop).Start();
        }
    }
}
