package gameCommon.model
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   
   public class WindPowerImgData extends EventDispatcher
   {
       
      
      private var _imgBitmapVec:Vector.<BitmapData>;
      
      public function WindPowerImgData(){super();}
      
      private function _init() : void{}
      
      public function refeshData(param1:ByteArray, param2:int) : void{}
      
      public function getImgBmp(param1:Array) : BitmapData{return null;}
      
      public function getImgBmpById(param1:int) : BitmapData{return null;}
   }
}
