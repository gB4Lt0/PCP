public class Counter extends Thread implements Comparable<Counter>
{
    private Integer _id;
    private Long _step;
    public Integer _timeOfWorking;
    public Integer getTimeOfWork()
    {
        return _timeOfWorking;
    }
    private  Boolean _canStop;

    public Counter(Integer id, Long step, Integer timeOfWorking)
    {
        _id = id;
        _step = step;
        _timeOfWorking = timeOfWorking;
        _canStop = false;
    }

    @Override
    public int compareTo(Counter o)
    {
        return _timeOfWorking.compareTo(o._timeOfWorking);
    }

    @Override
    public void run()
    {
        Long sumOfSequence = 0l;
        Long itemsUsed = 0l;

        do {
            sumOfSequence += _step;
            itemsUsed++;
        }while (!_canStop);

        System.out.println("ID: " + _id + " || sumOfSequence: " + sumOfSequence + " || itemsUsed: " + itemsUsed);
    }

    public void Switch()
    {
        _canStop = true;
    }
}
