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
      
      public function StoneCell(param1:Array, param2:int){super(null,null);}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      public function get types() : Array{return null;}
      
      override public function dispose() : void{}
   }
}
