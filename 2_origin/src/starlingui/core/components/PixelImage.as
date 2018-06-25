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
      
      public function PixelImage(texture:Texture, bitmapData:BitmapData)
      {
         super(texture);
         if(bitmapData == null)
         {
            throw new ArgumentError("BitmapData cannot be null");
         }
         _bitmapData = bitmapData;
      }
      
      override public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject
      {
         if(forTouch && (!visible || !touchable))
         {
            return null;
         }
         if(mask && !hitTestMask(localPoint))
         {
            return null;
         }
         var color:uint = _bitmapData.getPixel32(localPoint.x,localPoint.y);
         var alpha:uint = color >> 24;
         if(alpha > 1)
         {
            return this;
         }
         return null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _bitmapData = null;
      }
   }
}
