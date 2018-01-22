package store.godRefining.view
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   import store.StoreCell;
   
   public class GodRefiningResetStoneCell extends StoreCell
   {
       
      
      protected var _types:Array;
      
      public function GodRefiningResetStoneCell(param1:Array, param2:int)
      {
         var _loc3_:Sprite = new Sprite();
         var _loc4_:Bitmap = new Bitmap(new BitmapData(75,75));
         _loc4_.visible = false;
         _loc3_.addChild(_loc4_);
         super(_loc3_,param2);
         _types = param1;
         setContentSize(62,62);
         PicPos = new Point(9,10);
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc2_.BagType == 12 && info != null)
         {
            return;
         }
         if(_loc2_ && param1.action != "split")
         {
            param1.action = "none";
            if(EquipType.isArmShellResetStone(_loc2_))
            {
               SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,index,_loc2_.Count,true);
               param1.action = "none";
               DragManager.acceptDrag(this);
            }
         }
      }
      
      public function get types() : Array
      {
         return _types;
      }
      
      override public function dispose() : void
      {
         _types = null;
         super.dispose();
      }
   }
}
