package ddt.utils
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class BitmapUtils
   {
      
      private static var _maskShape:Shape;
      
      private static var _curX:Number;
      
      private static var _curY:Number;
      
      private static var _rowNumber:Number;
      
      private static var _rowWitdh:Number;
      
      private static var _rowHeight:Number;
      
      private static var _frameStep:Number;
      
      private static var _curRow:Number = 0;
      
      private static var _sleepSecond:int = 0;
      
      private static var _callBack:Function;
      
      private static var _timer:TimerJuggler;
      
      private static var _isMask:String;
       
      
      public function BitmapUtils(){super();}
      
      public static function updateColor(param1:BitmapData, param2:Number) : BitmapData{return null;}
      
      public static function getHightlightColorTransfrom(param1:uint) : ColorTransform{return null;}
      
      public static function setBitmapDataGray(param1:BitmapData) : void{}
      
      public static function getColorTransfromByColor(param1:uint) : ColorTransform{return null;}
      
      public static function maskMovie(param1:DisplayObject, param2:Shape, param3:String, param4:Number, param5:Number, param6:Number, param7:Number, param8:int, param9:Function) : void{}
      
      private static function onMaskMovieEnerFrame(param1:Event) : void{}
      
      private static function onMaskMovieTimer(param1:Event) : void{}
      
      public static function reverseBtimapData(param1:BitmapData) : void{}
   }
}
