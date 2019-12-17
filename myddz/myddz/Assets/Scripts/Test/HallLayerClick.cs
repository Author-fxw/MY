using UnityEngine;
using System.Collections;
namespace Common
{
    public class HallLayerClick:UIClick<HallLayer>
    {
        /// <summary>
        /// 登录层
        /// </summary>
        public void BtnClick()
        {
            //public static T Instantiate<T>(T original) where T : Object;

            GameObject res = (GameObject)Resources.Load("Prefab/LoginLayer");
            GameObject layer = Object.Instantiate(res);
            UIMgr.SetSenter(layer);
            Common.Log.Info("[Prefab/loginlayer:]");

        }
        /// <summary>
        /// 邮件按钮、打开邮件层
        /// </summary>
        public void eamailBtn()
        {
            //OpenUI();//public static T Instantiate<T>(T original) where T : Object;
            //GameObject res = (GameObject)Resources.Load("Prefab/EmailLayer");
            //GameObject layer = Object.Instantiate(res);
            //UIMgr.SetSenter(layer);
            //Common.Log.Info("[Prefab/EmailLayer]");

            string version = AppMgr.Verssion();
            version = string.Format("版本号：version：{0}", version);

        }
        // Update is called once per frame
        void Update()
        {

        }
    }


}
