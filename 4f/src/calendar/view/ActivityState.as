package calendar.view{   import activeEvents.data.ActiveEventsInfo;   import baglocked.BaglockedManager;   import calendar.CalendarControl;   import calendar.CalendarModel;   import calendar.event.CalendarEvent;   import calendar.view.goodsExchange.GoodsExchangeView;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class ActivityState extends Sprite implements ICalendar   {            public static const PICC_PRICE:int = 10000;                   private var _back:DisplayObject;            private var _scrollList:ScrollPanel;            private var _content:VBox;            private var _detail:ActivityDetail;            private var _goodsExchange:GoodsExchangeView;            private var _titleField:FilterFrameText;            private var _buttonBack:DisplayObject;            private var _getButton:BaseButton;            private var _exchangeButton:BaseButton;            private var _piccBtn:BaseButton;            private var _activityInfo:ActiveEventsInfo;            public function ActivityState(model:CalendarModel) { super(); }
            private function configUI() : void { }
            private function addEvent() : void { }
            protected function __piccHandler(event:MouseEvent) : void { }
            protected function __responseHandler(event:FrameEvent) : void { }
            private function __poorManResponse(event:FrameEvent) : void { }
            private function __back(event:MouseEvent) : void { }
            private function __getAward(event:MouseEvent) : void { }
            private function __exchange(event:MouseEvent) : void { }
            private function __activityLoadComplete(event:LoaderEvent) : void { }
            private function __onLoadError(event:LoaderEvent) : void { }
            public function setData(val:* = null) : void { }
            private function showGoodsExchangeView() : void { }
            private function hideGoodsExchangeView() : void { }
            private function __ExchangeGoodsChangeHandler(event:CalendarEvent) : void { }
            private function showDetailView() : void { }
            private function hideDetailView() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}