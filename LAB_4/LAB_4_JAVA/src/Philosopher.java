import java.util.concurrent.Semaphore;
public class Philosopher implements Runnable
{
    private final int _phil_id;
    private final Semaphore _left_fork;
    private final Semaphore _right_fork;
    private final int _num_of_repetitions;
    private final int _time_to_eat;
    private final int _delay_in_reflection;

    public Philosopher(int phil_id, Semaphore left_fork, Semaphore right_fork, int num_of_repetitions, int time_to_eat, int delay_in_reflection)
    {
        _phil_id = phil_id;
        _left_fork = left_fork;
        _right_fork = right_fork;
        _num_of_repetitions = num_of_repetitions;
        _time_to_eat = time_to_eat;
        _delay_in_reflection = delay_in_reflection;
    }

    @Override
    public void run()
    {
        for (int i = 0; i < _num_of_repetitions; i++)
        {
            try
            {
                System.out.println("Philosopher " + _phil_id + " thinking " + i + " time");
                Thread.sleep(_delay_in_reflection);

                _left_fork.acquire();
                System.out.println("Philosopher " + _phil_id + " took left fork");
                _right_fork.acquire();
                System.out.println("Philosopher " + _phil_id + " took right fork");

                System.out.println("Philosopher " + _phil_id + " eating " + i + " time");
                Thread.sleep(_time_to_eat);

                _left_fork.release();
                System.out.println("Philosopher " + _phil_id + " put left fork");
                _right_fork.release();
                System.out.println("Philosopher " + _phil_id + " put right fork");

            }

            catch (InterruptedException e)
            {
                e.printStackTrace();
            }
        }
    }
}
