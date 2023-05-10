public class MinElementFinder extends Thread {
    private Integer startOfSegment, endOfSegment;
    private final ArrayDivider _minElement;
    public MinElementFinder(Integer startOfSegment, Integer endOfSegment, ArrayDivider minElement)
    {
        this.startOfSegment = startOfSegment;
        this.endOfSegment = endOfSegment;
        _minElement = minElement;
    }

    @Override
    public void run()
    {
        var arr = _minElement.GetArray();
        Integer minNumber = arr[startOfSegment];
        Integer indexNumber = startOfSegment;

        for (Integer i = startOfSegment + 1; i < endOfSegment; i++)
        {
            if(minNumber > arr[i])
            {
                minNumber = arr[i];
                indexNumber = i;
            }
        }
        _minElement.ChangeMinNumber(minNumber, indexNumber);
    }
}