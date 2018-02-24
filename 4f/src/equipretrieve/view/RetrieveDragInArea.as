package equipretrieve.view
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
   import store.StoreCell;
   
   public class RetrieveDragInArea extends Sprite implements IAcceptDrag
   {
      
      public static const RECTWIDTH:int = 376;
      
      public static const RECTHEIGHT:int = 440;
       
      
      protected var _cells:Vector.<StoreCell>;
      
      public function RetrieveDragInArea(param1:Vector.<StoreCell>){super();}
      
      private function init() : void{}
      
      public function dragDrop(param1:DragEffect) : void{}
      
      public function dispose() : void{}
   }
}
