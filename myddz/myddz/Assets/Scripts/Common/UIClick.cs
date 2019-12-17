using System.Collections;
using System.Collections.Generic;
using Test;
using UnityEngine;
namespace Common
{
   /// <summary>
   /// UI点击事件的封装
   /// </summary>
   /// <typeparam name="T"></typeparam>
public class UIClick<T> : MonoBehaviour
{
        private T _layer;
        protected T _Layer
        {
            get
            {
                if (_layer == null)
                    _layer = GetComponent<T>();
                return _layer;
            }
        }
        protected void Awake()
        {
            Init();
        }
        protected void Init()
        {
            _layer = GetComponent<T>();
        }
        public virtual void OpenUI()
        {
            
            UIMgr.PlayOpenUI(gameObject);
        }
        public virtual void CloseUI(CallBack callback=null)
        {

            UIMgr.PlayCloseUI(gameObject,callback);
        }
    }

}

