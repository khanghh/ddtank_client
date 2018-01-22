package com.pickgliss.utils
{
   import org.as3commons.reflect.Accessor;
   import org.as3commons.reflect.Field;
   import org.as3commons.reflect.Type;
   import org.as3commons.reflect.Variable;
   
   public class GeneralUtils
   {
       
      
      public function GeneralUtils()
      {
         super();
      }
      
      public static function cloneObject(param1:*) : *
      {
         return doSerializeObject(param1,true);
      }
      
      public static function serializeObject(param1:*) : Object
      {
         return doSerializeObject(param1,false);
      }
      
      public static function deserializeObject(param1:Object) : *
      {
         return doDeserializeObject(param1);
      }
      
      private static function doDeserializeObject(param1:Object) : *
      {
         var _loc5_:* = undefined;
         var _loc4_:Type = Type.forName(param1["classFullName"]);
         var _loc7_:* = param1["warpObject"];
         var _loc3_:* = new _loc4_.clazz();
         if(_loc3_ is Vector.<*> || _loc3_ is Array)
         {
            var _loc10_:int = 0;
            var _loc9_:* = _loc7_;
            for each(var _loc2_ in _loc7_)
            {
               if(_loc2_ is String || _loc2_ is int || _loc2_ is uint || _loc2_ is Number || _loc2_ is Boolean)
               {
                  _loc3_.push(_loc2_);
               }
               else
               {
                  _loc3_.push(doDeserializeObject(_loc2_));
               }
            }
         }
         else
         {
            _loc5_ = null;
            if(param1["classFullName"] == "Object")
            {
               var _loc12_:int = 0;
               var _loc11_:* = _loc7_;
               for(var _loc8_ in _loc7_)
               {
                  _loc5_ = doDeserializeProperty(_loc7_[_loc8_],null);
                  _loc3_[_loc8_] = _loc5_;
               }
            }
            else
            {
               var _loc14_:int = 0;
               var _loc13_:* = _loc4_.properties;
               for each(var _loc6_ in _loc4_.properties)
               {
                  if(_loc6_ is Variable || _loc6_ is Accessor && Accessor(_loc6_).writeable && _loc6_.name != "prototype")
                  {
                     _loc5_ = doDeserializeProperty(_loc7_[_loc6_.name],_loc6_);
                     _loc3_[_loc6_.name] = _loc5_;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private static function doDeserializeProperty(param1:*, param2:Field) : *
      {
         if(param1 != null)
         {
            if(param1 is Boolean || param1 is String || param1 is int || param1 is uint || param1 is Number)
            {
               return param1;
            }
            return doDeserializeObject(param1);
         }
         return null;
      }
      
      private static function doSerializeObject(param1:*, param2:Boolean, param3:Type = null) : Object
      {
         var _loc6_:* = null;
         var _loc7_:* = undefined;
         var _loc5_:* = null;
         if(param3 == null)
         {
            param3 = Type.forInstance(param1);
         }
         if(param1 != null)
         {
            if(param1 is Vector.<*> || param1 is Array)
            {
               if(param2)
               {
                  _loc6_ = new param3.clazz();
               }
               else
               {
                  _loc6_ = [];
               }
               var _loc11_:int = 0;
               var _loc10_:* = param1;
               for each(var _loc4_ in param1)
               {
                  if(_loc4_ is String || _loc4_ is int || _loc4_ is uint || _loc4_ is Number || _loc4_ is Boolean)
                  {
                     _loc6_.push(_loc4_);
                  }
                  else
                  {
                     _loc6_.push(doSerializeObject(_loc4_,param2));
                  }
               }
            }
            else
            {
               if(param2)
               {
                  _loc6_ = new param3.clazz();
               }
               else
               {
                  _loc6_ = {};
               }
               _loc7_ = null;
               if(param3.isDynamic)
               {
                  var _loc13_:int = 0;
                  var _loc12_:* = param1;
                  for(var _loc9_ in param1)
                  {
                     if(param1[_loc9_] != null)
                     {
                        _loc7_ = doSerializeProperty(param1[_loc9_],param2,null);
                        _loc6_[_loc9_] = _loc7_;
                     }
                  }
               }
               else
               {
                  var _loc15_:int = 0;
                  var _loc14_:* = param3.properties;
                  for each(var _loc8_ in param3.properties)
                  {
                     if(_loc8_ is Variable || _loc8_ is Accessor && Accessor(_loc8_).writeable && _loc8_.name != "prototype")
                     {
                        if(param1[_loc8_.name] != null)
                        {
                           _loc7_ = doSerializeProperty(param1[_loc8_.name],param2,_loc8_);
                           _loc6_[_loc8_.name] = _loc7_;
                        }
                     }
                  }
               }
            }
            if(!param2)
            {
               _loc5_ = {};
               _loc5_["isCETransportObject"] = true;
               _loc5_["classFullName"] = param3.fullName;
               _loc5_["warpObject"] = _loc6_;
               return _loc5_;
            }
            return _loc6_;
         }
         return null;
      }
      
      private static function doSerializeProperty(param1:*, param2:Boolean, param3:Field) : *
      {
         if(param3)
         {
            if(param3 is Variable || param3 is Accessor && Accessor(param3).writeable && param3.name != "prototype")
            {
               if(param3.type.fullName == "Boolean" || param3.type.fullName == "String" || param3.type.fullName == "int" || param3.type.fullName == "uint" || param3.type.fullName == "Number")
               {
                  return param1;
               }
               return doSerializeObject(param1,param2,param3.type);
            }
            return;
         }
         if(param1 is Boolean || param1 is String || param1 is int || param1 is uint || param1 is Number)
         {
            return param1;
         }
         return doSerializeObject(param1,param2,null);
      }
   }
}
