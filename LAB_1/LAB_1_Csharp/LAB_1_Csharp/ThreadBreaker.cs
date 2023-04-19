using System;
using System.Threading;

namespace LAB_1_Csharp
{
    public class ThreadBreaker
    {
        private Counter[] _counters;
        public ThreadBreaker(Counter[] counters)
        {
            _counters = counters;
            Array.Sort(counters);
        }

        public void Stop()
        {
            int currentWaitedTime = 0;

            for (int i = 0; i < _counters.Length; i++)
            {
                int waitingTime = _counters[i].TimeOfWorking - currentWaitedTime;
                Thread.Sleep(waitingTime);
                currentWaitedTime += waitingTime;
                _counters[i].Switch();
            }
        }
    }
}
