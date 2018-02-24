package halloween.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HalloweenExchangeView extends Sprite implements Disposeable
   {
       
      
      private var _idArray:Array;
      
      private var _itemsArray:Array;
      
      public function HalloweenExchangeView(){super();}
      
      private function initEvent() : void{}
      
      protected function __onUpdateExchangeCellInfo(param1:BagEvent) : void{}
      
      public function set info(param1:Array) : void{}
      
      private function setExchangeCellInfo() : void{}
      
      private function __onExchange(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
