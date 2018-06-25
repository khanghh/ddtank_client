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
      
      public function BitmapSheet(bitmapData:BitmapData, xml:XML)
      {
         super();
         _bmpData = bitmapData;
         _xml = xml;
         _mTextureRegions = new Dictionary();
         _mTextureFrames = new Dictionary();
         _bmpDataList = new Dictionary();
         if(_xml)
         {
            parseAtlasXml(_xml);
         }
      }
      
      private function parseAtlasXml(atlasXml:XML) : void
      {
         var name:* = null;
         var x:Number = NaN;
         var y:Number = NaN;
         var width:Number = NaN;
         var height:Number = NaN;
         var frameX:Number = NaN;
         var frameY:Number = NaN;
         var frameWidth:Number = NaN;
         var frameHeight:Number = NaN;
         var region:* = null;
         var frame:* = null;
         var _loc15_:int = 0;
         var _loc14_:* = atlasXml.SubTexture;
         for each(var subTexture in atlasXml.SubTexture)
         {
            name = subTexture.attribute("name");
            x = parseFloat(subTexture.attribute("x"));
            y = parseFloat(subTexture.attribute("y"));
            width = parseFloat(subTexture.attribute("width"));
            height = parseFloat(subTexture.attribute("height"));
            frameX = parseFloat(subTexture.attribute("frameX"));
            frameY = parseFloat(subTexture.attribute("frameY"));
            frameWidth = parseFloat(subTexture.attribute("frameWidth"));
            frameHeight = parseFloat(subTexture.attribute("frameHeight"));
            region = new Rectangle(x,y,width,height);
            frame = frameWidth > 0 && frameHeight > 0?new Rectangle(frameX,frameY,frameWidth,frameHeight):null;
            addRegion(name,region,frame);
         }
      }
      
      private function addRegion(name:String, region:Rectangle, frame:Rectangle = null) : void
      {
         _mTextureRegions[name] = region;
         if(frame)
         {
            _mTextureFrames[name] = frame;
         }
      }
      
      public function getRegion(name:String) : Rectangle
      {
         return _mTextureRegions[name];
      }
      
      public function getRegionList(prefix:String) : Vector.<Rectangle>
      {
         var name:* = null;
         var rects:Vector.<Rectangle> = new Vector.<Rectangle>(0);
         var names:Vector.<String> = new Vector.<String>(0);
         var _loc6_:int = 0;
         var _loc5_:* = _mTextureRegions;
         for(name in _mTextureRegions)
         {
            if(name.indexOf(prefix) == 0)
            {
               names.push(name);
            }
         }
         names.sort(1);
         var _loc8_:int = 0;
         var _loc7_:* = names;
         for each(name in names)
         {
            rects.push(_mTextureRegions[name]);
         }
         return rects;
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bmpData;
      }
      
      public function getBitmapData(name:String) : BitmapData
      {
         var s:* = null;
         var r:Rectangle = _mTextureRegions[name];
         var bd:BitmapData = _bmpDataList[name];
         if(!bd)
         {
            bd = new BitmapData(r.width,r.height);
            bd.copyPixels(_bmpData,r,new Point(0,0));
            _bmpDataList[name] = bd;
         }
         return bd;
      }
   }
}
