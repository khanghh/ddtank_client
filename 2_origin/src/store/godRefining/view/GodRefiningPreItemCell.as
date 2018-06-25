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
         var bg:Sprite = new Sprite();
         var bgBit:Bitmap = new Bitmap(new BitmapData(60,60));
         bgBit.visible = false;
         bg.addChild(bgBit);
         super(0,null,false,bg);
         tipDirctions = "7,5,2,6,4,1";
         setContentSize(68,68);
         PicPos = new Point(-3,0);
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
      }
   }
}
