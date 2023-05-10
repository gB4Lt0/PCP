import java.util.Random;
public class Main {
    public static void main(String[] args)
    {
        int lenghtOfArray = 100000000;
        int numOfThreads = 4;
        Integer[] array = ArrayFiller(lenghtOfArray);

        ArrayDivider minElement = new ArrayDivider(array, numOfThreads);
        minElement.ArrayDivider();

        System.out.println("Min number of array: " + minElement.GetMinNumber());
        System.out.println("Index: " + minElement.GetIndexMinNumber());

    }



    private static Integer[] ArrayFiller(int lenghtOfArray)
    {
        Integer[] array = new Integer[lenghtOfArray];

        Random random = new Random();
        for (int i = 0; i < lenghtOfArray; i++)
        {
            //array[i] = i;
            array[i] = random.nextInt(237946294);
        }

        array[random.nextInt(lenghtOfArray)] *= -1;
        //array[random.nextInt(lenghtOfArray)] = -1000;

        return array;
    }
}