package org.as3commons.reflect
{
   import flash.system.Capabilities;
   import flash.utils.describeType;
   import org.as3commons.lang.ClassUtils;
   
   public final class ReflectionUtils
   {
      
      private static var _version:String;
      
      private static var _isOldPlayer:Boolean = true;
       
      
      public function ReflectionUtils()
      {
         super();
      }
      
      public static function concatTypeMetadata(param1:Type, param2:Array, param3:String) : void
      {
         var container:IMetadataContainer = null;
         var type:Type = param1;
         var metadataContainers:Array = param2;
         var propertyName:String = param3;
         for each(container in metadataContainers)
         {
            type[propertyName].some(function(param1:Object, param2:int, param3:Array):Boolean
            {
               var _loc4_:Array = null;
               var _loc5_:int = 0;
               var _loc6_:int = 0;
               if(param1.name == Object(container).name)
               {
                  _loc4_ = container.metadata;
                  _loc5_ = _loc4_.length;
                  _loc6_ = 0;
                  while(_loc6_ < _loc5_)
                  {
                     param1.addMetadata(_loc4_[_loc6_]);
                     _loc6_++;
                  }
                  return true;
               }
               return false;
            });
         }
      }
      
      public static function getTypeDescription(param1:Class) : XML
      {
         var _loc4_:XMLList = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc2_:XML = describeType(param1);
         var _loc3_:XMLList = _loc2_.factory.constructor;
         if(_loc3_ && _loc3_.length() > 0)
         {
            _loc4_ = _loc3_[0].parameter;
            if(_loc4_ && _loc4_.length() > 0)
            {
               _loc5_ = [];
               _loc6_ = 0;
               while(_loc6_ < _loc4_.length())
               {
                  _loc5_.push(null);
                  _loc6_++;
               }
               if(playerHasConstructorBug())
               {
                  try
                  {
                     ClassUtils.newInstance(param1,_loc5_);
                  }
                  catch(e:Error)
                  {
                  }
               }
               _loc2_ = describeType(param1);
            }
         }
         return _loc2_;
      }
      
      public static function playerHasConstructorBug() : Boolean
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_version == null)
         {
            _version = Capabilities.version.split(" ")[1];
            _loc1_ = _version.split(",");
            _loc2_ = parseInt(_loc1_[0]);
            _loc3_ = _loc1_.length > 1 && String(_loc1_[1]).length > 0?int(parseInt(_loc1_[1])):0;
            if(_loc2_ < 10)
            {
               _isOldPlayer = true;
            }
            else
            {
               _isOldPlayer = _loc2_ == 10?_loc3_ < 1:false;
            }
         }
         return _isOldPlayer;
      }
   }
}
