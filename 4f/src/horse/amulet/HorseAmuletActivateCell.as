package horse.amulet
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Shape;
   import flash.utils.Dictionary;
   import horse.HorseAmuletManager;
   import horse.data.HorseAmuletVo;
   
   public class HorseAmuletActivateCell extends HorseAmuletCell
   {
       
      
      private var _bag:BagInfo;
      
      public function HorseAmuletActivateCell(){super(null,null,null);}
      
      private function init() : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      private function __updateGoods(param1:BagEvent) : void{}
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      public function clearCell() : void{}
      
      private function createBg() : Shape{return null;}
      
      override public function dispose() : void{}
   }
}
