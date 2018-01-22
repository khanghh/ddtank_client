package enchant.view
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import enchant.EnchantManager;
   import flash.display.Sprite;
   
   public class EnchantLeftDragSprite extends Sprite implements IAcceptDrag
   {
       
      
      public var equipCellActionState:Boolean;
      
      public function EnchantLeftDragSprite(){super();}
      
      public function dragDrop(param1:DragEffect) : void{}
   }
}
