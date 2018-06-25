package wonderfulActivity.items
{
   import activeEvents.data.ActiveEventsInfo;
   import baglocked.BaglockedManager;
   import calendar.CalendarControl;
   import calendar.event.CalendarEvent;
   import calendar.view.ActivityDetail;
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
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.views.IRightView;
   
   public class LimitActivityView extends Sprite implements IRightView
   {
      
      public static const PICC_PRICE:int = 10000;
       
      
      private var _container:Sprite;
      
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
      
      private var tagId:int;
      
      public function LimitActivityView(id:int)
      {
         super();
         tagId = id;
      }
      
      public function init() : void
      {
         configUI();
         addEvent();
         setData();
      }
      
      private function configUI() : void
      {
         _container = new Sprite();
         PositionUtils.setPos(_container,"wonderful.limitActivity.ContentPos");
         _back = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityStateBg");
         _container.addChild(_back);
         _titleField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityStateTitleField");
         _container.addChild(_titleField);
         _detail = ComponentFactory.Instance.creatCustomObject("ddtcalendar.ActivityDetail");
         _buttonBack = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.GetButtonBackBg");
         _container.addChild(_buttonBack);
         _getButton = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.GetButton");
         _getButton.visible = false;
         _container.addChild(_getButton);
         _exchangeButton = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.exchangeButton");
         _exchangeButton.visible = false;
         _container.addChild(_exchangeButton);
         _piccBtn = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.PiccBtn");
         _container.addChild(_piccBtn);
         _content = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityState.Vbox");
         _content.addChild(_detail);
         _scrollList = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.ActivityDetailList");
         _scrollList.setView(_content);
         _container.addChild(_scrollList);
         _goodsExchange = new GoodsExchangeView();
         PositionUtils.setPos(_goodsExchange,"ddtcalendarGrid.GoodsExchangeView.GoodsExchangeViewPos");
         _content.addChild(_goodsExchange);
         addChild(_container);
      }
      
      private function addEvent() : void
      {
         _getButton.addEventListener("click",__getAward);
         _exchangeButton.addEventListener("click",__exchange);
         _piccBtn.addEventListener("click",__piccHandler);
         _goodsExchange.addEventListener("ExchangeGoodsChange",__ExchangeGoodsChangeHandler);
      }
      
      protected function __piccHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ActivityState.confirm.content",10000),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         alert.moveEnable = false;
         alert.addEventListener("response",__responseHandler);
      }
      
      protected function __responseHandler(event:FrameEvent) : void
      {
         var alert2:* = null;
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__responseHandler);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.Money >= 10000)
            {
               SocketManager.Instance.out.sendPicc(_activityInfo.ActiveID,10000);
            }
            else
            {
               alert2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("poorNote"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
               alert2.moveEnable = false;
               alert2.addEventListener("response",__poorManResponse);
            }
         }
         ObjectUtils.disposeObject(alert);
      }
      
      private function __poorManResponse(event:FrameEvent) : void
      {
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__poorManResponse);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(alert);
      }
      
      private function __back(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CalendarControl.getInstance().closeActivity();
      }
      
      private function __getAward(event:MouseEvent) : void
      {
         var alert:* = null;
         var loader:* = null;
         SoundManager.instance.play("008");
         if(_activityInfo.ActiveType == 0)
         {
            if(_detail.getInputField().text == "" && _activityInfo.HasKey == 1)
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.movement.MovementRightView.pass"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,2);
               alert.info.showCancel = false;
               return;
            }
            loader = CalendarControl.getInstance().reciveActivityAward(_activityInfo,_detail.getInputField().text);
            loader.addEventListener("loadError",__onLoadError);
            loader.addEventListener("complete",__activityLoadComplete);
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
      
      private function __exchange(event:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SoundManager.instance.playButtonSound();
         _goodsExchange.sendGoods();
      }
      
      private function __activityLoadComplete(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.currentTarget as BaseLoader;
         loader.removeEventListener("loadError",__onLoadError);
         loader.removeEventListener("complete",__activityLoadComplete);
         if(_activityInfo.HasKey == 1)
         {
            _getButton.enable = true;
         }
         else
         {
            _getButton.enable = !_activityInfo.isAttend;
         }
      }
      
      private function __onLoadError(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.currentTarget as BaseLoader;
         loader.removeEventListener("loadError",__onLoadError);
         loader.removeEventListener("complete",__activityLoadComplete);
         _getButton.enable = !_activityInfo.isAttend;
      }
      
      public function setData() : void
      {
         _activityInfo = WonderfulActivityManager.Instance.getActiveEventsInfoByID(tagId);
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
      
      private function __ExchangeGoodsChangeHandler(event:CalendarEvent) : void
      {
         if(event.enable == false)
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
         ObjectUtils.disposeObject(_container);
         _container = null;
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
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function setState(type:int, id:int) : void
      {
      }
   }
}
