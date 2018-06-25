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
      
      public function GodRefiningResetStoneCell(stoneType:Array, $index:int)
      {
         var bg:Sprite = new Sprite();
         var bgBit:Bitmap = new Bitmap(new BitmapData(75,75));
         bgBit.visible = false;
         bg.addChild(bgBit);
         super(bg,$index);
         _types = stoneType;
         setContentSize(62,62);
         PicPos = new Point(9,10);
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var sourceInfo:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(sourceInfo.BagType == 12 && info != null)
         {
            return;
         }
         if(sourceInfo && effect.action != "split")
         {
            effect.action = "none";
            if(EquipType.isArmShellResetStone(sourceInfo))
            {
               SocketManager.Instance.out.sendMoveGoods(sourceInfo.BagType,sourceInfo.Place,12,index,sourceInfo.Count,true);
               effect.action = "none";
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
