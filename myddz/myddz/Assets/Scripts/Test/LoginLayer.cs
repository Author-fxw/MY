using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Common;
using UnityEngine.UI;
using System;

namespace Test
{
public class LoginLayer:MyUIBase
{
        [Header("==========登录层===========")]

        public Button LoginBtn;
        public InputField AccountInputText;
        public InputField PassWordInpitText;
        private LoginLayerClick _loginClick;
      
        private LoginLayerClick _LoginClick
        {
            get
            {
                if (_loginClick==null)
                {
                    _loginClick = transform.GetComponent<LoginLayerClick>();
                }
                return _loginClick;
            }
        }
       public  void Awake()
        {           
            //Common.Log.Info("初始化 tip窗口");
            _eventdic = new Dictionary<Enum, EventCallBack>()
            {
                { Eventenum.LoginLayer,loginLayer },
            };          
        }
        protected override void Start()
        {
            base.InitEvent();
          
            MyGlobalEvent.DispatchEvent(Eventenum.LoginLayer);
            UIMgr.PlayOpenUI(gameObject);
        }
     







        private void loginLayer( object[] args)
        {
            Common.Log.Debug("触发事件回调函数");
        }
        public void RemovEvent()
        {
            base.DestroyEvent();
        }
       

}

}

