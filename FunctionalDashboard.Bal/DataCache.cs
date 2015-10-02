﻿using System;
using System.Web;
using System.Web.Caching;

namespace FunctionalDashboard.Bal
{
    public class DataCache
    {
        /// <summary>
        /// remove a cached object from the HttpRuntime.Cache
        /// </summary>
        public static void RemoveCachedObject(string key)
        {
            HttpRuntime.Cache.Remove(key);
        }

        /// <summary>
        /// retrieve an object from the HttpRuntime.Cache
        /// </summary>
        public static object GetCachedObject(string key)
        {
            //object obj = HttpRuntime.Cache[key];
            //if (obj == null)
            //{
            //    RunCaching();
            //}
            //return obj;
            return HttpRuntime.Cache[key];
        }

        /// <summary>
        /// add an object to the HttpRuntime.Cache with an absolute expiration time
        /// </summary>
        public static void SetCachedObject(string key, object o, int durationSecs)
        {
            HttpRuntime.Cache.Add(
                key,
                o,
                null,
                DateTime.Now.AddSeconds(durationSecs),
                Cache.NoSlidingExpiration,
                CacheItemPriority.High,
                null);
        }

        /// <summary>
        /// add an object to the HttpRuntime.Cache with a sliding expiration time. 
        /// sliding means the expiration timer is reset each time the object is accessed, 
        /// so it expires 20 minutes, for example, after it is last accessed.
        /// </summary>
        public static void SetCachedObjectSliding(string key, object o, int slidingSecs)
        {
            HttpRuntime.Cache.Add(
                key,
                o,
                null,
                Cache.NoAbsoluteExpiration,
                new TimeSpan(0, 0, slidingSecs),
                CacheItemPriority.High,
                null);
        }

        /// <summary>
        /// add a non-removable, non-expiring object to the HttpRuntime.Cache
        /// </summary>
        public static void SetCachedObjectPermanent(string key, object o)
        {
            HttpRuntime.Cache.Remove(key);
            HttpRuntime.Cache.Add(
                key,
                o,
                null,
                Cache.NoAbsoluteExpiration,
                Cache.NoSlidingExpiration,
                CacheItemPriority.NotRemovable,
                null);
        }

        //public static void RunCaching(DateTime startDate)
        //{
        //    //Logs.ClearLogs();           
        //    //Logs.StartDate = startDate;

        //    //// Caching Logs.GeneralEventLogs
        //    //var log = Logs.GenerateGeneralEventLog();
        //    //if (log != null && log.Count > 0)
        //    //{
        //    //    DataCache.SetCachedObjectPermanent("GeneralEventLog", log);
        //    //    Logs.LastRefreshed = DateTime.Now;
        //    //}
        //}

        //public static void RunCachingNCSInfo()
        //{           
        //    //// Caching Logs.NCSInfoList
        //    //Logs.NCSInfoList = Logs.PopulateNCSInfo();
        //    //DataCache.SetCachedObjectPermanent("NCSInfo", Logs.NCSInfoList);
        //}

        //private static void RunCaching()
        //{
        //    //Logs.StartDate = DateTime.Today.AddDays(Convert.ToInt16(WebConfigurationManager.AppSettings["Days"]));
        //    //RunCaching(Logs.StartDate);
        //}    
    }
}