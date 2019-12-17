using UnityEngine;
using System.Collections;
namespace Common
{/// <summary>
/// 定时器事件
/// </summary>
    public class TimerEvent
    {
        
     
        public int repeatCount = 0;//重复调用的次数 -1代表一直调用
        public int currentRepeat = 0;//当前重复调用次数

        public object[] objs;
        public float spaceTimer;//时间间隔
        public float currentTimer = 0;///当前走了多长时间

        public bool IsDone = false;///是否完成一个周期
        public bool IsStop = false;//是否停止
        public TimerCallBack callback;

        public string timerName = "";
        public static void Init()
        {
            
        }

        // Update is called once per frame
         public void Update()
        {
            currentTimer += Time.deltaTime;
            if (currentTimer>spaceTimer)
            {
                IsDone = true;
            }
          
        }
        public void CompleteTimer()
        {
            //callback?.Invoke(objs);
            if (callback!=null)
            {
                callback.Invoke(objs);
            }
            if (repeatCount>0)
            {
                currentRepeat++;
            }
            if (currentRepeat!= repeatCount)
            {
                IsDone = false;
                currentTimer = 0;
            }
        }
        public void ResTimer()
        {
            currentTimer = 0;
            repeatCount = 0;
        }
        public void OnPop()
        {
            currentTimer = 0;
            repeatCount = 0;
            callback = null;
            objs = null;
            spaceTimer = 0;
            IsDone = false;
            IsStop = false;
            timerName = "";
        }
        public void OnPush()
        {
            IsStop = true;
        }
    }


   
}

