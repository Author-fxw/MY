using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace Common
{/// <summary>
/// 日志类
/// </summary>
    public class Log
    {/// <summary>
    /// debug级打印日志
    /// </summary>
    /// <param name="log">日志内容</param>
        public static void Debug(string log)
        {
            UnityEngine.Debug.Log(log);
        }
        /// <summary>
        /// debug info级日志
        /// </summary>
        /// <param name="format">日志内容</param>
        /// <param name="args">带参数</param>
        public static void Info(string format,params object[] args)
        {
            UnityEngine.Debug.LogFormat(format, args);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="format"></param>
        public static void Info(string format)
        {
            UnityEngine.Debug.Log(format);
        }
        /// <summary>
        /// 警告及日志
        /// </summary>
        /// <param name="message">警告信息</param>
        public static void LogWarring(object message)
        {
            UnityEngine.Debug.LogWarning(message);
        }
        /// <summary>
        ///警告级日志、带参数
        /// </summary>
        /// <param name="format">警告信息</param>
        /// <param name="args">参数</param>
        public static void LogWarring(string format,params object[]args)
        {
            UnityEngine.Debug.LogWarningFormat(format, args);
        }
        /// <summary>
        /// 错误级日志
        /// </summary>
        /// <param name="message"></param>
        public static void LogError(object message)
        {
            UnityEngine.Debug.LogError(message);

        }
        /// <summary>
        /// 错误级日志、带参数
        /// </summary>
        /// <param name="meaasge">错误信息</param>
        /// <param name="args">参数</param>
        public static void LogError(string meaasge,params object[]args)
        {
            UnityEngine.Debug.LogErrorFormat(meaasge, args);
        }
       
    }
}
   
