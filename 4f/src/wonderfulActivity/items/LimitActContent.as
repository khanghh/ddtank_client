package wonderfulActivity.items{   import activeEvents.data.ActiveEventsInfo;   import baglocked.BaglockedManager;   import calendar.CalendarControl;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class LimitActContent extends Sprite implements Disposeable   {            public static const PICC_PRICE:int = 10000;                   private var _limitView:LimitActView;            private var _titleField:FilterFrameText;            private var _titleBack:Bitmap;            private var _scrollList:ScrollPanel;            private var _back:MutipleImage;            private var _getButton:SimpleBitmapButton;            private var _exchangeButton:SimpleBitmapButton;            private var _piccBtn:SimpleBitmapButton;            private var _activityInfo:ActiveEventsInfo;            public function LimitActContent(info:ActiveEventsInfo) { super(); }
            private function initView(info:ActiveEventsInfo) : void { }
            private function initEvents() : void { }
            private function showBtn() : void { }
            private function removeEvents() : void { }
            private function __getAward(event:MouseEvent) : void { }
            private function __onLoadError(event:LoaderEvent) : void { }
            private function __exchange(event:MouseEvent) : void { }
            private function __activityLoadComplete(event:LoaderEvent) : void { }
            protected function __piccHandler(event:MouseEvent) : void { }
            protected function __responseHandler(event:FrameEvent) : void { }
            private function __poorManResponse(event:FrameEvent) : void { }
            public function dispose() : void { }
   }}