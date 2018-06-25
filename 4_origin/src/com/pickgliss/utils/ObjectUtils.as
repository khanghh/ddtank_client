package com.pickgliss.utils
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   public final class ObjectUtils
   {
      
      private static var _copyAbleTypes:Vector.<String>;
      
      private static var _descriptOjbXMLs:Dictionary;
       
      
      public function ObjectUtils()
      {
         super();
      }
      
      public static function cloneSimpleObject(obj:Object) : Object
      {
         var temp:ByteArray = new ByteArray();
         temp.writeObject(obj);
         temp.position = 0;
         return temp.readObject();
      }
      
      public static function copyPorpertiesByXML(object:Object, data:XML) : void
      {
         var propname:* = null;
         var value:* = null;
         var attr:XMLList = data.attributes();
         var _loc10_:int = 0;
         var _loc9_:* = attr;
         for each(var item in attr)
         {
            propname = item.name().toString();
            if(object.hasOwnProperty(propname))
            {
               try
               {
                  value = item.toString();
                  if(value == "false")
                  {
                     object[propname] = false;
                  }
                  else
                  {
                     object[propname] = value;
                  }
               }
               catch(e:Error)
               {
                  trace("-----类ObjectUtils报错:",e.message + "\n-----",propname,value);
                  continue;
               }
            }
         }
      }
      
      public static function copyProperties(dest:Object, orig:Object) : void
      {
         var properties:* = null;
         var propertyType:* = null;
         var propertyName:* = null;
         var accessorType:* = null;
         var accessorName:* = null;
         if(_descriptOjbXMLs == null)
         {
            _descriptOjbXMLs = new Dictionary();
         }
         var copyAbleTypes:Vector.<String> = getCopyAbleType();
         var descriXML:XML = describeTypeSave(orig);
         properties = descriXML.variable;
         var _loc13_:int = 0;
         var _loc12_:* = properties;
         for each(var propertyInfo in properties)
         {
            propertyType = propertyInfo.@type;
            if(copyAbleTypes.indexOf(propertyType) != -1)
            {
               propertyName = propertyInfo.@name;
               if(dest.hasOwnProperty(propertyName))
               {
                  dest[propertyName] = orig[propertyName];
               }
            }
         }
         properties = descriXML.accessor;
         var _loc15_:int = 0;
         var _loc14_:* = properties;
         for each(var accessorInfo in properties)
         {
            accessorType = accessorInfo.@type;
            if(copyAbleTypes.indexOf(accessorType) != -1)
            {
               accessorName = accessorInfo.@name;
               try
               {
                  dest[accessorName] = orig[accessorName];
               }
               catch(err:Error)
               {
                  continue;
               }
            }
         }
      }
      
      public static function disposeAllChildren(container:DisplayObjectContainer) : void
      {
         var child:* = null;
         if(container == null)
         {
            return;
         }
         while(container.numChildren > 0)
         {
            child = container.getChildAt(0);
            ObjectUtils.disposeObject(child);
         }
      }
      
      public static function removeChildAllChildren(container:DisplayObjectContainer) : void
      {
         while(container.numChildren > 0)
         {
            container.removeChildAt(0);
         }
      }
      
      public static function disposeObject(target:Object) : void
      {
         var targetDisplay:* = null;
         var targetBitmap:* = null;
         var targetBitmapData:* = null;
         var targetDisplay1:* = null;
         if(target == null)
         {
            return;
         }
         if(target is Disposeable)
         {
            if(target is DisplayObject)
            {
               targetDisplay = target as DisplayObject;
               if(targetDisplay.parent)
               {
                  targetDisplay.parent.removeChild(targetDisplay);
               }
            }
            Disposeable(target).dispose();
         }
         else if(target is Bitmap)
         {
            targetBitmap = Bitmap(target);
            if(targetBitmap.parent)
            {
               targetBitmap.parent.removeChild(targetBitmap);
            }
            if(targetBitmap.bitmapData)
            {
               targetBitmap.bitmapData.dispose();
            }
         }
         else if(target is BitmapData)
         {
            targetBitmapData = BitmapData(target);
            targetBitmapData.dispose();
         }
         else if(target is DisplayObject)
         {
            targetDisplay1 = DisplayObject(target);
            if(targetDisplay1.parent)
            {
               targetDisplay1.parent.removeChild(targetDisplay1);
            }
         }
      }
      
      private static function getCopyAbleType() : Vector.<String>
      {
         if(_copyAbleTypes == null)
         {
            _copyAbleTypes = new Vector.<String>();
            _copyAbleTypes.push("int");
            _copyAbleTypes.push("uint");
            _copyAbleTypes.push("String");
            _copyAbleTypes.push("Boolean");
            _copyAbleTypes.push("Number");
         }
         return _copyAbleTypes;
      }
      
      public static function describeTypeSave(obj:Object) : XML
      {
         var result:* = null;
         var classname:String = getQualifiedClassName(obj);
         if(_descriptOjbXMLs[classname] != null)
         {
            result = _descriptOjbXMLs[classname];
         }
         else
         {
            result = describeType(obj);
            _descriptOjbXMLs[classname] = result;
         }
         return result;
      }
      
      public static function encode(node:String, object:Object) : XML
      {
         var value:* = null;
         var temp:String = "<" + node + " ";
         var classInfo:XML = describeTypeSave(object);
         if(classInfo.@name.toString() == "Object")
         {
            var _loc9_:int = 0;
            var _loc8_:* = object;
            for(var key in object)
            {
               value = object[key];
               if(!(value is Function))
               {
                  temp = temp + encodingProperty(key,value);
               }
            }
         }
         else
         {
            var _loc13_:int = 0;
            var _loc10_:* = classInfo..*;
            var _loc11_:int = 0;
            _loc8_ = new XMLList("");
            var _loc12_:* = classInfo..*.(name() == "variable" || name() == "accessor");
            for each(var v in classInfo..*.(name() == "variable" || name() == "accessor"))
            {
               temp = temp + encodingProperty(v.@name.toString(),object[v.@name]);
            }
         }
         temp = temp + "/>";
         return new XML(temp);
      }
      
      private static function encodingProperty(name:String, value:Object) : String
      {
         if(value is Array)
         {
            return "";
         }
         return escapeString(name) + "=\"" + String(value) + "\" ";
      }
      
      private static function escapeString(str:String) : String
      {
         var ch:* = null;
         var i:int = 0;
         var hexCode:* = null;
         var zeroPad:* = null;
         var s:String = "";
         var len:Number = str.length;
         for(i = 0; i < len; )
         {
            ch = str.charAt(i);
            var _loc8_:* = ch;
            if("\"" !== _loc8_)
            {
               if("/" !== _loc8_)
               {
                  if("\\" !== _loc8_)
                  {
                     if("\b" !== _loc8_)
                     {
                        if("\f" !== _loc8_)
                        {
                           if("\n" !== _loc8_)
                           {
                              if("\r" !== _loc8_)
                              {
                                 if("\t" !== _loc8_)
                                 {
                                    if(ch < " ")
                                    {
                                       hexCode = ch.charCodeAt(0).toString(16);
                                       zeroPad = hexCode.length == 2?"00":"000";
                                       s = s + ("\\u" + zeroPad + hexCode);
                                    }
                                    else
                                    {
                                       s = s + ch;
                                    }
                                 }
                                 else
                                 {
                                    s = s + "\\t";
                                 }
                              }
                              else
                              {
                                 s = s + "\\r";
                              }
                           }
                           else
                           {
                              s = s + "\\n";
                           }
                        }
                        else
                        {
                           s = s + "\\f";
                        }
                     }
                     else
                     {
                        s = s + "\\b";
                     }
                  }
                  else
                  {
                     s = s + "\\\\";
                  }
               }
               else
               {
                  s = s + "\\/";
               }
            }
            else
            {
               s = s + "\\\"";
            }
            i++;
         }
         return s;
      }
      
      public static function modifyVisibility(value:Boolean, ... args) : void
      {
         var i:int = 0;
         for(i = 0; i < args.length; )
         {
            (args[i] as DisplayObject).visible = value;
            i++;
         }
      }
      
      public static function copyPropertyByRectangle(source:DisplayObject, rt:Rectangle) : void
      {
         source.x = rt.x;
         source.y = rt.y;
         if(rt.width != 0)
         {
            source.width = rt.width;
         }
         if(rt.height != 0)
         {
            source.height = rt.height;
         }
      }
      
      public static function combineXML(result:XML, data:XML) : void
      {
         var propname:* = null;
         var value:* = null;
         if(data == null || result == null)
         {
            trace("警告！！！！  combineXML 出现问题  请马上解决");
            return;
         }
         var attr:XMLList = data.attributes();
         var _loc8_:int = 0;
         var _loc7_:* = attr;
         for each(var item in attr)
         {
            propname = item.name().toString();
            value = item.toString();
            if(!result.hasOwnProperty("@" + propname))
            {
               result["@" + propname] = value;
            }
         }
      }
      
      public static function getDisplayObjectSuperParent(dis:*, containterClazz:Class, stage:*) : *
      {
         while(dis != null && dis != stage)
         {
            if(dis is containterClazz)
            {
               return dis;
            }
            dis = dis.parent;
         }
         return null;
      }
      
      public static function getDisplayObjectSuperParentByName(dis:*, qualifiedClassName:String, stage:*) : *
      {
         while(dis != null && dis != stage)
         {
            if(getQualifiedClassName(dis) == qualifiedClassName)
            {
               return dis;
            }
            dis = dis.parent;
         }
         return null;
      }
   }
}
