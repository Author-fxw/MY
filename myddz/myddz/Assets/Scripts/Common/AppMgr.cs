using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace Common
{
    /// <summary>
    /// 游戏入口
    /// </summary>
    public class AppMgr : MonoBehaviour
    {
        private static AppMgr _instance;
        public static AppMgr Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = FindObjectOfType<AppMgr>();

                }
                return _instance;
            }
            set { _instance = value; }
        }
        void Awake()
        {
            DontDestroyOnLoad(gameObject);
            AppLaunch();
        }
        void Update()
        {
           
            //ON_APP_UPDATE?.Invoke();
            if (ON_APP_UPDATE != null)
            {
                ON_APP_UPDATE.Invoke();
            }
        }
        void FixedUpdate()
        {
            //ON_APP_FIXEDUPDATE?.Invoke();
            if (ON_APP_FIXEDUPDATE!=null)
            {
                ON_APP_FIXEDUPDATE.Invoke();
            }
        }
        void OnGUI()
        {
            //ON_APP_ONGUI?.Invoke();
            if (ON_APP_ONGUI!=null)
            {
                ON_APP_ONGUI.Invoke();
            
            }
        }
        public void AppLaunch()
        {
            Tip.Init();
            MFPSCounter.Init();
            Timer.Init();
        }
        public static string Verssion()
        {
            return Application.version;
        }
        #region 程序生命周期事件派发
        public delegate void VoidDelegate();

        public static VoidDelegate ON_APP_START = null;
        public static VoidDelegate ON_APP_UPDATE = null;
        public static VoidDelegate ON_APP_FIXEDUPDATE = null;
        public static VoidDelegate ON_APP_ONGUI = null;

        #endregion

    }

}
   
