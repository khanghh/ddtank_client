package store
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   
   public class StoreDragInArea extends Sprite implements IAcceptDrag
   {
      
      public static const RECTWIDTH:int = 340;
      
      public static const RECTHEIGHT:int = 360;
       
      
      protected var _cells:Array;
      
      public function StoreDragInArea(param1:Array){super();}
      
      private function init() : void{}
      
      public function dragDrop(param1:DragEffect) : void{}
      
      public function dispose() : void{}
   }
}
