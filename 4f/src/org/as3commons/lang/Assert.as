package org.as3commons.lang
{
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public final class Assert
   {
       
      
      public function Assert(){super();}
      
      public static function isTrue(param1:Boolean, param2:String = "") : void{}
      
      public static function notAbstract(param1:Object, param2:Class, param3:String = "") : void{}
      
      public static function notNull(param1:Object, param2:String = "") : void{}
      
      public static function instanceOf(param1:*, param2:Class, param3:String = "") : void{}
      
      public static function subclassOf(param1:Class, param2:Class, param3:String = "") : void{}
      
      public static function implementationOf(param1:*, param2:Class, param3:String = "") : void{}
      
      public static function state(param1:Boolean, param2:String = "") : void{}
      
      public static function hasText(param1:String, param2:String = "") : void{}
      
      public static function dictionaryKeysOfType(param1:Dictionary, param2:Class, param3:String = "") : void{}
      
      public static function arrayContains(param1:Array, param2:*, param3:String = "") : void{}
      
      public static function arrayItemsOfType(param1:Array, param2:Class, param3:String = "") : void{}
   }
}
