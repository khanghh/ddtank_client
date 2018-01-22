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
      
      public function PixelImage(param1:Texture, param2:BitmapData)
      {
         super(param1);
         if(param2 == null)
         {
            throw new ArgumentError("BitmapData cannot be null");
         }
         _bitmapData = param2;
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(param2 && (!visible || !touchable))
         {
            return null;
         }
         if(mask && !hitTestMask(param1))
         {
            return null;
         }
         var _loc3_:uint = _bitmapData.getPixel32(param1.x,param1.y);
         var _loc4_:uint = _loc3_ >> 24;
         if(_loc4_ > 1)
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
