public class Consumer implements Runnable
{
    private final int _maxItem;
    private final Storage _storage;

    public Consumer(int maxItem, Storage storage)
    {
        _maxItem = maxItem;
        _storage = storage;
    }

    @Override
    public void run()
    {
        for (int i = 0; i < _maxItem; i++)
        {
            String item;
            try
            {
                _storage.acquireEmpty();
                Thread.sleep(1000);
                _storage.acquireAccess();

                item = _storage.getItem();
                _storage.removeItem();
                System.out.println("Took " + item);

                _storage.releaseAccess();
                _storage.releaseFull();

            }
            catch (InterruptedException e)
            {
                e.printStackTrace();
            }
        }
    }
}
