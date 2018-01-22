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
      
      public function WindPowerImgData()
      {
         super();
         _init();
      }
      
      private function _init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _imgBitmapVec = new Vector.<BitmapData>();
         while(_loc2_ < 11)
         {
            _loc1_ = new BitmapData(1,1);
            _imgBitmapVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function refeshData(param1:ByteArray, param2:int) : void
      {
         bmpBytData = param1;
         bmpID = param2;
         _imgLoadOk = function(param1:Event):void
         {
            BitmapData(_imgBitmapVec[bmpID]).dispose();
            _imgBitmapVec[bmpID] = Bitmap(imgLoad.contentLoaderInfo.content).bitmapData;
            imgLoad.contentLoaderInfo.removeEventListener("complete",_imgLoadOk);
            imgLoad.unload();
            imgLoad = null;
         };
         var imgLoad:Loader = new Loader();
         imgLoad.contentLoaderInfo.addEventListener("complete",_imgLoadOk);
         imgLoad.loadBytes(bmpBytData);
      }
      
      public function getImgBmp(param1:Array) : BitmapData
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:BitmapData = new BitmapData(_imgBitmapVec[param1[1]].width + _imgBitmapVec[param1[2]].width + _imgBitmapVec[param1[3]].width,_imgBitmapVec[0].height);
         _loc4_ = 1;
         while(_loc4_ <= 3)
         {
            _loc2_ = 0;
            switch(int(_loc4_) - 2)
            {
               case 0:
                  _loc2_ = _imgBitmapVec[param1[1]].width;
                  break;
               case 1:
                  _loc2_ = _imgBitmapVec[param1[1]].width + _imgBitmapVec[param1[2]].width;
            }
            _loc3_.copyPixels(_imgBitmapVec[param1[_loc4_]],_imgBitmapVec[param1[_loc4_]].rect,new Point(_loc2_,0));
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getImgBmpById(param1:int) : BitmapData
      {
         var _loc2_:BitmapData = _imgBitmapVec[param1];
         return _loc2_;
      }
   }
}
