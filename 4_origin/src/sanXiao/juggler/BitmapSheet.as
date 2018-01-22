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
      
      public function BitmapSheet(param1:BitmapData, param2:XML)
      {
         super();
         _bmpData = param1;
         _xml = param2;
         _mTextureRegions = new Dictionary();
         _mTextureFrames = new Dictionary();
         _bmpDataList = new Dictionary();
         if(_xml)
         {
            parseAtlasXml(_xml);
         }
      }
      
      private function parseAtlasXml(param1:XML) : void
      {
         var _loc6_:* = null;
         var _loc12_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc15_:int = 0;
         var _loc14_:* = param1.SubTexture;
         for each(var _loc11_ in param1.SubTexture)
         {
            _loc6_ = _loc11_.attribute("name");
            _loc12_ = parseFloat(_loc11_.attribute("x"));
            _loc10_ = parseFloat(_loc11_.attribute("y"));
            _loc3_ = parseFloat(_loc11_.attribute("width"));
            _loc4_ = parseFloat(_loc11_.attribute("height"));
            _loc8_ = parseFloat(_loc11_.attribute("frameX"));
            _loc9_ = parseFloat(_loc11_.attribute("frameY"));
            _loc7_ = parseFloat(_loc11_.attribute("frameWidth"));
            _loc13_ = parseFloat(_loc11_.attribute("frameHeight"));
            _loc2_ = new Rectangle(_loc12_,_loc10_,_loc3_,_loc4_);
            _loc5_ = _loc7_ > 0 && _loc13_ > 0?new Rectangle(_loc8_,_loc9_,_loc7_,_loc13_):null;
            addRegion(_loc6_,_loc2_,_loc5_);
         }
      }
      
      private function addRegion(param1:String, param2:Rectangle, param3:Rectangle = null) : void
      {
         _mTextureRegions[param1] = param2;
         if(param3)
         {
            _mTextureFrames[param1] = param3;
         }
      }
      
      public function getRegion(param1:String) : Rectangle
      {
         return _mTextureRegions[param1];
      }
      
      public function getRegionList(param1:String) : Vector.<Rectangle>
      {
         var _loc3_:* = null;
         var _loc4_:Vector.<Rectangle> = new Vector.<Rectangle>(0);
         var _loc2_:Vector.<String> = new Vector.<String>(0);
         var _loc6_:int = 0;
         var _loc5_:* = _mTextureRegions;
         for(_loc3_ in _mTextureRegions)
         {
            if(_loc3_.indexOf(param1) == 0)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sort(1);
         var _loc8_:int = 0;
         var _loc7_:* = _loc2_;
         for each(_loc3_ in _loc2_)
         {
            _loc4_.push(_mTextureRegions[_loc3_]);
         }
         return _loc4_;
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bmpData;
      }
      
      public function getBitmapData(param1:String) : BitmapData
      {
         var _loc2_:* = null;
         var _loc3_:Rectangle = _mTextureRegions[param1];
         var _loc4_:BitmapData = _bmpDataList[param1];
         if(!_loc4_)
         {
            _loc4_ = new BitmapData(_loc3_.width,_loc3_.height);
            _loc4_.copyPixels(_bmpData,_loc3_,new Point(0,0));
            _bmpDataList[param1] = _loc4_;
         }
         return _loc4_;
      }
   }
}
