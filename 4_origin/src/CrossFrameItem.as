package
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.events.PropertyChangeEvent;
   
   public class CrossFrameItem extends FrameByFrameItem
   {
       
      
      protected var _frames:Vector.<int>;
      
      public function CrossFrameItem(param1:Number, param2:Number, param3:BitmapData, param4:Vector.<int> = null, param5:String = "original", param6:Boolean = false)
      {
         var _loc7_:int = 0;
         super(param1,param2,param3,param5,param6);
         _type = BitmapRendItem.CROSS_FRAME;
         if(param4 == null)
         {
            param4 = new Vector.<int>();
            _loc7_ = 0;
            while(_loc7_ < _len)
            {
               param4.push(_loc7_);
               _loc7_++;
            }
         }
         this.invalid(param4);
         this._frames = param4;
         _len = this._frames.length;
      }
      
      override function get copyInfo() : Array
      {
         if(_moveInfo)
         {
            x = _moveInfo[_index % _moveInfo.length].x;
            y = _moveInfo[_index % _moveInfo.length].y;
         }
         if(scaleX == 1)
         {
            return [_source,_rects[this._frames[_index]],new Point(x,y)];
         }
         return [_source,new Rectangle(x,y,_itemWidth,_itemHeight),new Point(-x - _rects[this._frames[_index]].x - _itemWidth,y)];
      }
      
      protected function invalid(param1:Vector.<int>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         for each(_loc3_ in param1)
         {
            if(_loc3_ > _loc2_)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_rects && _rects.length <= _loc2_)
         {
            throw new Error("帧数超出了图片的大小");
         }
      }
      
      public function set _896505829source(param1:BitmapData) : void
      {
         super.source = param1;
         this.invalid(this._frames);
      }
      
      override protected function update() : void
      {
         if(_realRender && rendMode == BitmapRendMode.ORIGINAL)
         {
            bitmapData.lock();
            bitmapData.fillRect(_selfRect,0);
            bitmapData.copyPixels(_source,_rects[this._frames[_index]],_offset,null,null,true);
            bitmapData.unlock();
         }
         if(_moveInfo)
         {
            x = _moveInfo[_index % _moveInfo.length].x;
            y = _moveInfo[_index % _moveInfo.length].y;
         }
         _index++;
         if(_index >= _len)
         {
            if(_autoStop)
            {
               stop();
            }
            _index = 0;
         }
      }
      
      public function get frames() : Vector.<int>
      {
         return this._frames.concat();
      }
      
      private function set _1266514778frames(param1:Vector.<int>) : void
      {
         if(this._frames == param1)
         {
            return;
         }
         this.invalid(param1);
         this._frames = param1;
         _len = this._frames.length;
      }
      
      override public function get typeToString() : String
      {
         return "跳帧位图影片";
      }
      
      override public function toXml() : XML
      {
         var _loc1_:XML = <asset/>;
         _loc1_.@type = type;
         _loc1_.@width = _itemWidth;
         _loc1_.@height = _itemHeight;
         _loc1_.@resource = _sourceName;
         _loc1_.@frames = this._frames.toString();
         _loc1_.@x = x;
         _loc1_.@y = y;
         _loc1_.@name = name;
         _loc1_.@rendMode = rendMode;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      override public function set source(param1:BitmapData) : void
      {
         var _loc2_:Object = this.source;
         if(_loc2_ !== param1)
         {
            this._896505829source = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"source",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set frames(param1:Vector.<int>) : void
      {
         var _loc2_:Object = this.frames;
         if(_loc2_ !== param1)
         {
            this._1266514778frames = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"frames",_loc2_,param1));
            }
         }
      }
   }
}
