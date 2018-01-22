package store
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class StoneCell extends StoreCell
   {
      
      public static const CONTENTSIZE:int = 62;
      
      public static const PICPOS:int = 17;
       
      
      protected var _types:Array;
      
      public function StoneCell(param1:Array, param2:int)
      {
         var _loc3_:Sprite = new Sprite();
         var _loc4_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtstore.BlankCellBG");
         _loc3_.addChild(_loc4_);
         super(_loc3_,param2);
         _types = param1;
         setContentSize(62,62);
         PicPos = new Point(17,17);
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
            if(_loc2_.CategoryID == 11 && _types.indexOf(_loc2_.Property1) > -1 && _loc2_.getRemainDate() > 0)
            {
               SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,index,1,false);
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
