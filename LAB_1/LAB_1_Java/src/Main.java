public class Main {
    public static void main(String[] args)
    {
        Counter[] counters =
                {
                        new Counter(1, 1L, 1000),
                        new Counter(2, 2L, 2000),
                        new Counter(3, 4L, 5000),
                        new Counter(4, 6L, 4000),
                        new Counter(5, 8L, 7000),
                        new Counter(6, 12L, 3000),
                        new Counter(7, 16L, 6000),
                        new Counter(8, 32L, 8000),
                };

        Thread[] threads = new Thread[counters.length];
        ThreadBreaker threadBreaker = new ThreadBreaker(counters);

        for (int i = 0; i < counters.length; i++)
        {
            threads[i] = new Thread(counters[i]);
            threads[i].start();
        }
        new Thread(threadBreaker).start();
    }
}