using System;

namespace LAB_3_Csharp
{
    internal class Producer
    {
        private int _maxItem = 0;
        private Storage _storage;
        public Producer(int maxItem, Storage storage)
        {
            _maxItem = maxItem;
            _storage = storage;
        }

        public void PutItem()
        {
            for (int i = 0; i < _maxItem; i++)
            {
                _storage.AcquireFull();
                _storage.AcquireAccess();

                _storage.AddItem("item " + i);
                Console.WriteLine("Added item " + i);

                _storage.ReleaseAccess();
                _storage.ReleaseEmpty();

            }
        }
    }
}
