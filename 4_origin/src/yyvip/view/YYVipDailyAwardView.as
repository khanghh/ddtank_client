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
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.yyvip.dailyView.bg");
         addChild(_bg);
         _levelAwardList = new Vector.<YYVipLevelAwardCell>();
         _loc6_ = 1;
         while(_loc6_ <= 7)
         {
            _loc2_ = new YYVipLevelAwardCell(_loc6_);
            _loc2_.x = 42;
            _loc2_.y = 31 + _loc6_ * 44;
            addChild(_loc2_);
            _levelAwardList.push(_loc2_);
            _loc6_++;
         }
         _yearAwardList = new Vector.<YYVipAwardCell>();
         var _loc4_:Vector.<Object> = YYVipControl.instance.dailyViewYearAwardList;
         var _loc3_:int = _loc4_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc1_ = new YYVipAwardCell(_loc4_[_loc5_]);
            _loc1_.x = 492 + _loc5_ % 2 * 104;
            _loc1_.y = 132 + int(_loc5_ / 2) * 124;
            addChild(_loc1_);
            _yearAwardList.push(_loc1_);
            _loc5_++;
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
      
      public function refreshBtnStatus(param1:int, param2:int) : void
      {
         if(param1 == 0)
         {
            _getBtn.enable = false;
         }
         else
         {
            _getBtn.enable = true;
         }
         if(param2 == 0)
         {
            _yearGetBtn.enable = false;
         }
         else
         {
            _yearGetBtn.enable = true;
         }
      }
      
      private function getClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc4_:String = "2";
         var _loc5_:SimpleBitmapButton = param1.currentTarget as SimpleBitmapButton;
         _loc5_.enable = false;
         var _loc6_:* = _loc5_;
         if(_getBtn !== _loc6_)
         {
            if(_yearGetBtn === _loc6_)
            {
               _loc4_ = "3";
            }
         }
         else
         {
            _loc4_ = "2";
         }
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["uid"] = PlayerManager.Instance.Self.ID;
         _loc3_["type"] = "2";
         _loc3_["reward"] = _loc4_;
         var _loc2_:RequestLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ProxyVIP.ashx"),6,_loc3_);
         _loc2_.addEventListener("loadError",__onRequestError,false,0,true);
         _loc2_.addEventListener("complete",__onRequestComplete,false,0,true);
         LoadResourceManager.Instance.startLoad(_loc2_);
      }
      
      private function __onRequestError(param1:LoaderEvent) : void
      {
         trace("RequestError");
         var _loc2_:RequestLoader = param1.target as RequestLoader;
         _loc2_.removeEventListener("loadError",__onRequestError);
         _loc2_.removeEventListener("complete",__onRequestComplete);
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("yyVip.requestData.failTipTxt"));
      }
      
      private function __onRequestComplete(param1:LoaderEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:RequestLoader = param1.target as RequestLoader;
         _loc3_.removeEventListener("loadError",__onRequestError);
         _loc3_.removeEventListener("complete",__onRequestComplete);
         var _loc4_:XML = new XML(param1.loader.content);
         if(_loc4_.@value == "true")
         {
            _loc5_ = _loc4_.@Type;
            if(_loc5_ == 2)
            {
               _loc2_ = _loc4_.@Reward;
               if(_loc2_ == 1)
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
      
      private function guideToOpen(param1:String) : void
      {
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),param1,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",confirmHandler,false,0,true);
      }
      
      private function confirmHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",confirmHandler);
         if(param1.responseCode == 3 || param1.responseCode == 2)
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
