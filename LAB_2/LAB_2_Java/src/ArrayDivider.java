public class ArrayDivider
{
    private final Integer[] _array;
    public Integer[] GetArray()
    {
        return _array;
    }
    private final Integer _numOfThreads;
    private final Thread[] _threads;
    private Integer _minNumber;
    private Integer _indexMinNumber;
    public Integer GetMinNumber() {
        return _minNumber;
    }
    public Integer GetIndexMinNumber() {
        return _indexMinNumber;
    }

    public ArrayDivider(Integer[] array, Integer numOfThreads) {
        _array = array;
        _numOfThreads = numOfThreads;
        _threads = new Thread[numOfThreads];
        _minNumber = Integer.MAX_VALUE;
        _indexMinNumber = 0;
    }

    public void ArrayDivider()
    {
        int arraySegment = _array.length / _numOfThreads;

        for (int i = 0; i < _numOfThreads; i++)
        {
            Integer startOfSegment, endOfSegment;
            startOfSegment = arraySegment * i;
            endOfSegment = i == _numOfThreads - 1 ? _array.length : arraySegment * (i + 1);

            MinElementFinder finder = new MinElementFinder(startOfSegment, endOfSegment, this);
            _threads[i] = finder;
            _threads[i].start();
        }

        for (int i = 0; i < _numOfThreads; i++)
        {
            try {
                _threads[i].join();
            } catch (InterruptedException e) {

            }
        }
    }
    public synchronized void ChangeMinNumber(Integer minNumber, Integer indexMinNumber)
    {
        if(minNumber < _minNumber)
        {
            _minNumber = minNumber;
            _indexMinNumber = indexMinNumber;
        }
    }
}
