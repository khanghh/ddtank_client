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
      
      public static function concatTypeMetadata(type:Type, metadataContainers:Array, propertyName:String) : void
      {
         var container:IMetadataContainer = null;
         for each(container in metadataContainers)
         {
            type[propertyName].some(function(item:Object, index:int, arr:Array):Boolean
            {
               var metadataList:Array = null;
               var numMetadata:int = 0;
               var j:int = 0;
               if(item.name == Object(container).name)
               {
                  metadataList = container.metadata;
                  numMetadata = metadataList.length;
                  for(j = 0; j < numMetadata; j++)
                  {
                     item.addMetadata(metadataList[j]);
                  }
                  return true;
               }
               return false;
            });
         }
      }
      
      public static function getTypeDescription(clazz:Class) : XML
      {
         var parametersXML:XMLList = null;
         var args:Array = null;
         var n:int = 0;
         var description:XML = describeType(clazz);
         var constructorXML:XMLList = description.factory.constructor;
         if(constructorXML && constructorXML.length() > 0)
         {
            parametersXML = constructorXML[0].parameter;
            if(parametersXML && parametersXML.length() > 0)
            {
               args = [];
               for(n = 0; n < parametersXML.length(); n++)
               {
                  args.push(null);
               }
               if(playerHasConstructorBug())
               {
                  try
                  {
                     ClassUtils.newInstance(clazz,args);
                  }
                  catch(e:Error)
                  {
                  }
               }
               description = describeType(clazz);
            }
         }
         return description;
      }
      
      public static function playerHasConstructorBug() : Boolean
      {
         var arr:Array = null;
         var major:int = 0;
         var minor:int = 0;
         if(_version == null)
         {
            _version = Capabilities.version.split(" ")[1];
            arr = _version.split(",");
            major = parseInt(arr[0]);
            minor = arr.length > 1 && String(arr[1]).length > 0?int(parseInt(arr[1])):0;
            if(major < 10)
            {
               _isOldPlayer = true;
            }
            else
            {
               _isOldPlayer = major == 10?minor < 1:false;
            }
         }
         return _isOldPlayer;
      }
   }
}
