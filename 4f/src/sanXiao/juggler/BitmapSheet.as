package sanXiao.juggler
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class BitmapSheet
   {
       
      
      private var _mTextureRegions:Dictionary;
      
      private var _mTextureFrames:Dictionary;
      
      private var _bmpDataList:Dictionary;
      
      private var _bmpData:BitmapData;
      
      private var _xml:XML;
      
      protected var _bdRegionsList:Vector.<Rectangle>;
      
      public function BitmapSheet(param1:BitmapData, param2:XML){super();}
      
      private function parseAtlasXml(param1:XML) : void{}
      
      private function addRegion(param1:String, param2:Rectangle, param3:Rectangle = null) : void{}
      
      public function getRegion(param1:String) : Rectangle{return null;}
      
      public function getRegionList(param1:String) : Vector.<Rectangle>{return null;}
      
      public function get bitmapData() : BitmapData{return null;}
      
      public function getBitmapData(param1:String) : BitmapData{return null;}
   }
}
