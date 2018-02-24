package ddt.view.caddyII.badLuck
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.RouletteManager;
   import ddt.manager.SocketManager;
   import ddt.view.caddyII.CaddyEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CaddyBadLuckView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Sprite;
      
      protected var _list:VBox;
      
      protected var _panel:ScrollPanel;
      
      private var _itemList:Vector.<BadLuckItem>;
      
      private var _dataList:Vector.<Object>;
      
      private var _timer:TimerJuggler;
      
      private var _Vline:MutipleImage;
      
      public function CaddyBadLuckView(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __oneTimer(param1:Event) : void{}
      
      private function requestData() : void{}
      
      private function __getBadLuckHandler(param1:CaddyEvent) : void{}
      
      private function updateData() : void{}
      
      public function dispose() : void{}
   }
}
