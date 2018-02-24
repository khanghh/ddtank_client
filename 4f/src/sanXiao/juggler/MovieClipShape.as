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
      
      public function MovieClipShape(param1:String, param2:BitmapSheet, param3:Number){super();}
      
      public function play() : void{}
      
      public function reset() : void{}
      
      public function advance(param1:Number) : void{}
      
      public function dispose() : void{}
      
      public function get loop() : Boolean{return false;}
      
      public function set loop(param1:Boolean) : void{}
      
      private function draw(param1:int) : void{}
      
      public function get pivotX() : Number{return 0;}
      
      public function set pivotX(param1:Number) : void{}
      
      public function get pivotY() : Number{return 0;}
      
      public function set pivotY(param1:Number) : void{}
      
      public function get isPlaying() : Boolean{return false;}
   }
}
