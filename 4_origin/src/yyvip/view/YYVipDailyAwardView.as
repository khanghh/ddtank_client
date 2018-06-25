package yyvip.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.RequestLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import yyvip.YYVipControl;
   
   public class YYVipDailyAwardView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _yearGetBtn:SimpleBitmapButton;
      
      private var _levelAwardList:Vector.<YYVipLevelAwardCell>;
      
      private var _yearAwardList:Vector.<YYVipAwardCell>;
      
      public function YYVipDailyAwardView()
      {
         super();
         this.x = 2;
         this.y = -22;
         this.mouseEnabled = false;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmp:* = null;
         var j:int = 0;
         var tmp2:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.yyvip.dailyView.bg");
         addChild(_bg);
         _levelAwardList = new Vector.<YYVipLevelAwardCell>();
         for(i = 1; i <= 7; )
         {
            tmp = new YYVipLevelAwardCell(i);
            tmp.x = 42;
            tmp.y = 31 + i * 44;
            addChild(tmp);
            _levelAwardList.push(tmp);
            i++;
         }
         _yearAwardList = new Vector.<YYVipAwardCell>();
         var tmpAwardInfoList:Vector.<Object> = YYVipControl.instance.dailyViewYearAwardList;
         var len:int = tmpAwardInfoList.length;
         for(j = 0; j < len; )
         {
            tmp2 = new YYVipAwardCell(tmpAwardInfoList[j]);
            tmp2.x = 492 + j % 2 * 104;
            tmp2.y = 132 + int(j / 2) * 124;
            addChild(tmp2);
            _yearAwardList.push(tmp2);
            j++;
         }
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("yyvip.view.getBtn");
         _getBtn.enable = false;
         PositionUtils.setPos(_getBtn,"yyvip.dailyView.getBtnPos");
         _yearGetBtn = ComponentFactory.Instance.creatComponentByStylename("yyvip.view.getBtn");
         _yearGetBtn.enable = false;
         PositionUtils.setPos(_yearGetBtn,"yyvip.dailyView.yearGetBtnPos");
         addChild(_getBtn);
         addChild(_yearGetBtn);
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",getClickHandler,false,0,true);
         _yearGetBtn.addEventListener("click",getClickHandler,false,0,true);
      }
      
      public function refreshBtnStatus(isCanGet:int, isYearCanGet:int) : void
      {
         if(isCanGet == 0)
         {
            _getBtn.enable = false;
         }
         else
         {
            _getBtn.enable = true;
         }
         if(isYearCanGet == 0)
         {
            _yearGetBtn.enable = false;
         }
         else
         {
            _yearGetBtn.enable = true;
         }
      }
      
      private function getClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var tmp:String = "2";
         var tmpBtn:SimpleBitmapButton = event.currentTarget as SimpleBitmapButton;
         tmpBtn.enable = false;
         var _loc6_:* = tmpBtn;
         if(_getBtn !== _loc6_)
         {
            if(_yearGetBtn === _loc6_)
            {
               tmp = "3";
            }
         }
         else
         {
            tmp = "2";
         }
         var args:URLVariables = new URLVariables();
         args["uid"] = PlayerManager.Instance.Self.ID;
         args["type"] = "2";
         args["reward"] = tmp;
         var loader:RequestLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ProxyVIP.ashx"),6,args);
         loader.addEventListener("loadError",__onRequestError,false,0,true);
         loader.addEventListener("complete",__onRequestComplete,false,0,true);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function __onRequestError(evt:LoaderEvent) : void
      {
         trace("RequestError");
         var tmpLoader:RequestLoader = evt.target as RequestLoader;
         tmpLoader.removeEventListener("loadError",__onRequestError);
         tmpLoader.removeEventListener("complete",__onRequestComplete);
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.requestData.failTipTxt"));
      }
      
      private function __onRequestComplete(evt:LoaderEvent) : void
      {
         var type:int = 0;
         var result:int = 0;
         var tmpLoader:RequestLoader = evt.target as RequestLoader;
         tmpLoader.removeEventListener("loadError",__onRequestError);
         tmpLoader.removeEventListener("complete",__onRequestComplete);
         var xml:XML = new XML(evt.loader.content);
         if(xml.@value == "true")
         {
            type = xml.@Type;
            if(type == 2)
            {
               result = xml.@Reward;
               if(result == 1)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.getReward.successTxt"));
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.getReward.failTxt"));
               }
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.requestData.failTipTxt"));
         }
      }
      
      private function guideToOpen(tip:String) : void
      {
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),tip,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",confirmHandler,false,0,true);
      }
      
      private function confirmHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",confirmHandler);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            YYVipControl.instance.gotoOpenUrl();
         }
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",getClickHandler);
         _yearGetBtn.removeEventListener("click",getClickHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _getBtn = null;
         _yearGetBtn = null;
         _levelAwardList = null;
         _yearAwardList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
