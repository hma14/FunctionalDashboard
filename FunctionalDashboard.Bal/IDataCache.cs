namespace FunctionalDashboard.Bal
{
    public interface IDataCache
    {
        void RemoveCachedObject(string key);
        object GetCachedObject(string key);
        void SetCachedObject(string key, object o, int durationSecs);
        void SetCachedObjectSliding(string key, object o, int slidingSecs);
        void SetCachedObjectPermanent(string key, object o);
        
    }
}