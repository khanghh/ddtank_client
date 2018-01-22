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
   
   public class GodRefiningStoneCell extends StoreCell
   {
       
      
      protected var _types:Array;
      
      public function GodRefiningStoneCell(param1:Array, param2:int){super(null,null);}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      public function get types() : Array{return null;}
      
      override public function dispose() : void{}
   }
}
