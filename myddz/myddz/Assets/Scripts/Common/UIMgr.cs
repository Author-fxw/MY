using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;
/// <summary>
/// ui 显示控制
/// </summary>
namespace Common
{
public class UIMgr 
{
       protected  static readonly Vector3 ScaleVlue=new Vector3(0.1f, 0.1f, 0.1f);
        /// <summary>
        /// ui 设置在屏幕中间
        /// </summary>
        public static void SetSenter(GameObject ui)
        {
            ui.transform.SetParent(GameObject.Find("Canvas").transform, false);
            ui.transform.GetComponent<RectTransform>().localPosition = Vector3.zero;
        }
        /// <summary>
        /// 打开界面
        /// </summary>
        /// <param name="ui"></param>
        public static void PlayOpenUI(GameObject ui)
        {
            
            GameObject aniUI = ui.transform.Find("Main").gameObject;
            aniUI.transform.localScale = ScaleVlue;
            aniUI.transform.DOScale(Vector3.one, 0.3f);
        }
        /// <summary>
        /// 关闭界面
        /// </summary>
        public static void PlayCloseUI(GameObject ui,CallBack callback=null)
        {
            GameObject aniUI = ui.transform.Find("Main").gameObject;
            aniUI.transform.localScale = Vector3.one;

            //TODO 使用DOTween 
            Tween tween = aniUI.transform.DOScale(ScaleVlue, 0.3f);
            tween.OnComplete(() =>
            {
                //callback?.Invoke();
                if (callback == null)
                {
                    Object.Destroy(ui);
                }
            });

        }
}

}
