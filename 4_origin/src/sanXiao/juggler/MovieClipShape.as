package sanXiao.juggler
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class MovieClipShape extends Shape
   {
       
      
      private var _pivotX:Number;
      
      private var _pivotY:Number;
      
      private var _xml:XML;
      
      private var _rectangleList:Vector.<Rectangle>;
      
      private var _bmpSheet:BitmapSheet;
      
      private var _fps:Number;
      
      private var _totalTime:Number;
      
      private var _currentTime:Number;
      
      private var _duration:Number;
      
      private var _isPlaying:Boolean;
      
      private var _currentFrame:int;
      
      private var _totalFrames:int;
      
      private var _loop:Boolean;
      
      private var _m:Matrix;
      
      public function MovieClipShape(prefix:String, bitmapSheet:BitmapSheet, fps:Number)
      {
         super();
         _fps = fps;
         _duration = 1000 / _fps;
         _m = new Matrix();
         _bmpSheet = bitmapSheet;
         _rectangleList = bitmapSheet.getRegionList(prefix);
         _totalTime = _duration * _rectangleList.length;
         _totalFrames = _rectangleList.length;
         _pivotX = 0;
         _pivotY = 0;
         _isPlaying = false;
         _loop = true;
         _currentFrame = 1;
         _currentTime = 0;
         draw(1);
      }
      
      public function play() : void
      {
         _isPlaying = true;
      }
      
      public function reset() : void
      {
         _currentFrame = 1;
         _currentTime = 0;
         draw(1);
         _isPlaying = false;
      }
      
      public function advance(duration:Number) : void
      {
         if(!_isPlaying)
         {
            return;
         }
         _currentTime = _currentTime + duration;
         if(_currentTime < _currentFrame * _duration)
         {
            return;
         }
         _currentFrame = Number(_currentFrame) + 1;
         if(_currentFrame > _totalFrames)
         {
            if(_loop)
            {
               _currentFrame = 1;
               _currentTime = 0;
            }
            else
            {
               _isPlaying = false;
               dispatchEvent(new Event("complete"));
               return;
            }
         }
         draw(_currentFrame);
      }
      
      public function dispose() : void
      {
         _bmpSheet = null;
      }
      
      public function get loop() : Boolean
      {
         return _loop;
      }
      
      public function set loop(value:Boolean) : void
      {
         _loop = value;
      }
      
      private function draw(frameNumber:int) : void
      {
         if(frameNumber > _totalFrames || frameNumber < 1)
         {
            throw "FrameNumber" + frameNumber + " is out of range, total frames : " + _totalFrames;
         }
         var r:Rectangle = _rectangleList[frameNumber - 1];
         this.graphics.clear();
         _m.a = 1;
         _m.b = 0;
         _m.c = 0;
         _m.d = 1;
         _m.tx = -r.x - _pivotX;
         _m.ty = -r.y - _pivotY;
         this.graphics.beginBitmapFill(_bmpSheet.bitmapData,_m,false,true);
         this.graphics.drawRect(-_pivotX,-_pivotY,r.width,r.height);
         this.graphics.endFill();
      }
      
      public function get pivotX() : Number
      {
         return _pivotX;
      }
      
      public function set pivotX(value:Number) : void
      {
         _pivotX = value;
      }
      
      public function get pivotY() : Number
      {
         return _pivotY;
      }
      
      public function set pivotY(value:Number) : void
      {
         _pivotY = value;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
   }
}
