using UnityEngine;
using System.Collections;
using System.Collections.Generic;

namespace Common
{
    public class Timer
    {
        //private static TimerEvent te;
        private static List<TimerEvent> timers = new List<TimerEvent>();
           
        
        // Use this for initialization
        public static void Init()
        {
            AppMgr.ON_APP_UPDATE += Update;
        }

        // Update is called once per frame
        static void Update()
        {
         
            for (int i = 0; i < timers.Count; i++)
            {
                TimerEvent e = timers[i];
                e.Update();
                if (e.IsDone)
                {
                    e.CompleteTimer();
                    if (e.IsDone)
                    {
                        timers.Remove(e);
                    }
                }
            }

        }
       /// <summary>
       ///暂时不用
       /// </summary>
       /// <param name="timername"></param>
       /// <returns></returns>
        public static bool GetTimerName(string timername)
        {
            for (int i = 0; i < timers.Count; i++)
            {
                var e = timers[i];
                if (e.timerName == timername)
                {
                    Log.Info("[timerName]{0}", e.timerName);
                    return true;
                }
            }
            Log.Info("[Get Timer Exception not find ->]{0}", timername + "<-");
                return false;
          

        }
        /// <summary>
        /// 添加一个Timer
        /// </summary>
        /// <param name="spaceTimer">间隔时间</param>
        /// <param name="callBackCount">重复调用次数</param>
        /// <param name="callBack">回调函数</param>
        /// <param name="objs">回调函数参数</param>
        /// <returns></returns>
        private static TimerEvent AddTimer(float spaceTimer ,int callBackCount, TimerCallBack callBack,params object[] objs)
        {
            TimerEvent te = new TimerEvent();
            te.ResTimer();
            te.spaceTimer = spaceTimer;
            te.repeatCount = callBackCount;
            te.callback =callBack;
            te.timerName = "";
            timers.Add(te);
            return te;
        }
     /// <summary>
     ///延迟调用函数
     /// </summary>
     /// <param name="spaceTimer">延迟调用时间</param>
     /// <param name="callBack">回调函数</param>
     /// <param name="objs">回调函数参数</param>
     /// <returns></returns>
        public static TimerEvent DelayCallBack(float spaceTimer,TimerCallBack callBack,params object[] objs)
        {
            return AddTimer(spaceTimer,1, callBack, objs);
        }
        /// <summary>
        /// 间隔一定时间有限次数重复调用
        /// </summary>
        /// <param name="spaceTimer">间隔时间</param>
        /// <param name="callBackCount">重复调用次数</param>
        /// <param name="callBack">回调函数</param>
        /// <param name="objs">回调函数参数</param>
        /// <returns></returns>
        public static TimerEvent CallBackOfIntervalTimer(float spaceTimer,int callBackCount,TimerCallBack callBack,params object[]objs)
        {
            return AddTimer(spaceTimer, callBackCount, callBack, objs);
        }
        /// <summary>
        /// 间隔一定时间重复调用
        /// </summary>
        /// <param name="spaceTimer">间隔时间</param>
        /// <param name="callBack">回调函数</param>
        /// <param name="objs">回调函数参数</param>
        /// <returns></returns>
        public static TimerEvent RepeatCallBack(float spaceTimer,TimerCallBack callBack,params object[]objs)
        {
            return AddTimer(spaceTimer, -1, callBack, objs);
        }
        public static void ResetTimer(TimerEvent timer)
        {
            if (timers.Contains(timer))
            {
                timer.ResTimer();
            }
            else
            {
                Log.LogError(" Timer DontResetTimer error:dont exit timer" + timer);
            }
            
        }

        public static void StopTimer(TimerEvent timer, bool needCallBack = false)
        {
            if (timers.Contains(timer))
            {
                if (needCallBack)
                    timer.callback.Invoke();
                timers.Remove(timer);
            }
                
        }

        public static void StopAllTimer()
        {
            foreach (var timer in timers)
            {
                StopTimer(timer);
            }
            timers.Clear();
        }
    }

}