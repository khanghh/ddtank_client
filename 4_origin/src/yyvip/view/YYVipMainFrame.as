package yyvip.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.RequestLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import yyvip.YYVipManager;
   
   public class YYVipMainFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _bottomBg:ScaleBitmapImage;
      
      private var _openBtn:SelectedButton;
      
      private var _dailyBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _openView:YYVipOpenView;
      
      private var _dailyView:YYVipDailyAwardView;
      
      public function YYVipMainFrame()
      {
         super();
         initView();
         initEvent();
         if(YYVipManager.isShowOpenView)
         {
            _openBtn.enable = true;
            _btnGroup.selectIndex = 0;
         }
         else
         {
            _openBtn.enable = false;
            _btnGroup.selectIndex = 1;
         }
         initData();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("yyVip.mainFrame.titleTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("yyVip.mainFrame.bg");
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("yyVip.mainFrame.bottomBg");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("yyvip.mainFrame.openBtn");
         _dailyBtn = ComponentFactory.Instance.creatComponentByStylename("yyvip.mainFrame.dailyBtn");
         _openView = new YYVipOpenView();
         _dailyView = new YYVipDailyAwardView();
         addToContent(_openBtn);
         addToContent(_dailyBtn);
         addToContent(_bg);
         addToContent(_bottomBg);
         addToContent(_openView);
         addToContent(_dailyView);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_openBtn);
         _btnGroup.addSelectItem(_dailyBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _btnGroup.addEventListener("change",__changeHandler,false,0,true);
         _openBtn.addEventListener("click",__soundPlay,false,0,true);
         _dailyBtn.addEventListener("click",__soundPlay,false,0,true);
      }
      
      private function initData() : void
      {
         var args:URLVariables = new URLVariables();
         args["uid"] = PlayerManager.Instance.Self.ID;
         args["type"] = "1";
         var loader:RequestLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ProxyVIP.ashx"),6,args);
         loader.addEventListener("loadError",__onRequestDataError,false,0,true);
         loader.addEventListener("complete",__onRequestDataComplete,false,0,true);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function __onRequestDataError(evt:LoaderEvent) : void
      {
         trace("RequestError");
         var tmpLoader:RequestLoader = evt.target as RequestLoader;
         tmpLoader.removeEventListener("loadError",__onRequestDataError);
         tmpLoader.removeEventListener("complete",__onRequestDataComplete);
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.requestData.failTipTxt"));
      }
      
      private function __onRequestDataComplete(evt:LoaderEvent) : void
      {
         var type:int = 0;
         var isVip:int = 0;
         var isCanGetOpenAward:int = 0;
         var isCanGetDailyAward:int = 0;
         var isCanGetYearDailyAward:int = 0;
         var tmpLoader:RequestLoader = evt.target as RequestLoader;
         tmpLoader.removeEventListener("loadError",__onRequestDataError);
         tmpLoader.removeEventListener("complete",__onRequestDataComplete);
         var xml:XML = new XML(evt.loader.content);
         if(xml.@value == "true")
         {
            type = xml.@Type;
            if(type == 1)
            {
               isVip = xml.@IsVip;
               isCanGetOpenAward = xml.@IsReceiveOpenPack;
               isCanGetDailyAward = xml.@IsReceiveEveryDayPack;
               isCanGetYearDailyAward = xml.@IsReceiveYearPack;
               if(_openView)
               {
                  _openView.refreshOpenOrCostBtn(isVip,isCanGetOpenAward);
               }
               if(_dailyView)
               {
                  _dailyView.refreshBtnStatus(isCanGetDailyAward,isCanGetYearDailyAward);
               }
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.requestData.failTipTxt"));
         }
      }
      
      private function __changeHandler(event:Event) : void
      {
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _openView.visible = true;
               _dailyView.visible = false;
               break;
            case 1:
               _openView.visible = false;
               _dailyView.visible = true;
         }
      }
      
      private function __soundPlay(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _btnGroup.removeEventListener("change",__changeHandler);
         _openBtn.removeEventListener("click",__soundPlay);
         _dailyBtn.removeEventListener("click",__soundPlay);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_btnGroup)
         {
            _btnGroup.dispose();
         }
         super.dispose();
         _bg = null;
         _bottomBg = null;
         _openBtn = null;
         _dailyBtn = null;
         _btnGroup = null;
         _openView = null;
         _dailyView = null;
      }
   }
}
