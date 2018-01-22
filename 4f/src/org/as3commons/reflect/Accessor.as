package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import org.as3commons.lang.HashArray;
   import org.as3commons.lang.IEquals;
   
   public class Accessor extends Field implements IEquals
   {
      
      private static const _cache:Dictionary = new Dictionary();
       
      
      private var _access:AccessorAccess;
      
      public function Accessor(param1:String, param2:AccessorAccess, param3:String, param4:String, param5:Boolean, param6:ApplicationDomain, param7:HashArray = null){super(null,null,null,null,null,null);}
      
      public static function newInstance(param1:String, param2:AccessorAccess, param3:String, param4:String, param5:Boolean, param6:ApplicationDomain, param7:HashArray = null) : Accessor{return null;}
      
      private static function getCacheKey(param1:String, param2:AccessorAccess, param3:String, param4:String, param5:Boolean, param6:ApplicationDomain, param7:HashArray) : String{return null;}
      
      public function get access() : AccessorAccess{return null;}
      
      public function get readable() : Boolean{return false;}
      
      public function get writeable() : Boolean{return false;}
      
      public function isReadable() : Boolean{return false;}
      
      public function isWriteable() : Boolean{return false;}
      
      override public function equals(param1:Object) : Boolean{return false;}
      
      as3commons_reflect function setAccess(param1:AccessorAccess) : void{}
   }
}
