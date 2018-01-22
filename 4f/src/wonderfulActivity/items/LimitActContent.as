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
      
      public function LimitActContent(param1:ActiveEventsInfo){super();}
      
      private function initView(param1:ActiveEventsInfo) : void{}
      
      private function initEvents() : void{}
      
      private function showBtn() : void{}
      
      private function removeEvents() : void{}
      
      private function __getAward(param1:MouseEvent) : void{}
      
      private function __onLoadError(param1:LoaderEvent) : void{}
      
      private function __exchange(param1:MouseEvent) : void{}
      
      private function __activityLoadComplete(param1:LoaderEvent) : void{}
      
      protected function __piccHandler(param1:MouseEvent) : void{}
      
      protected function __responseHandler(param1:FrameEvent) : void{}
      
      private function __poorManResponse(param1:FrameEvent) : void{}
      
      public function dispose() : void{}
   }
}
