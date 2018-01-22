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
      
      public function drawDisplayObject(param1:DisplayObject = null) : BitmapData
      {
         var _loc3_:Rectangle = null;
         var _loc4_:BitmapData = null;
         var _loc5_:Matrix = null;
         var _loc2_:Rectangle = param1.getBounds(param1);
         if(param1 is Stage || _loc2_.width != 0 && _loc2_.height != 0)
         {
            _loc3_ = new Rectangle(0,0,Math.abs(_loc2_.width),Math.abs(_loc2_.height));
            _loc3_.width = _loc3_.width > 2880?Number(2880):Number(_loc3_.width);
            _loc3_.height = _loc3_.height > 2880?Number(2880):Number(_loc3_.height);
            _loc4_ = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _loc5_ = new Matrix();
            _loc5_.translate(-_loc2_.x,-_loc2_.y);
            _loc4_.draw(param1,_loc5_);
         }
         return _loc4_;
      }
   }
}
