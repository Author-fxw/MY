using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Common;
namespace Test
{
public class LoginClick:UIClick<LoginLayer>
{
        public void BtnCloseClick()
        {
            CloseUI();///子类调用父类中虚方法
            Common.Log.Info("[closeUI]");
            //_Layer.RemovEvent();
            //UIMgr.PlayCloseUI(gameObject);
           
        }      
        /// <summary>
        /// 保存按钮
        /// </summary>
        public void SaveBtn()
        {
            Common.Log.Info("[SaveBtn:]");
            _Layer.Save();
        }
       
}
}

