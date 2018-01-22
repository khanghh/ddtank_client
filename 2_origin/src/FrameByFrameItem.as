package
{
   import flash.display.BitmapData;
   import flash.display.PixelSnapping;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class FrameByFrameItem extends BitmapRendItem
   {
       
      
      protected var _source:BitmapData;
      
      protected var _autoStop:Boolean;
      
      protected var _rects:Vector.<Rectangle>;
      
      protected var _moveInfo:Vector.<Point>;
      
      protected var _index:int = 0;
      
      protected var _offset:Point;
      
      protected var _len:int;
      
      protected var _sourceName:String;
      
      public function FrameByFrameItem(param1:Number, param2:Number, param3:BitmapData, param4:String = "original", param5:Boolean = false)
      {
         super(param1,param2,param4,PixelSnapping.NEVER,false);
         _type = BitmapRendItem.FRAME_BY_FRAME;
         this._source = param3;
         this._autoStop = param5;
         this._offset = new Point();
         this.initRectangles();
         this._len = this._rects.length;
      }
      
      public function set source(param1:BitmapData) : void
      {
         if(this._source == param1)
         {
            return;
         }
         this._source = param1;
         this.initRectangles();
         this._len = this._rects.length;
      }
      
      public function get sourceName() : String
      {
         return this._sourceName;
      }
      
      public function set sourceName(param1:String) : void
      {
         this._sourceName = param1;
      }
      
      public function get source() : BitmapData
      {
         return this._source;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._source = null;
      }
      
      private function initRectangles() : void
      {
         var _loc4_:int = 0;
         this._rects = new Vector.<Rectangle>();
         var _loc1_:int = Math.ceil(this._source.width / _itemWidth);
         var _loc2_:int = Math.ceil(this._source.height / _itemHeight);
         var _loc3_:int = 1;
         while(_loc3_ <= _loc2_)
         {
            _loc4_ = 1;
            while(_loc4_ <= _loc1_)
            {
               this._rects.push(new Rectangle((_loc4_ - 1) * _itemWidth,(_loc3_ - 1) * _itemHeight,_itemWidth,_itemHeight));
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      override public function get totalFrames() : int
      {
         return this._len;
      }
      
      override function get copyInfo() : Array
      {
         if(scaleX == 1)
         {
            return [this._source,this._rects[this._index],new Point(x,y)];
         }
         return [this._source,new Rectangle(x,y,_itemWidth,_itemHeight),new Point(-this._rects[this._index].x - x - _itemWidth,y)];
      }
      
      override public function reset() : void
      {
         this._index = 0;
      }
      
      public function set moveInfo(param1:Vector.<Point>) : void
      {
         this._moveInfo = param1;
      }
      
      override protected function update() : void
      {
         if(_realRender && rendMode == BitmapRendMode.ORIGINAL)
         {
            bitmapData.lock();
            bitmapData.fillRect(_selfRect,0);
            bitmapData.copyPixels(this._source,this._rects[this._index],this._offset,null,null,true);
            bitmapData.unlock();
         }
         if(this._moveInfo)
         {
            x = this._moveInfo[this._index % this._moveInfo.length].x;
            y = this._moveInfo[this._index % this._moveInfo.length].y;
         }
         this._index++;
         if(this._index >= this._len)
         {
            if(this._autoStop)
            {
               stop();
            }
            this._index = 0;
         }
      }
      
      public function get autoStop() : Boolean
      {
         return this._autoStop;
      }
      
      public function set autoStop(param1:Boolean) : void
      {
         this._autoStop = param1;
      }
      
      override public function toXml() : XML
      {
         var _loc1_:XML = <asset/>;
         _loc1_.@type = type;
         _loc1_.@width = _itemWidth;
         _loc1_.@height = _itemHeight;
         _loc1_.@resource = this._sourceName;
         _loc1_.@rendMode = rendMode;
         return _loc1_;
      }
      
      override public function get typeToString() : String
      {
         return "逐帧位图影片";
      }
   }
}
