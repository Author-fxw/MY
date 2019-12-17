using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Common;
using System;

namespace Common
{
   /// <summary>
   /// UI的基类
   /// </summary>
public class MyUIBase : MonoBehaviour
{
        protected static  Dictionary<Enum, EventCallBack> _eventdic;
        /// <summary>
        ///一些初始化操作
        /// </summary>
        protected virtual void Start()
        {
            ////
            InitEvent();
        }
        /// <summary>
        /// 添加自定义事件监听、需要在子类中显示调用
        /// </summary>
        protected void InitEvent()
        {
            if (_eventdic == null)
                return;
                foreach (KeyValuePair < Enum, EventCallBack> kv in _eventdic)
                {
                    MyGlobalEvent.AddEvent(kv.Key, kv.Value);
                }
            

        }
        /// <summary>
        /// 移除自定义事件监听
        /// </summary>
        protected void DestroyEvent()
        {
            if (_eventdic == null) return;
            foreach (KeyValuePair<Enum, EventCallBack> kv in _eventdic)
            {
                MyGlobalEvent.RemoveEvent(kv.Key, kv.Value);
            }
        }
    }

}
