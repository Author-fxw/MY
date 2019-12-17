using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Common;
using UnityEngine.UI;
using System;

namespace Test
{
public class EmailLayer:MyUIBase
{

        //public InputField inputText;
        public void Awake()
        {
           
            ///需要监听的事件添加到事件字典当中
            _eventdic = new Dictionary<Enum, EventCallBack>()
            {
                { Eventenum.EmailLayer,EamilHandel },
            };
        }
        protected override void Start()
        {
            UIMgr.PlayOpenUI(gameObject);
        }
        private void EamilHandel(object[] args)
        {
            Debug.Log("出发事件回调函数");
        }
    }

}

