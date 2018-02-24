package par
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class ShapeManager
   {
      
      public static var list:Array = [];
      
      private static var _ready:Boolean;
      
      private static var objects:Dictionary = new Dictionary();
       
      
      public function ShapeManager(){super();}
      
      public static function get ready() : Boolean{return false;}
      
      public static function clear() : void{}
      
      public static function setup() : void{}
      
      public static function create(param1:uint) : DisplayObject{return null;}
      
      private static function creatShape(param1:*) : DisplayObject{return null;}
      
      private static function getFreeObject(param1:Vector.<DisplayObject>, param2:String) : DisplayObject{return null;}
   }
}
