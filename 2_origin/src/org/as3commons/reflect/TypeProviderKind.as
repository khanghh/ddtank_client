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
      
      public function TypeProviderKind(value:String)
      {
         super();
         Assert.state(!_enumCreated,"TypeProviderKind enumeration has already been created");
         this._value = value;
         _items[this._value] = this;
      }
      
      public static function fromValue(value:String) : TypeProviderKind
      {
         return _items[value] as TypeProviderKind;
      }
      
      public function get value() : String
      {
         return this._value;
      }
      
      public function toString() : String
      {
         return StringUtils.substitute("[TypeProviderKind(value=\'{0}\')]",this.value);
      }
   }
}
