package game.objects
{
   import flash.display.Bitmap;
   
   public class BombAsset
   {
       
      
      public var crater:Bitmap;
      
      public var craterBrink:Bitmap;
      
      public function BombAsset()
      {
         super();
      }
      
      public function dispose() : void
      {
         if(crater && crater.bitmapData)
         {
            crater.bitmapData.dispose();
            crater = null;
         }
         if(craterBrink && craterBrink.bitmapData)
         {
            craterBrink.bitmapData.dispose();
            craterBrink = null;
         }
      }
   }
}
