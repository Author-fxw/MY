using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
namespace Common
{
    public delegate void EventCallBack(params object[] args);

    public class MyGlobalEvent 
    {
        /// <summary>
        /// 以Enum为key的事件派发
        /// </summary>
        private static  Dictionary<Enum, EventCallBack> _eventdic = new Dictionary<Enum, EventCallBack>();
        private static Dictionary<Enum, List<EventCallBack>> _useOnceEventDic = new Dictionary<Enum, List<EventCallBack>>();
        /// <summary>
        /// 添加事件和回调
        /// </summary>
        /// <param name="type"></param>
        /// <param name="callback"></param>
        public static void AddEvent(Enum type,EventCallBack callback,bool isUseOnce =false)
        {
            if (isUseOnce)
            {
                if (_useOnceEventDic.ContainsKey(type))
                {
                    if (!_useOnceEventDic[type].Contains(callback))
                        _useOnceEventDic[type].Add(callback);
                    else
                        Debug.Log("already existing EventType: " + type + " handle: " + callback);
                }
                else
                {
                    List<EventCallBack> temp = new List<EventCallBack>
                    {
                        callback
                    };
                    _useOnceEventDic.Add(type, temp);
                }
            }
            else
            {
                if (_eventdic.ContainsKey(type))
                {
                    Debug.Log("Events already exist (CallbackPrm)");
                    _eventdic[type] += callback;

                }
                else
                {
                    _eventdic.Add(type, callback);
                }
            }
            
            
        }
        /// <summary>
        /// 移除某类事件的回调
        /// </summary>
        /// <param name="type"></param>
        /// <param name="callback"></param>
        public static void RemoveEvent(Enum type,EventCallBack callback)
        {
            if (_useOnceEventDic.ContainsKey(type))
            {
                if (_useOnceEventDic[type].Contains(callback))
                {
                    _useOnceEventDic[type].Remove(callback);
                    if (_useOnceEventDic[type].Count == 0)
                    {
                        _useOnceEventDic.Remove(type);
                    }
                }
            }
            if (_eventdic.ContainsKey(type))
            {
                _eventdic[type] -= callback;
            }
        }
        /// <summary>
        /// 移除某类事件
        /// </summary>
        /// <param name="type"></param>
        public static void RemoveEvent(Enum type)
        {
            if (_useOnceEventDic.ContainsKey(type))
            {
                _useOnceEventDic.Remove(type);
            }

            if (_eventdic.ContainsKey(type))
            {
                _eventdic.Remove(type);
            }
        }
        /// <summary>
        ///触发事件 
        /// </summary>
        /// <param name="type"></param>
        /// <param name="args"></param>
        public static void DispatchEvent(Enum type,params object[] args)
        {
            if (_eventdic.ContainsKey(type))
            {
                try
                {
                    //_eventdic[type]?.Invoke(args);///c#6新语法，空值传播运算符
                    if (_eventdic[type] != null)
                    {
                        _eventdic[type](args);
                    }
                }
                catch (Exception e)
                {
                    Debug.Log(e.ToString());
                   
                }

            }
            if (_useOnceEventDic.ContainsKey(type))
            {
                for (int i = 0; i < _useOnceEventDic[type].Count; i++)
                {
                    //遍历委托链表
                    foreach (EventCallBack callBack in _useOnceEventDic[type][i].GetInvocationList())
                    {
                        try
                        {
                            callBack(args);
                        }
                        catch (Exception e)
                        {
                            Debug.Log(e.ToString());
                        }
                    }
                }
                RemoveEvent(type);
            }
        }
        /// <summary>
        /// 移除所有事件
        /// </summary>
        public static void RemoveAllEvent()
        {
            _eventdic.Clear();
        }

    }
}

