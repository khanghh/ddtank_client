package morn.core.components
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import morn.core.utils.BitmapUtils;
   
   public final class AutoBitmap extends Bitmap
   {
       
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _sizeGrid:Array;
      
      private var _source:Vector.<BitmapData>;
      
      private var _clips:Vector.<BitmapData>;
      
      private var _index:int;
      
      private var _smoothing:Boolean;
      
      private var _anchorX:Number;
      
      private var _anchorY:Number;
      
      public function AutoBitmap()
      {
         this._smoothing = Styles.smoothing;
         super();
      }
      
      override public function get width() : Number
      {
         return !!isNaN(this._width)?!!super.bitmapData?Number(super.bitmapData.width):Number(super.width):Number(this._width);
      }
      
      override public function set width(param1:Number) : void
      {
         if(this._width != param1)
         {
            this._width = param1;
            this.callLater(this.changeSize);
         }
      }
      
      override public function get height() : Number
      {
         return !!isNaN(this._height)?!!super.bitmapData?Number(super.bitmapData.height):Number(super.height):Number(this._height);
      }
      
      override public function set height(param1:Number) : void
      {
         if(this._height != param1)
         {
            this._height = param1;
            this.callLater(this.changeSize);
         }
      }
      
      public function get sizeGrid() : Array
      {
         return this._sizeGrid;
      }
      
      public function set sizeGrid(param1:Array) : void
      {
         this._sizeGrid = param1;
         this.callLater(this.changeSize);
      }
      
      override public function set bitmapData(param1:BitmapData) : void
      {
         if(param1)
         {
            this.clips = new <BitmapData>[param1];
         }
         else
         {
            this.disposeTempBitmapdata();
            this._source = this._clips = null;
            super.bitmapData = null;
         }
      }
      
      public function get clips() : Vector.<BitmapData>
      {
         return this._source;
      }
      
      public function set clips(param1:Vector.<BitmapData>) : void
      {
         this.disposeTempBitmapdata();
         this._source = param1;
         if(param1 && param1.length > 0)
         {
            super.bitmapData = param1[0];
            this.callLater(this.changeSize);
         }
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(param1:int) : void
      {
         this._index = param1;
         if(this._clips && this._clips.length > 0)
         {
            this._index = this._index < this._clips.length && this._index > -1?int(this._index):0;
            super.bitmapData = this._clips[this._index];
            super.smoothing = this._smoothing;
         }
      }
      
      private function changeSize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<BitmapData> = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this._source && this._source.length > 0)
         {
            _loc1_ = Math.round(this.width);
            _loc2_ = Math.round(this.height);
            this.disposeTempBitmapdata();
            _loc3_ = new Vector.<BitmapData>();
            _loc4_ = 0;
            _loc5_ = this._source.length;
            while(_loc4_ < _loc5_)
            {
               if(this._sizeGrid)
               {
                  _loc3_.push(BitmapUtils.scale9Bmd(this._source[_loc4_],this._sizeGrid,_loc1_,_loc2_));
               }
               else
               {
                  _loc3_.push(this._source[_loc4_]);
               }
               _loc4_++;
            }
            this._clips = _loc3_;
            this.index = this._index;
            super.width = _loc1_;
            super.height = _loc2_;
         }
         if(!isNaN(this._anchorX))
         {
            super.x = -Math.round(this._anchorX * this.width);
         }
         if(!isNaN(this._anchorY))
         {
            super.y = -Math.round(this._anchorY * this.height);
         }
      }
      
      private function disposeTempBitmapdata() : void
      {
         var _loc1_:int = 0;
         if(this._clips)
         {
            _loc1_ = this._clips.length - 1;
            while(_loc1_ > -1)
            {
               if(!this._source.length)
               {
                  return;
               }
               if(this._clips[_loc1_] != this._source[_loc1_])
               {
                  this._clips[_loc1_].dispose();
               }
               _loc1_--;
            }
            this._clips.length = 0;
         }
      }
      
      override public function get smoothing() : Boolean
      {
         return this._smoothing;
      }
      
      override public function set smoothing(param1:Boolean) : void
      {
         super.smoothing = this._smoothing = param1;
      }
      
      public function get anchorX() : Number
      {
         return this._anchorX;
      }
      
      public function set anchorX(param1:Number) : void
      {
         this._anchorX = param1;
      }
      
      public function get anchorY() : Number
      {
         return this._anchorY;
      }
      
      public function set anchorY(param1:Number) : void
      {
         this._anchorY = param1;
      }
      
      public function callLater(param1:Function, param2:Array = null) : void
      {
         var _loc3_:Array = [this];
         if(param2 && param2.length > 0)
         {
            _loc3_ = _loc3_.concat(param2);
         }
         App.render.callLater(param1,_loc3_);
      }
      
      public function dispose() : void
      {
         App.render.removeCallLaterByObj(this);
         this._sizeGrid = null;
         this._source = null;
         this._clips = null;
         this.bitmapData = null;
      }
   }
}
