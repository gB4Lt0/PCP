import java.util.concurrent.Semaphore;
public class Main
{
    public static void main(String[] args)
    {
        int num_of_philosophers = 5;
        Semaphore[] forks = new Semaphore[num_of_philosophers];

        for (int i = 0; i < forks.length; i++)
        {
            forks[i] = new Semaphore(1);
        }

        int num_of_repetitions = 2;
        int delay_in_reflection = 2000;
        int eatingTime = 2000;

        for (int i = 0; i < num_of_philosophers; i++)
        {
            Philosopher philosopher;
            if (i == num_of_philosophers-1)
            {
                philosopher = new Philosopher(i,
                        forks[i % (num_of_philosophers - 1)],
                        forks[i],
                        num_of_repetitions,
                        delay_in_reflection,
                        eatingTime);
            }
            else
            {
                philosopher = new Philosopher(i,
                        forks[i],
                        forks[i + 1],
                        num_of_repetitions,
                        delay_in_reflection,
                        eatingTime);
            }
            new Thread(philosopher).start();
        }
    }
}