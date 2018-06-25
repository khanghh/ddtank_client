package sanXiao.juggler{   import flash.display.BitmapData;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.Dictionary;      public class BitmapSheet   {                   private var _mTextureRegions:Dictionary;            private var _mTextureFrames:Dictionary;            private var _bmpDataList:Dictionary;            private var _bmpData:BitmapData;            private var _xml:XML;            protected var _bdRegionsList:Vector.<Rectangle>;            public function BitmapSheet(bitmapData:BitmapData, xml:XML) { super(); }
            private function parseAtlasXml(atlasXml:XML) : void { }
            private function addRegion(name:String, region:Rectangle, frame:Rectangle = null) : void { }
            public function getRegion(name:String) : Rectangle { return null; }
            public function getRegionList(prefix:String) : Vector.<Rectangle> { return null; }
            public function get bitmapData() : BitmapData { return null; }
            public function getBitmapData(name:String) : BitmapData { return null; }
   }}