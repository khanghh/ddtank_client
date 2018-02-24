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
      
      public function LimitActivityView(param1:int){super();}
      
      public function init() : void{}
      
      private function configUI() : void{}
      
      private function addEvent() : void{}
      
      protected function __piccHandler(param1:MouseEvent) : void{}
      
      protected function __responseHandler(param1:FrameEvent) : void{}
      
      private function __poorManResponse(param1:FrameEvent) : void{}
      
      private function __back(param1:MouseEvent) : void{}
      
      private function __getAward(param1:MouseEvent) : void{}
      
      private function __exchange(param1:MouseEvent) : void{}
      
      private function __activityLoadComplete(param1:LoaderEvent) : void{}
      
      private function __onLoadError(param1:LoaderEvent) : void{}
      
      public function setData() : void{}
      
      private function showGoodsExchangeView() : void{}
      
      private function hideGoodsExchangeView() : void{}
      
      private function __ExchangeGoodsChangeHandler(param1:CalendarEvent) : void{}
      
      private function showDetailView() : void{}
      
      private function hideDetailView() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
      
      public function content() : Sprite{return null;}
      
      public function setState(param1:int, param2:int) : void{}
   }
}
