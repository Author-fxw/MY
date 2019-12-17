using UnityEngine;
using System.Collections;

	/// <summary>
	/// 帧率计算器
	/// </summary>
	public class MFPSCounter
	{
		// 帧率计算频率
		private const float calcRate = 0.5f;
		// 本次计算频率下帧数
		private int frameCount = 0;
		// 频率时长
		private float rateDuration = 0f;
		// 显示帧率
		private static float fps = 0.0f;
        private static float  fpms = 0.0f;
        private float deltaTime = 0.0f;
        public static void Init()
        {   
            Common.AppMgr.ON_APP_ONGUI += OnGUI;
            Common.AppMgr.ON_APP_UPDATE += Update;
        }
    
        public static void SetFPS()
        {
        Application.targetFrameRate = 30;///设置限定游戏的帧率。/*在unity编辑器里面是被忽略的，只有在打包之后在手机上有效果。*/
        }

    public static void Update()
    {
        /*第一种方式计算帧率（秒）*/
        //++this.frameCount;
        //this.rateDuration += Time.unscaledDeltaTime;
        //if (this.rateDuration > calcRate)
        //{
        //	// 计算帧率
        //	this.fps = (this.frameCount / this.rateDuration);
        //	this.frameCount = 0;
        //	this.rateDuration = 0f;
        //}
        /* 第二种方式计算帧率（秒）*/
        fps = 1.0f / Time.smoothDeltaTime;
        fpms = Time.smoothDeltaTime * 1000.0f;
        /*第三种方式计算帧率*/
        //deltaTime += (Time.unscaledDeltaTime - deltaTime) * 0.1f;    
    }
        static void OnGUI()
        {
            GUILayout.Label("FPS：" + fps.ToString()+"MS:"+ fpms.ToString());
        }
	}
