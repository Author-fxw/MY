using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Common;
using UnityEngine.UI;
using System;

namespace Test
{
public class EmailLayerClick: UIClick<EmailLayer>
    {

        //public InputField inputText;
      
        public void BtnCloseClick()
        {
            CloseUI();
            Common.Log.Info("[closeUI]");
            //_Layer.RemovEvent();
          
        }
        //private void EamilHandel(object[] args)
        //{
        //    Debug.Log("出发事件回调函数");
        //}
    }

}

