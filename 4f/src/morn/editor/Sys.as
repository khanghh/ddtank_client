package morn.editor
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.Stage;
   
   public class Sys
   {
      
      public static var stage:Stage;
       
      
      public function Sys(){super();}
      
      public static function loadRes(param1:String, param2:Function = null) : void{}
      
      public static function hasRes(param1:String) : Boolean{return false;}
      
      public static function getResClass(param1:String) : Class{return null;}
      
      public static function getRes(param1:String) : *{return null;}
      
      public static function getResBitmapData(param1:String) : BitmapData{return null;}
      
      public static function getCompInstance(param1:XML) : Sprite{return null;}
      
      public static function log(... rest) : void{}
   }
}
