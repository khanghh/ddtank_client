package yzhkof
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class ToolBitmapData
   {
      
      private static var instance:ToolBitmapData;
       
      
      public function ToolBitmapData()
      {
         super();
         if(instance != null)
         {
            throw new Error("ToolBitmapData Singleton already constructed!");
         }
         instance = this;
      }
      
      public static function getInstance() : ToolBitmapData
      {
         if(instance == null)
         {
            instance = new ToolBitmapData();
         }
         return instance;
      }
      
      public function drawDisplayObject(obj:DisplayObject = null) : BitmapData
      {
         var bimap_rect:Rectangle = null;
         var bitmapdata:BitmapData = null;
         var matrix:Matrix = null;
         var rect:Rectangle = obj.getBounds(obj);
         if(obj is Stage || rect.width != 0 && rect.height != 0)
         {
            bimap_rect = new Rectangle(0,0,Math.abs(rect.width),Math.abs(rect.height));
            bimap_rect.width = bimap_rect.width > 2880?Number(2880):Number(bimap_rect.width);
            bimap_rect.height = bimap_rect.height > 2880?Number(2880):Number(bimap_rect.height);
            bitmapdata = new BitmapData(bimap_rect.width,bimap_rect.height,true,0);
            matrix = new Matrix();
            matrix.translate(-rect.x,-rect.y);
            bitmapdata.draw(obj,matrix);
         }
         return bitmapdata;
      }
   }
}
