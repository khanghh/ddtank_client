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
         _smoothing = Styles.smoothing;
         super();
      }
      
      override public function get width() : Number
      {
         return !!isNaN(_width)?!!super.bitmapData?super.bitmapData.width:super.width:_width;
      }
      
      override public function set width(value:Number) : void
      {
         if(_width != value)
         {
            _width = value;
            callLater(changeSize);
         }
      }
      
      override public function get height() : Number
      {
         return !!isNaN(_height)?!!super.bitmapData?super.bitmapData.height:super.height:_height;
      }
      
      override public function set height(value:Number) : void
      {
         if(_height != value)
         {
            _height = value;
            callLater(changeSize);
         }
      }
      
      public function get sizeGrid() : Array
      {
         return _sizeGrid;
      }
      
      public function set sizeGrid(value:Array) : void
      {
         _sizeGrid = value;
         callLater(changeSize);
      }
      
      override public function set bitmapData(value:BitmapData) : void
      {
         if(value)
         {
            clips = new <BitmapData>[value];
         }
         else
         {
            disposeTempBitmapdata();
            _clips = null;
            _source = null;
            .super.bitmapData = null;
         }
      }
      
      public function get clips() : Vector.<BitmapData>
      {
         return _source;
      }
      
      public function set clips(value:Vector.<BitmapData>) : void
      {
         disposeTempBitmapdata();
         _source = value;
         if(value && value.length > 0)
         {
            .super.bitmapData = value[0];
            callLater(changeSize);
         }
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(value:int) : void
      {
         _index = value;
         if(_clips && _clips.length > 0)
         {
            _index = _index < _clips.length && _index > -1?_index:0;
            .super.bitmapData = _clips[_index];
            .super.smoothing = _smoothing;
         }
      }
      
      private function changeSize() : void
      {
         var w:int = 0;
         var h:int = 0;
         var temp:* = undefined;
         var i:int = 0;
         var n:int = 0;
         if(_source && _source.length > 0)
         {
            w = Math.round(width);
            h = Math.round(height);
            disposeTempBitmapdata();
            temp = new Vector.<BitmapData>();
            for(i = 0,n = _source.length; i < n; )
            {
               if(_sizeGrid)
               {
                  temp.push(BitmapUtils.scale9Bmd(_source[i],_sizeGrid,w,h));
               }
               else
               {
                  temp.push(_source[i]);
               }
               i++;
            }
            _clips = temp;
            index = _index;
            .super.width = w;
            .super.height = h;
         }
         if(!isNaN(_anchorX))
         {
            .super.x = -Math.round(_anchorX * width);
         }
         if(!isNaN(_anchorY))
         {
            .super.y = -Math.round(_anchorY * height);
         }
      }
      
      private function disposeTempBitmapdata() : void
      {
         var i:int = 0;
         if(_clips)
         {
            for(i = _clips.length - 1; i > -1; )
            {
               if(!_source.length)
               {
                  return;
               }
               if(_clips[i] != _source[i])
               {
                  _clips[i].dispose();
               }
               i--;
            }
            _clips.length = 0;
         }
      }
      
      override public function get smoothing() : Boolean
      {
         return _smoothing;
      }
      
      override public function set smoothing(value:Boolean) : void
      {
         _smoothing = value;
         .super.smoothing = value;
      }
      
      public function get anchorX() : Number
      {
         return _anchorX;
      }
      
      public function set anchorX(value:Number) : void
      {
         _anchorX = value;
      }
      
      public function get anchorY() : Number
      {
         return _anchorY;
      }
      
      public function set anchorY(value:Number) : void
      {
         _anchorY = value;
      }
      
      public function callLater(method:Function, args:Array = null) : void
      {
         var oargs:Array = [this];
         if(args && args.length > 0)
         {
            oargs = oargs.concat(args);
         }
         App.render.callLater(method,oargs);
      }
      
      public function dispose() : void
      {
         App.render.removeCallLaterByObj(this);
         _sizeGrid = null;
         _source = null;
         _clips = null;
         bitmapData = null;
      }
   }
}
