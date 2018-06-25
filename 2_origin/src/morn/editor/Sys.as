package morn.editor
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.Stage;
   
   public class Sys
   {
      
      public static var stage:Stage;
       
      
      public function Sys()
      {
         super();
      }
      
      public static function loadRes(url:String, loaded:Function = null) : void
      {
      }
      
      public static function hasRes(name:String) : Boolean
      {
         return false;
      }
      
      public static function getResClass(name:String) : Class
      {
         return null;
      }
      
      public static function getRes(name:String) : *
      {
         return null;
      }
      
      public static function getResBitmapData(name:String) : BitmapData
      {
         return null;
      }
      
      public static function getCompInstance(xml:XML) : Sprite
      {
         return null;
      }
      
      public static function log(... args) : void
      {
      }
   }
}
