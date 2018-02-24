package org.as3commons.reflect
{
   import flash.utils.Dictionary;
   import org.as3commons.lang.Assert;
   import org.as3commons.lang.StringUtils;
   
   public final class TypeProviderKind
   {
      
      private static var _enumCreated:Boolean = false;
      
      private static const _items:Dictionary = new Dictionary();
      
      public static const JSON:TypeProviderKind = new TypeProviderKind(JSON_NAME);
      
      public static const XML:TypeProviderKind = new TypeProviderKind(XML_NAME);
      
      private static const JSON_NAME:String = "JSONTypeProvider";
      
      private static const XML_NAME:String = "XMLTypeProvider";
      
      {
         _enumCreated = true;
      }
      
      private var _value:String;
      
      public function TypeProviderKind(param1:String){super();}
      
      public static function fromValue(param1:String) : TypeProviderKind{return null;}
      
      public function get value() : String{return null;}
      
      public function toString() : String{return null;}
   }
}
