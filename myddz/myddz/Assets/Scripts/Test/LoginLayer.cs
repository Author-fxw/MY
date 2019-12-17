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
        public Text tex;
        public InputField inputText;
        private LoginClick _loginClick;
        public int TotalTime = 10;//总时间
        public Text CountDown;//协成实现的倒计时
        public Text updateTime;//当前时间
        private float timer;
        private LoginClick _LoginClick
        {
            get
            {
                if (_loginClick==null)
                {
                    _loginClick = transform.GetComponent<LoginClick>();
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
            init();
            MyGlobalEvent.DispatchEvent(Eventenum.LoginLayer);
            StartCoroutine(UpdateTime());///开启协程

            UIMgr.PlayOpenUI(gameObject);
        }
        public void Update()
        {
            timer += Time.deltaTime;
            if (TotalTime >0)
            {
                if (timer>=1.0f)
                {
                    TotalTime--;
                    updateTime.text = TotalTime.ToString();
                    timer = 0;
                }
            }
            else { TotalTime = 0; }
            
        }
        /// <summary>
        /// 在携程中的倒计时，其执行顺序在UPdate之后
        /// </summary>
        /// <returns></returns>
        IEnumerator UpdateTime()
        {
            while (TotalTime >= 0)
            {
                CountDown.text = TotalTime.ToString();
                yield return new WaitForSeconds(1);
                TotalTime--;
            }
        }
        public void init()
        {
          
           string str = PlayerPrefs.GetString("NickName");
            tex.text = str;
           
        }
        public void Save()
        {
            //Debug.Log(inputText.text);
            string strNickName= StringUtils.CheckNickName(inputText.text);
            if (strNickName=="")
            {
                PlayerPrefs.SetString("NickName", inputText.text);
                string str = PlayerPrefs.GetString("NickName");
                tex.text = str;
                Tip.Show("修改成功");
                return;
            }        
            else
            { 
                Tip.Show(strNickName);
            }
            ///测试事件字典
            Common.Log.Info("字典大小::{0}", _eventdic.Count);
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

