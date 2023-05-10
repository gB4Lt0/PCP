using System.Threading;

namespace LAB_2_Csharp
{
    public partial class MinElementFinder
    {
        private readonly int[] _array;
        private readonly int _numOfThreads;
        private readonly Thread[] _threads;
        private object _lockObject;
        private int _minNumber;
        private int _indexMinNumber;

        public int MinNumber => _minNumber;
        public int IndexMinNumber => _indexMinNumber;

        public MinElementFinder(int[] array, int numOfThreads)
        {
            _array = array;
            _minNumber = int.MaxValue;
            _lockObject = new object();
            _numOfThreads = numOfThreads;
            _threads = new Thread[numOfThreads];
        }

        public void ArrayDivider()
        {
            int arraySegment = _array.Length / _numOfThreads;

            for (int i = 0; i < _numOfThreads; i++)
            {
                int startOfSegment, endOfSegment;
                startOfSegment = arraySegment * i;
                endOfSegment = i == _numOfThreads - 1 ? _array.Length : arraySegment * (i + 1);

                _threads[i] = new Thread(() => FindMinNumber(startOfSegment, endOfSegment));

                _threads[i].Start();
            }

            for (int i = 0; i < _numOfThreads; i++)
            {
                _threads[i].Join();
            }
        }

        public void FindMinNumber(int startOfSegment, int endOfSegment)
        {
            int minNumber = _array[startOfSegment];
            int indexMinNumber = startOfSegment;

            for (int i = startOfSegment + 1; i < endOfSegment; i++)
            {
                if (minNumber > _array[i])
                {
                    minNumber = _array[i];
                    indexMinNumber = i;
                }
            }

            lock (_lockObject)
            {
                if (minNumber < _minNumber)
                {
                    _minNumber = minNumber;
                    _indexMinNumber = indexMinNumber;
                }
            }
        }
    }
}
