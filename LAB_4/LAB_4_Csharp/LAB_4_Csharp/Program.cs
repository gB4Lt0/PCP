using System;
using System.Threading;

namespace LAB_4_Csharp
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int num_of_philosophers = 3;
            Semaphore[] forks = new Semaphore[num_of_philosophers];
            for (int i = 0; i < forks.Length; i++)
            {
                forks[i] = new Semaphore(1, 1);
            }

            int num_of_repetitions = 2;
            int delay_in_reflection = 2000;
            int eatingTime = 2000;

            for (int i = 0; i < num_of_philosophers; i++)
            {
                if (i == num_of_philosophers - 1)
                {
                    Philosopher philosopher = new Philosopher(i,
                                                              forks[i % (num_of_philosophers - 1)],
                                                              forks[i],
                                                              num_of_repetitions,
                                                              delay_in_reflection,
                                                              eatingTime);
                    new Thread(philosopher.Process).Start();
                }
                else
                {
                    Philosopher philosopher = new Philosopher(i,
                                                              forks[i],
                                                              forks[i + 1],
                                                              num_of_repetitions,
                                                              delay_in_reflection,
                                                              eatingTime);
                    new Thread(philosopher.Process).Start();
                }
            }
        }
    }
}
