using UnityEngine;
using System.Collections;
using Common;
using UnityEngine.UI;
public class StartLayer : MyUIBase
{

    public Button LoginBtn;
    public Button RegistBtn;

    protected override void Start()
    {
        base.Start();
        base.InitEvent();

        UIMgr.PlayOpenUI(gameObject);
    }
    private void LoginBtnClick()
    {


    }
    private void RegistBtnClick()
    {

    }
    // Update is called once per frame
    void Update()
    {

    }
}
