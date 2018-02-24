package ddt.utils
{
   import com.gskinner.geom.ColorMatrix;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class Helpers
   {
      
      private static var _stage:Stage;
      
      public static const STAGE_UP_EVENT:String = "STAGE_UP_EVENT";
      
      public static const MOUSE_DOWN_AND_DRAGING_EVENT:String = "MOUSE_DOWN_AND_DRAGING_EVENT";
      
      private static var enterFrameDispatcher:Sprite = new Sprite();
      
      private static const encode_arr:Array = [["%","%01"],["]","%02"],["\\[","%03"]];
      
      private static const decode_arr:Array = [["%","%01"],["]","%02"],["[","%03"]];
       
      
      public function Helpers(){super();}
      
      public static function setTextfieldFormat(param1:TextField, param2:Object, param3:Boolean = false) : void{}
      
      public static function hidePosMc(param1:DisplayObjectContainer) : void{}
      
      public static function registExtendMouseEvent(param1:InteractiveObject) : void{}
      
      private static function __dobjDown(param1:MouseEvent) : void{}
      
      public static function delayCall(param1:Function, param2:int = 1) : void{}
      
      public static function copyProperty(param1:Object, param2:Object, param3:Array = null) : void{}
      
      public static function enCodeString(param1:String) : String{return null;}
      
      public static function deCodeString(param1:String) : String{return null;}
      
      public static function setup(param1:Stage) : void{}
      
      public static function randomPick(param1:Array) : *{return null;}
      
      public static function clone(param1:Object) : *{return null;}
      
      public static function grey(param1:DisplayObject) : void{}
      
      public static function colorful(param1:DisplayObject) : void{}
      
      public static function setHue(param1:DisplayObject, param2:int) : void{}
      
      public static function resetHue(param1:DisplayObject) : void{}
      
      public static function getTimeString(param1:Number, param2:String = "") : String{return null;}
      
      public static function fixZero(param1:String) : String{return null;}
      
      public static function scaleDisplayObject(param1:DisplayObject, param2:*, param3:*, param4:Number = 0) : void{}
      
      public static function spaceString(param1:Number, param2:Number = 8) : String{return null;}
   }
}
