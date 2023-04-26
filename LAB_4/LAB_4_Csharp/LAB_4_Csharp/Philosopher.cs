using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace LAB_4_Csharp
{
    internal class Philosopher
    {
        private int _phil_id;
        private Semaphore _left_fork;
        private Semaphore _right_fork;
        private int _num_of_repetitions;
        private int _time_to_eat;
        private int _delay_in_reflection;

        public Philosopher(int phil_id, Semaphore left_fork, Semaphore right_fork, int num_of_repetitions, int time_to_eat, int delay_in_reflection)
        {
            _phil_id = phil_id;
            _left_fork = left_fork;
            _right_fork = right_fork;
            _num_of_repetitions = num_of_repetitions;
            _time_to_eat = time_to_eat;
            _delay_in_reflection = delay_in_reflection;
        }

        public void Process()
        {
            for (int i = 0; i < _num_of_repetitions; i++)
            {
                Console.WriteLine($"Philosopher_ID: {_phil_id} || thinking {i} time");
                Thread.Sleep(_delay_in_reflection);

                _left_fork.WaitOne();
                Console.WriteLine($"Philosopher_ID: {_phil_id} || took left fork");
                _right_fork.WaitOne();
                Console.WriteLine($"Philosopher_ID: {_phil_id} || took right fork");

                Console.WriteLine($"Philosopher_ID: {_phil_id} || eating {i} time");
                Thread.Sleep(_time_to_eat);


                _left_fork.Release();
                Console.WriteLine($"Philosopher_ID: {_phil_id} || put left fork");
                _right_fork.Release();
                Console.WriteLine($"Philosopher_ID: {_phil_id} || put right fork");
                
            }
        }
    }
}
