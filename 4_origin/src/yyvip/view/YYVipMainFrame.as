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
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["uid"] = PlayerManager.Instance.Self.ID;
         _loc2_["type"] = "1";
         var _loc1_:RequestLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ProxyVIP.ashx"),6,_loc2_);
         _loc1_.addEventListener("loadError",__onRequestDataError,false,0,true);
         _loc1_.addEventListener("complete",__onRequestDataComplete,false,0,true);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function __onRequestDataError(param1:LoaderEvent) : void
      {
         trace("RequestError");
         var _loc2_:RequestLoader = param1.target as RequestLoader;
         _loc2_.removeEventListener("loadError",__onRequestDataError);
         _loc2_.removeEventListener("complete",__onRequestDataComplete);
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.requestData.failTipTxt"));
      }
      
      private function __onRequestDataComplete(param1:LoaderEvent) : void
      {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:RequestLoader = param1.target as RequestLoader;
         _loc4_.removeEventListener("loadError",__onRequestDataError);
         _loc4_.removeEventListener("complete",__onRequestDataComplete);
         var _loc5_:XML = new XML(param1.loader.content);
         if(_loc5_.@value == "true")
         {
            _loc6_ = _loc5_.@Type;
            if(_loc6_ == 1)
            {
               _loc3_ = _loc5_.@IsVip;
               _loc8_ = _loc5_.@IsReceiveOpenPack;
               _loc2_ = _loc5_.@IsReceiveEveryDayPack;
               _loc7_ = _loc5_.@IsReceiveYearPack;
               if(_openView)
               {
                  _openView.refreshOpenOrCostBtn(_loc3_,_loc8_);
               }
               if(_dailyView)
               {
                  _dailyView.refreshBtnStatus(_loc2_,_loc7_);
               }
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.requestData.failTipTxt"));
         }
      }
      
      private function __changeHandler(param1:Event) : void
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
      
      private function __soundPlay(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
