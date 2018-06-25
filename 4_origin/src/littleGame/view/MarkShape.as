package littleGame.view
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.ddt_internal;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import littleGame.LittleGameManager;
   
   use namespace ddt_internal;
   
   public class MarkShape extends Bitmap implements Disposeable
   {
       
      
      public function MarkShape(time:int)
      {
         super(null,"auto",true);
         setTime(time);
      }
      
      public function setTime(time:int) : void
      {
         var i:int = 0;
         if(time < 0)
         {
            return;
         }
         var bitmap:BitmapData = LittleGameManager.Instance.Current.markBack.clone();
         var timeStr:String = time.toString();
         var src:BitmapData = LittleGameManager.Instance.Current.bigNum;
         var w:int = src.width / 11;
         var h:int = src.height;
         var left:int = time < 10?145:118;
         var rect:Rectangle = new Rectangle(src.width - w,0,w,h);
         var len:int = timeStr.length;
         for(i = 0; i < len; )
         {
            rect.x = int(timeStr.substr(i,1)) * w;
            bitmap.copyPixels(src,rect,new Point(left + w * i,0));
            i++;
         }
         if(bitmapData)
         {
            bitmapData.dispose();
         }
         bitmapData = bitmap;
      }
      
      public function dispose() : void
      {
         if(bitmapData)
         {
            bitmapData.dispose();
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
