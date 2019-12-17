using DG.Tweening;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Common
{
    /// <summary>
    /// 提示弹窗
    /// </summary>
    public class Tip
    {
        private static GameObject tipPrefab;
        private static List<TipList> _tipQueue;//消息队列
        private static int _offsetY = 50;//tip提示窗的位置偏移
        public static void Init()
        {
            _tipQueue = new List<TipList>();
            tipPrefab = (GameObject)Resources.Load("Prefab/TipWindows");
            //ApplicationManager.s_OnApplicationUpdate += Update;
            AppMgr.ON_APP_UPDATE += Update;
        }

        public static void Show(string content, float continueTime = 1.0f)
        {
            GameObject tip = Object.Instantiate(tipPrefab);
            tip.transform.Find("Image/Text").GetComponent<Text>().text = content;
            UIMgr.SetSenter(tip);
            TipList tp = new TipList(tip, continueTime);
            _tipQueue.Add(tp);

        }
        public static void Update()
        {

            int i;
            for (i = 0; i < _tipQueue.Count; i++)
            {
                _tipQueue[i].currentTime += Time.deltaTime;
            }
            TipList tp;
            for (i = 0; i < _tipQueue.Count; i++)
            {
                tp = _tipQueue[i];
                if (tp.Flag())
                {
                    Object.Destroy(tp.tip);
                    _tipQueue.RemoveAt(i);
                    //i--;
                }
            }
            /*多个窗口打开是，其他窗口依次上一50个单位*/
            int count = _tipQueue.Count;
            for (i = 0; i < count; ++i)
            {
                tp = _tipQueue[i];
                int targetY = _offsetY * (count - i - 1);
                if (targetY != tp.targetY)
                {
                    DOTween.Kill(tp.tip);
                    tp.tip.transform.DOLocalMoveY(targetY, 0.1f);
                    tp.targetY = targetY;
                }
            }
            //Log.Info("[_tipQueue]{0}", _tipQueue.Count);
        }

    }

    }
   public class TipList
    {
        public GameObject tip;

        public int targetY;
        public float currentTime;
        public float _currentTime;

        public TipList(GameObject taget, float continueTime)
        {
            tip = taget;
           targetY = 0;
            _currentTime = continueTime;
        }

        public bool Flag()
        {
            return currentTime > _currentTime;
        }
    
   }
   
