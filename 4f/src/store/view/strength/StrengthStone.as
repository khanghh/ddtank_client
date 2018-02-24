package store.view.strength
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import store.StoneCell;
   
   public class StrengthStone extends StoneCell
   {
       
      
      private var _stoneType:String = "";
      
      private var _itemType:int = -1;
      
      private var _aler:StrengthSelectNumAlertFrame;
      
      public function StrengthStone(param1:Array, param2:int){super(null,null);}
      
      public function set itemType(param1:int) : void{}
      
      public function get itemType() : int{return 0;}
      
      public function get stoneType() : String{return null;}
      
      public function set stoneType(param1:String) : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      private function showNumAlert(param1:InventoryItemInfo, param2:int) : void{}
      
      private function sellFunction(param1:int, param2:InventoryItemInfo, param3:int) : void{}
      
      private function notSellFunction() : void{}
      
      private function reset() : void{}
      
      override public function dispose() : void{}
   }
}
