using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Common;
namespace Test
{
public class LoginLayerClick:UIClick<LoginLayer>
{
        public void BtnCloseClick()
        {
            CloseUI();///子类调用父类中虚方法
            Common.Log.Info("[closeUI]");
            //_Layer.RemovEvent();
            //UIMgr.PlayCloseUI(gameObject);        
        }      
      
       
}
}

