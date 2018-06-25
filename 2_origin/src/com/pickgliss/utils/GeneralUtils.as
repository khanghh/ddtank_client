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
      
      public static function cloneObject(_obj:*) : *
      {
         return doSerializeObject(_obj,true);
      }
      
      public static function serializeObject(_obj:*) : Object
      {
         return doSerializeObject(_obj,false);
      }
      
      public static function deserializeObject(_obj:Object) : *
      {
         return doDeserializeObject(_obj);
      }
      
      private static function doDeserializeObject(_transportLayerData:Object) : *
      {
         var cloneProperty:* = undefined;
         var returnObjType:Type = Type.forName(_transportLayerData["classFullName"]);
         var warpObject:* = _transportLayerData["warpObject"];
         var returnObj:* = new returnObjType.clazz();
         if(returnObj is Vector.<*> || returnObj is Array)
         {
            var _loc10_:int = 0;
            var _loc9_:* = warpObject;
            for each(var subObject in warpObject)
            {
               if(subObject is String || subObject is int || subObject is uint || subObject is Number || subObject is Boolean)
               {
                  returnObj.push(subObject);
               }
               else
               {
                  returnObj.push(doDeserializeObject(subObject));
               }
            }
         }
         else
         {
            cloneProperty = null;
            if(_transportLayerData["classFullName"] == "Object")
            {
               var _loc12_:int = 0;
               var _loc11_:* = warpObject;
               for(var key in warpObject)
               {
                  cloneProperty = doDeserializeProperty(warpObject[key],null);
                  returnObj[key] = cloneProperty;
               }
            }
            else
            {
               var _loc14_:int = 0;
               var _loc13_:* = returnObjType.properties;
               for each(var property in returnObjType.properties)
               {
                  if(property is Variable || property is Accessor && Accessor(property).writeable && property.name != "prototype")
                  {
                     cloneProperty = doDeserializeProperty(warpObject[property.name],property);
                     returnObj[property.name] = cloneProperty;
                  }
               }
            }
         }
         return returnObj;
      }
      
      private static function doDeserializeProperty(_sourceProperty:*, _currentField:Field) : *
      {
         if(_sourceProperty != null)
         {
            if(_sourceProperty is Boolean || _sourceProperty is String || _sourceProperty is int || _sourceProperty is uint || _sourceProperty is Number)
            {
               return _sourceProperty;
            }
            return doDeserializeObject(_sourceProperty);
         }
         return null;
      }
      
      private static function doSerializeObject(_normalObj:*, _isClone:Boolean, _objType:Type = null) : Object
      {
         var returnCloneObj:* = null;
         var cloneProperty:* = undefined;
         var transportWarp:* = null;
         if(_objType == null)
         {
            _objType = Type.forInstance(_normalObj);
         }
         if(_normalObj != null)
         {
            if(_normalObj is Vector.<*> || _normalObj is Array)
            {
               if(_isClone)
               {
                  returnCloneObj = new _objType.clazz();
               }
               else
               {
                  returnCloneObj = [];
               }
               var _loc11_:int = 0;
               var _loc10_:* = _normalObj;
               for each(var subObject in _normalObj)
               {
                  if(subObject is String || subObject is int || subObject is uint || subObject is Number || subObject is Boolean)
                  {
                     returnCloneObj.push(subObject);
                  }
                  else
                  {
                     returnCloneObj.push(doSerializeObject(subObject,_isClone));
                  }
               }
            }
            else
            {
               if(_isClone)
               {
                  returnCloneObj = new _objType.clazz();
               }
               else
               {
                  returnCloneObj = {};
               }
               cloneProperty = null;
               if(_objType.isDynamic)
               {
                  var _loc13_:int = 0;
                  var _loc12_:* = _normalObj;
                  for(var key in _normalObj)
                  {
                     if(_normalObj[key] != null)
                     {
                        cloneProperty = doSerializeProperty(_normalObj[key],_isClone,null);
                        returnCloneObj[key] = cloneProperty;
                     }
                  }
               }
               else
               {
                  var _loc15_:int = 0;
                  var _loc14_:* = _objType.properties;
                  for each(var property in _objType.properties)
                  {
                     if(property is Variable || property is Accessor && Accessor(property).writeable && property.name != "prototype")
                     {
                        if(_normalObj[property.name] != null)
                        {
                           cloneProperty = doSerializeProperty(_normalObj[property.name],_isClone,property);
                           returnCloneObj[property.name] = cloneProperty;
                        }
                     }
                  }
               }
            }
            if(!_isClone)
            {
               transportWarp = {};
               transportWarp["isCETransportObject"] = true;
               transportWarp["classFullName"] = _objType.fullName;
               transportWarp["warpObject"] = returnCloneObj;
               return transportWarp;
            }
            return returnCloneObj;
         }
         return null;
      }
      
      private static function doSerializeProperty(_sourceProperty:*, _isClone:Boolean, _currentField:Field) : *
      {
         if(_currentField)
         {
            if(_currentField is Variable || _currentField is Accessor && Accessor(_currentField).writeable && _currentField.name != "prototype")
            {
               if(_currentField.type.fullName == "Boolean" || _currentField.type.fullName == "String" || _currentField.type.fullName == "int" || _currentField.type.fullName == "uint" || _currentField.type.fullName == "Number")
               {
                  return _sourceProperty;
               }
               return doSerializeObject(_sourceProperty,_isClone,_currentField.type);
            }
            return;
         }
         if(_sourceProperty is Boolean || _sourceProperty is String || _sourceProperty is int || _sourceProperty is uint || _sourceProperty is Number)
         {
            return _sourceProperty;
         }
         return doSerializeObject(_sourceProperty,_isClone,null);
      }
   }
}
