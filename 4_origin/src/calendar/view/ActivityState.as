package calendar.view
{
   import activeEvents.data.ActiveEventsInfo;
   import baglocked.BaglockedManager;
   import calendar.CalendarControl;
   import calendar.CalendarModel;
   import calendar.event.CalendarEvent;
   import calendar.view.goodsExchange.GoodsExchangeView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ActivityState extends Sprite implements ICalendar
   {
      
      public static const PICC_PRICE:int = 10000;
       
      
      private var _back:DisplayObject;
      
      private var _scrollList:ScrollPanel;
      
      private var _content:VBox;
      
      private var _detail:ActivityDetail;
      
      private var _goodsExchange:GoodsExchangeView;
      
      private var _titleField:FilterFrameText;
      
      private var _buttonBack:DisplayObject;
      
      private var _getButton:BaseButton;
      
      private var _exchangeButton:BaseButton;
      
      private var _piccBtn:BaseButton;
      
      private var _activityInfo:ActiveEventsInfo;
      
      public function ActivityState(param1:CalendarModel)
      {
         super();
         configUI();
         addEvent();
      }
      
      private function configUI() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityStateBg");
         addChild(_back);
         _titleField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityStateTitleField");
         addChild(_titleField);
         _detail = ComponentFactory.Instance.creatCustomObject("ddtcalendar.ActivityDetail");
         _buttonBack = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.GetButtonBackBg");
         addChild(_buttonBack);
         _getButton = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.GetButton");
         _getButton.visible = false;
         addChild(_getButton);
         _exchangeButton = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.exchangeButton");
         _exchangeButton.visible = false;
         addChild(_exchangeButton);
         _piccBtn = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.PiccBtn");
         addChild(_piccBtn);
         _content = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.Vbox");
         _content.addChild(_detail);
         _scrollList = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityDetailList");
         _scrollList.setView(_content);
         addChild(_scrollList);
         _goodsExchange = new GoodsExchangeView();
         PositionUtils.setPos(_goodsExchange,"ddtcalendarGrid.GoodsExchangeView.GoodsExchangeViewPos");
         _content.addChild(_goodsExchange);
      }
      
      private function addEvent() : void
      {
         _getButton.addEventListener("click",__getAward);
         _exchangeButton.addEventListener("click",__exchange);
         _piccBtn.addEventListener("click",__piccHandler);
         _goodsExchange.addEventListener("ExchangeGoodsChange",__ExchangeGoodsChangeHandler);
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
      
      private function __back(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CalendarControl.getInstance().closeActivity();
      }
      
      private function __getAward(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_activityInfo.ActiveType == 0)
         {
            if(_detail.getInputField().text == "" && _activityInfo.HasKey == 1)
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.movement.MovementRightView.pass"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,2);
               _loc3_.info.showCancel = false;
               return;
            }
            _loc2_ = CalendarControl.getInstance().reciveActivityAward(_activityInfo,_detail.getInputField().text);
            _loc2_.addEventListener("loadError",__onLoadError);
            _loc2_.addEventListener("complete",__activityLoadComplete);
            _detail.getInputField().text = "";
            if(_activityInfo.HasKey == 1)
            {
               _getButton.enable = true;
            }
            else
            {
               _getButton.enable = !_activityInfo.isAttend;
            }
         }
         else if(_activityInfo.ActiveType == 5)
         {
            SocketManager.Instance.out.sendActivePullDown(_activityInfo.ActiveID,_detail.getInputField().text);
         }
      }
      
      private function __exchange(param1:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SoundManager.instance.playButtonSound();
         _goodsExchange.sendGoods();
      }
      
      private function __activityLoadComplete(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.currentTarget as BaseLoader;
         _loc2_.removeEventListener("loadError",__onLoadError);
         _loc2_.removeEventListener("complete",__activityLoadComplete);
         if(_activityInfo.HasKey == 1)
         {
            _getButton.enable = true;
         }
         else
         {
            _getButton.enable = !_activityInfo.isAttend;
         }
      }
      
      private function __onLoadError(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.currentTarget as BaseLoader;
         _loc2_.removeEventListener("loadError",__onLoadError);
         _loc2_.removeEventListener("complete",__activityLoadComplete);
         _getButton.enable = !_activityInfo.isAttend;
      }
      
      public function setData(param1:* = null) : void
      {
         _activityInfo = param1 as ActiveEventsInfo;
         if(_activityInfo)
         {
            _piccBtn.visible = false;
            _titleField.text = _activityInfo.Title;
            if(_activityInfo.ActiveType == 1)
            {
               hideDetailView();
               showGoodsExchangeView();
            }
            else
            {
               hideGoodsExchangeView();
               showDetailView();
               if(_activityInfo.HasKey == 1 || _activityInfo.HasKey == 2 || _activityInfo.HasKey == 3 || _activityInfo.HasKey == 6 || _activityInfo.HasKey == 7 || _activityInfo.HasKey == 8)
               {
                  _getButton.visible = true;
                  if(_activityInfo.HasKey == 1)
                  {
                     _getButton.enable = true;
                  }
                  else
                  {
                     _getButton.enable = !_activityInfo.isAttend;
                  }
               }
               else
               {
                  _getButton.visible = false;
               }
               if(_activityInfo.ActiveType == 0 || _activityInfo.ActiveType == 2)
               {
                  if(_activityInfo.ActiveType == 2)
                  {
                     _getButton.visible = false;
                     _piccBtn.visible = true;
                  }
               }
            }
         }
         else
         {
            _piccBtn.visible = false;
            _getButton.visible = false;
         }
         _scrollList.invalidateViewport();
      }
      
      private function showGoodsExchangeView() : void
      {
         if(!_goodsExchange)
         {
            _goodsExchange = new GoodsExchangeView();
            _goodsExchange.addEventListener("ExchangeGoodsChange",__ExchangeGoodsChangeHandler);
            _goodsExchange.setData(_activityInfo);
            _exchangeButton.visible = true;
            _content.addChild(_goodsExchange);
         }
         else
         {
            _goodsExchange.setData(_activityInfo);
            _exchangeButton.visible = true;
         }
      }
      
      private function hideGoodsExchangeView() : void
      {
         if(_goodsExchange)
         {
            _exchangeButton.visible = false;
            _goodsExchange.removeEventListener("ExchangeGoodsChange",__ExchangeGoodsChangeHandler);
            ObjectUtils.disposeObject(_goodsExchange);
            _goodsExchange = null;
         }
      }
      
      private function __ExchangeGoodsChangeHandler(param1:CalendarEvent) : void
      {
         if(param1.enable == false)
         {
            _exchangeButton.enable = false;
         }
         else
         {
            _exchangeButton.enable = true;
         }
      }
      
      private function showDetailView() : void
      {
         if(!_detail)
         {
            _detail = new ActivityDetail();
            _detail.setData(_activityInfo);
            _getButton.visible = true;
            _content.addChild(_detail);
            _content.height = _detail.height;
         }
         else
         {
            _detail.setData(_activityInfo);
            _getButton.visible = true;
            _content.height = _detail.height;
         }
      }
      
      private function hideDetailView() : void
      {
         if(_detail)
         {
            _getButton.visible = false;
            ObjectUtils.disposeObject(_detail);
            _detail = null;
         }
      }
      
      private function removeEvent() : void
      {
         _getButton.removeEventListener("click",__getAward);
         _exchangeButton.removeEventListener("click",__exchange);
         _piccBtn.removeEventListener("click",__piccHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_piccBtn);
         _piccBtn = null;
         ObjectUtils.disposeObject(_titleField);
         _titleField = null;
         ObjectUtils.disposeObject(_buttonBack);
         _buttonBack = null;
         ObjectUtils.disposeObject(_getButton);
         _getButton = null;
         ObjectUtils.disposeObject(_exchangeButton);
         _exchangeButton = null;
         ObjectUtils.disposeObject(_detail);
         _detail = null;
         ObjectUtils.disposeObject(_scrollList);
         _scrollList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_goodsExchange)
         {
            ObjectUtils.disposeObject(_goodsExchange);
            _goodsExchange = null;
         }
      }
   }
}
