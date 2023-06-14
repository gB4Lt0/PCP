using System.Collections.Generic;
using System.Linq;
using System.Threading;

namespace LAB_3_Csharp
{
    internal class Storage
    {
        public Semaphore access;
        public Semaphore full;
        public Semaphore empty;

        private List<string> _storage = new List<string>();
        private int _storageSize;

        public Storage(int storageSize)
        {
            access = new Semaphore(1, 1);
            full = new Semaphore(storageSize, storageSize);
            empty = new Semaphore(0, storageSize);
            _storageSize = storageSize;
        }

        public string GetItem()
        {
            return _storage.ElementAt(0);
        }

        public void AddItem(string item)
        {
            _storage.Add(item);
        }

        public void RemoveItem()
        {
            _storage.RemoveAt(0);
        }

        public void AcquireAccess()
        {
            access.WaitOne();
        }

        public void ReleaseAccess()
        {
            access.Release();
        }

        public void AcquireEmpty()
        {
            empty.WaitOne();

        }

        public void ReleaseEmpty()
        {
            empty.Release();
        }

        public void AcquireFull()
        {
            full.WaitOne();

        }

        public void ReleaseFull()
        {
            full.Release();
        }
    }
}
