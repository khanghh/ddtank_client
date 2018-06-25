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
      
      public function StoneCell(stoneType:Array, $index:int)
      {
         var bg:Sprite = new Sprite();
         var bgBit:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtstore.BlankCellBG");
         bg.addChild(bgBit);
         super(bg,$index);
         _types = stoneType;
         setContentSize(62,62);
         PicPos = new Point(17,17);
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
            if(sourceInfo.CategoryID == 11 && _types.indexOf(sourceInfo.Property1) > -1 && sourceInfo.getRemainDate() > 0)
            {
               SocketManager.Instance.out.sendMoveGoods(sourceInfo.BagType,sourceInfo.Place,12,index,1,false);
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
