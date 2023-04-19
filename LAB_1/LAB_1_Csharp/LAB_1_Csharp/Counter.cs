using System;

namespace LAB_1_Csharp
{
    public class Counter : IComparable<Counter>
    {
        private int _id;
        private long _step;
        public int TimeOfWorking { get; set; }
        public bool CanStop { get; set; }

        public Counter(int id, long step, int timeOfWork)
        {
            _id = id;
            _step = step;
            TimeOfWorking = timeOfWork;
            CanStop = false;
        }
        public int CompareTo(Counter other)
        {
            return TimeOfWorking.CompareTo(other.TimeOfWorking);
        }

        public void CounterOfSumAndItems()
        {
            long sumOfSequence = 0;
            long itemsUsed = 0;

            do
            {
                sumOfSequence += _step;
                itemsUsed++;

            } while (!CanStop);

            Console.WriteLine($"ID: {_id} || sumOfSequence: {sumOfSequence} || itemsUsed: {itemsUsed}");
        }

        public void Switch()
        {
            CanStop = true;
        }
    }
}
