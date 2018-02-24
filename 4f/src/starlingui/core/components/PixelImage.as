package starlingui.core.components
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class PixelImage extends Image
   {
       
      
      private var _bitmapData:BitmapData;
      
      public function PixelImage(param1:Texture, param2:BitmapData){super(null);}
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject{return null;}
      
      override public function dispose() : void{}
   }
}
