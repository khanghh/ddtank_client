package consortiaRoseFlower
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class ConsortiaRose extends Bitmap
   {
       
      
      public var curFrame:Number;
      
      public function ConsortiaRose(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = true)
      {
         super(bitmapData,pixelSnapping,smoothing);
      }
   }
}
