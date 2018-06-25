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
         var i:int = 0;
         var bmpData:* = null;
         for(_imgBitmapVec = new Vector.<BitmapData>(); i < 11; )
         {
            bmpData = new BitmapData(1,1);
            _imgBitmapVec.push(bmpData);
            i++;
         }
      }
      
      public function refeshData(bmpBytData:ByteArray, bmpID:int) : void
      {
         bmpBytData = bmpBytData;
         bmpID = bmpID;
         _imgLoadOk = function(e:Event):void
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
      
      public function getImgBmp(arr:Array) : BitmapData
      {
         var i:int = 0;
         var w:int = 0;
         var imgData:BitmapData = new BitmapData(_imgBitmapVec[arr[1]].width + _imgBitmapVec[arr[2]].width + _imgBitmapVec[arr[3]].width,_imgBitmapVec[0].height);
         for(i = 1; i <= 3; )
         {
            w = 0;
            switch(int(i) - 2)
            {
               case 0:
                  w = _imgBitmapVec[arr[1]].width;
                  break;
               case 1:
                  w = _imgBitmapVec[arr[1]].width + _imgBitmapVec[arr[2]].width;
            }
            imgData.copyPixels(_imgBitmapVec[arr[i]],_imgBitmapVec[arr[i]].rect,new Point(w,0));
            i++;
         }
         return imgData;
      }
      
      public function getImgBmpById(id:int) : BitmapData
      {
         var imgData:BitmapData = _imgBitmapVec[id];
         return imgData;
      }
   }
}
