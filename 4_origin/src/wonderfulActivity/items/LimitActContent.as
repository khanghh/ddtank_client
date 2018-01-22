package wonderfulActivity.items
{
   import activeEvents.data.ActiveEventsInfo;
   import baglocked.BaglockedManager;
   import calendar.CalendarControl;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LimitActContent extends Sprite implements Disposeable
   {
      
      public static const PICC_PRICE:int = 10000;
       
      
      private var _limitView:LimitActView;
      
      private var _titleField:FilterFrameText;
      
      private var _titleBack:Bitmap;
      
      private var _scrollList:ScrollPanel;
      
      private var _back:MutipleImage;
      
      private var _getButton:SimpleBitmapButton;
      
      private var _exchangeButton:SimpleBitmapButton;
      
      private var _piccBtn:SimpleBitmapButton;
      
      private var _activityInfo:ActiveEventsInfo;
      
      public function LimitActContent(param1:ActiveEventsInfo)
      {
         super();
         _activityInfo = param1;
         initView(param1);
      }
      
      private function initView(param1:ActiveEventsInfo) : void
      {
         _getButton = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.GetButton");
         _getButton.visible = false;
         addChild(_getButton);
         _piccBtn = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.PiccBtn");
         _piccBtn.visible = false;
         addChild(_piccBtn);
         _back = ComponentFactory.Instance.creat("wonderful.ActivityStateBg");
         addChild(_back);
         _titleField = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityStateTitleField");
         _titleField.text = param1.Title;
         addChild(_titleField);
         _scrollList = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityDetailList");
         addChild(_scrollList);
         _limitView = new LimitActView(param1);
         addChild(_limitView);
         _scrollList.setView(_limitView);
         showBtn();
         initEvents();
      }
      
      private function initEvents() : void
      {
         if(_getButton)
         {
            _getButton.addEventListener("click",__getAward);
         }
         if(_exchangeButton)
         {
            _exchangeButton.addEventListener("click",__exchange);
         }
         if(_piccBtn)
         {
            _piccBtn.addEventListener("click",__piccHandler);
         }
      }
      
      private function showBtn() : void
      {
         if(_activityInfo.ActiveType == 1)
         {
            if(_exchangeButton)
            {
               _exchangeButton.visible = true;
            }
         }
         else if(_activityInfo.ActiveType == 2)
         {
            _piccBtn.visible = true;
         }
         else
         {
            _getButton.visible = true;
         }
      }
      
      private function removeEvents() : void
      {
         if(_getButton)
         {
            _getButton.removeEventListener("click",__getAward);
         }
         if(_exchangeButton)
         {
            _exchangeButton.removeEventListener("click",__exchange);
         }
         if(_piccBtn)
         {
            _piccBtn.removeEventListener("click",__piccHandler);
         }
      }
      
      private function __getAward(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_activityInfo.ActiveType == 0)
         {
            if(!_limitView.getInputField())
            {
               return;
            }
            if(_limitView.getInputField().text == "" && (_activityInfo.HasKey == 1 || _activityInfo.HasKey == 7 || _activityInfo.HasKey == 8))
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.movement.MovementRightView.pass"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,2);
               _loc3_.info.showCancel = false;
               return;
            }
            _loc2_ = CalendarControl.getInstance().reciveActivityAward(_activityInfo,_limitView.getInputField().text);
            _loc2_.addEventListener("loadError",__onLoadError);
            _loc2_.addEventListener("complete",__activityLoadComplete);
            _limitView.getInputField().text = "";
            if(_activityInfo.HasKey == 1)
            {
               _getButton.enable = true;
            }
            else
            {
               _getButton.enable = !_activityInfo.isAttend;
            }
         }
      }
      
      private function __onLoadError(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.currentTarget as BaseLoader;
         _loc2_.removeEventListener("loadError",__onLoadError);
         _loc2_.removeEventListener("complete",__activityLoadComplete);
         _getButton.enable = !_activityInfo.isAttend;
      }
      
      private function __exchange(param1:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SoundManager.instance.playButtonSound();
      }
      
      private function __activityLoadComplete(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.currentTarget as BaseLoader;
         if(_activityInfo.HasKey == 1)
         {
            _getButton.enable = true;
         }
         else
         {
            _getButton.enable = !_activityInfo.isAttend;
         }
      }
      
      protected function __piccHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ActivityState.confirm.content",10000),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",__responseHandler);
      }
      
      protected function __responseHandler(param1:FrameEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__responseHandler);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.Money >= 10000)
            {
               SocketManager.Instance.out.sendPicc(_activityInfo.ActiveID,10000);
            }
            else
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("poorNote"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
               _loc3_.moveEnable = false;
               _loc3_.addEventListener("response",__poorManResponse);
            }
         }
         ObjectUtils.disposeObject(_loc2_);
      }
      
      private function __poorManResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__poorManResponse);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(_loc2_);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_limitView);
         ObjectUtils.disposeObject(_back);
         ObjectUtils.disposeObject(_titleField);
         ObjectUtils.disposeObject(_scrollList);
         ObjectUtils.disposeObject(_getButton);
         ObjectUtils.disposeObject(_exchangeButton);
         ObjectUtils.disposeObject(_piccBtn);
         _limitView = null;
         _scrollList = null;
         _titleField = null;
         _back = null;
         _getButton = null;
         _exchangeButton = null;
         _piccBtn = null;
      }
   }
}
