package store.godRefining.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class GodRefiningPreItemCell extends BagCell
   {
       
      
      protected var _index:int;
      
      public function GodRefiningPreItemCell()
      {
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Bitmap = new Bitmap(new BitmapData(60,60));
         _loc2_.visible = false;
         _loc1_.addChild(_loc2_);
         super(0,null,false,_loc1_);
         tipDirctions = "7,5,2,6,4,1";
         setContentSize(68,68);
         PicPos = new Point(-3,0);
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
      }
   }
}
