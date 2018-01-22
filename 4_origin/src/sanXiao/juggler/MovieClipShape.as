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
      
      public function MovieClipShape(param1:String, param2:BitmapSheet, param3:Number)
      {
         super();
         _fps = param3;
         _duration = 1000 / _fps;
         _m = new Matrix();
         _bmpSheet = param2;
         _rectangleList = param2.getRegionList(param1);
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
      
      public function advance(param1:Number) : void
      {
         if(!_isPlaying)
         {
            return;
         }
         _currentTime = _currentTime + param1;
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
      
      public function set loop(param1:Boolean) : void
      {
         _loop = param1;
      }
      
      private function draw(param1:int) : void
      {
         if(param1 > _totalFrames || param1 < 1)
         {
            throw "FrameNumber" + param1 + " is out of range, total frames : " + _totalFrames;
         }
         var _loc2_:Rectangle = _rectangleList[param1 - 1];
         this.graphics.clear();
         _m.a = 1;
         _m.b = 0;
         _m.c = 0;
         _m.d = 1;
         _m.tx = -_loc2_.x - _pivotX;
         _m.ty = -_loc2_.y - _pivotY;
         this.graphics.beginBitmapFill(_bmpSheet.bitmapData,_m,false,true);
         this.graphics.drawRect(-_pivotX,-_pivotY,_loc2_.width,_loc2_.height);
         this.graphics.endFill();
      }
      
      public function get pivotX() : Number
      {
         return _pivotX;
      }
      
      public function set pivotX(param1:Number) : void
      {
         _pivotX = param1;
      }
      
      public function get pivotY() : Number
      {
         return _pivotY;
      }
      
      public function set pivotY(param1:Number) : void
      {
         _pivotY = param1;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
   }
}
