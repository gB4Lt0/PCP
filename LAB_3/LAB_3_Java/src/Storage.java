import java.util.ArrayList;
import java.util.concurrent.Semaphore;

public class Storage {

    private Semaphore access;
    private Semaphore full;
    private Semaphore empty;

    private ArrayList<String> _storage = new ArrayList<>();

    public Storage(int size)
    {
        access= new Semaphore(1);
        full = new Semaphore(size);
        empty = new Semaphore(0);
    }

    public String getItem()
    {
        return _storage.get(0);
    }

    public void addItem(String item)
    {
        _storage.add(item);
    }

    public void removeItem()
    {
        _storage.remove(0);
    }

    public void acquireAccess() throws InterruptedException
    {
        access.acquire();
    }

    public void releaseAccess()
    {
        access.release();
    }

    public void acquireEmpty() throws InterruptedException
    {
        empty.acquire();
    }

    public void releaseEmpty()
    {
        empty.release();
    }

    public void acquireFull() throws InterruptedException
    {
        full.acquire();
    }

    public void releaseFull()
    {
        full.release();
    }
}
