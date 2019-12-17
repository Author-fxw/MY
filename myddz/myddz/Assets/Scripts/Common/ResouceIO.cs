using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace Common
{
    public class ResouceIO
    {
        /// <summary>
        /// 资源加载路径
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="path"></param>
        /// <returns></returns>
        public static T GetResByPath<T>(string path)where T:UnityEngine.Object
        {
            return Resources.Load(path) as T;
        }
    }
}
   
