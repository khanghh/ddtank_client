package com.demonsters.debugger
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   class MonsterDebuggerUtils
   {
      
      private static var _references:Dictionary = new Dictionary(true);
      
      private static var _reference:int = 0;
       
      
      function MonsterDebuggerUtils()
      {
         super();
      }
      
      public static function snapshot(object:flash.display.DisplayObject, rectangle:Rectangle = null) : BitmapData
      {
         var m:* = null;
         var scaled:* = null;
         var s:Number = NaN;
         var b:* = null;
         if(object == null)
         {
            return null;
         }
         var visible:Boolean = object.visible;
         var alpha:Number = object.alpha;
         var rotation:Number = object.rotation;
         var scaleX:Number = object.scaleX;
         var scaleY:Number = object.scaleY;
         try
         {
            object.visible = true;
            object.alpha = 1;
            object.rotation = 0;
            object.scaleX = 1;
            object.scaleY = 1;
         }
         catch(e1:Error)
         {
         }
         var bounds:Rectangle = object.getBounds(object);
         bounds.x = int(bounds.x + 0.5);
         bounds.y = int(bounds.y + 0.5);
         bounds.width = int(bounds.width + 0.5);
         bounds.height = int(bounds.height + 0.5);
         if(object is Stage)
         {
            bounds.x = 0;
            bounds.y = 0;
            bounds.width = Stage(object).stageWidth;
            bounds.height = Stage(object).stageHeight;
         }
         var bitmapData:* = null;
         if(bounds.width <= 0 || bounds.height <= 0)
         {
            return null;
         }
         try
         {
            bitmapData = new BitmapData(bounds.width,bounds.height,false,16777215);
            m = new Matrix();
            m.tx = -bounds.x;
            m.ty = -bounds.y;
            bitmapData.draw(object,m,null,null,null,false);
         }
         catch(e2:Error)
         {
            bitmapData = null;
         }
         try
         {
            object.visible = visible;
            object.alpha = alpha;
            object.rotation = rotation;
            object.scaleX = scaleX;
            object.scaleY = scaleY;
         }
         catch(e3:Error)
         {
         }
         if(bitmapData == null)
         {
            return null;
         }
         if(rectangle != null)
         {
            if(bounds.width <= rectangle.width && bounds.height <= rectangle.height)
            {
               return bitmapData;
            }
            scaled = bounds.clone();
            scaled.width = rectangle.width;
            scaled.height = rectangle.width * (bounds.height / bounds.width);
            if(scaled.height > rectangle.height)
            {
               scaled = bounds.clone();
               scaled.width = rectangle.height * (bounds.width / bounds.height);
               scaled.height = rectangle.height;
            }
            s = scaled.width / bounds.width;
            try
            {
               b = new BitmapData(scaled.width,scaled.height,false,0);
               m = new Matrix();
               m.scale(s,s);
               b.draw(bitmapData,m,null,null,null,true);
               bitmapData.dispose();
               bitmapData = b;
            }
            catch(e4:Error)
            {
               bitmapData.dispose();
               bitmapData = null;
            }
         }
         return bitmapData;
      }
      
      public static function getMemory() : uint
      {
         return System.totalMemory;
      }
      
      public static function pause() : Boolean
      {
         try
         {
            System.pause();
            var _loc2_:Boolean = true;
            return _loc2_;
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public static function resume() : Boolean
      {
         try
         {
            System.resume();
            var _loc2_:Boolean = true;
            return _loc2_;
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public static function stackTrace() : XML
      {
         var stack:* = null;
         var lines:* = null;
         var i:int = 0;
         var s:* = null;
         var bracketIndex:int = 0;
         var methodIndex:* = 0;
         var classname:* = null;
         var method:* = null;
         var file:* = null;
         var line:* = null;
         var functionXML:* = null;
         var rootXML:XML = <root/>;
         var childXML:XML = <node/>;
         try
         {
            throw new Error();
         }
         catch(e:Error)
         {
            stack = e.getStackTrace();
            if(stack == null || stack == "")
            {
               var _loc15_:* = <root><error>Stack unavailable</error></root>;
               return _loc15_;
            }
            stack = stack.split("\t").join("");
            lines = stack.split("\n");
            if(lines.length <= 4)
            {
               var _loc17_:* = <root><error>Stack to short</error></root>;
               return _loc17_;
            }
            lines.shift();
            lines.shift();
            lines.shift();
            lines.shift();
            i = 0;
            while(i < lines.length)
            {
               s = lines[i];
               s = s.substring(3,s.length);
               bracketIndex = s.indexOf("[");
               methodIndex = int(s.indexOf("/"));
               if(bracketIndex == -1)
               {
                  bracketIndex = s.length;
               }
               if(methodIndex == -1)
               {
                  methodIndex = bracketIndex;
               }
               classname = MonsterDebuggerUtils.parseType(s.substring(0,methodIndex));
               method = "";
               file = "";
               line = "";
               if(methodIndex != s.length && methodIndex != bracketIndex)
               {
                  method = s.substring(methodIndex + 1,bracketIndex);
               }
               if(bracketIndex != s.length)
               {
                  file = s.substring(bracketIndex + 1,s.lastIndexOf(":"));
                  line = s.substring(s.lastIndexOf(":") + 1,s.length - 1);
               }
               functionXML = <node/>;
               functionXML.@classname = classname;
               functionXML.@method = method;
               functionXML.@file = file;
               functionXML.@line = line;
               childXML.appendChild(functionXML);
               i++;
            }
         }
         rootXML.appendChild(childXML.children());
         return rootXML;
      }
      
      public static function getReferenceID(target:*) : String
      {
         if(target in _references)
         {
            return _references[target];
         }
         var reference:String = "#" + String(_reference);
         _references[target] = reference;
         _reference = Number(_reference) + 1;
         return reference;
      }
      
      public static function getReference(id:String) : *
      {
         var value:* = null;
         if(id.charAt(0) != "#")
         {
            return null;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _references;
         for(var key in _references)
         {
            value = _references[key];
            if(value == id)
            {
               return key;
            }
         }
         return null;
      }
      
      public static function getObject(base:*, target:String = "", parent:int = 0) : *
      {
         var i:int = 0;
         var index:Number = NaN;
         if(target == null || target == "")
         {
            return base;
         }
         if(target.charAt(0) == "#")
         {
            return getReference(target);
         }
         var object:* = base;
         var splitted:Array = target.split(".");
         for(i = 0; i < splitted.length - parent; )
         {
            if(splitted[i] != "")
            {
               try
               {
                  if(splitted[i] == "children()")
                  {
                     object = object.children();
                  }
                  else if(object is flash.display.DisplayObjectContainer && splitted[i].indexOf("getChildAt(") == 0)
                  {
                     index = splitted[i].substring(11,splitted[i].indexOf(")",11));
                     object = flash.display.DisplayObjectContainer(object).getChildAt(index);
                  }
                  else if(object is starling.display.DisplayObjectContainer && splitted[i].indexOf("getChildAt(") == 0)
                  {
                     index = splitted[i].substring(11,splitted[i].indexOf(")",11));
                     object = starling.display.DisplayObjectContainer(object).getChildAt(index);
                  }
                  else
                  {
                     object = object[splitted[i]];
                  }
               }
               catch(e:Error)
               {
                  break;
               }
            }
            i++;
         }
         return object;
      }
      
      public static function parse(object:*, target:String = "", currentDepth:int = 1, maxDepth:int = 5, includeDisplayObjects:Boolean = true) : XML
      {
         var topXML:* = null;
         var rootXML:XML = <root/>;
         var childXML:XML = <node/>;
         var description:XML = new XML();
         var type:String = "";
         var base:String = "";
         var isDynamic:Boolean = false;
         var label:String = null;
         var icon:String = "iconRoot";
         if(maxDepth != -1 && currentDepth > maxDepth)
         {
            return rootXML;
         }
         if(object == null)
         {
            type = "null";
            label = "null";
            icon = "iconWarning";
         }
         else
         {
            description = MonsterDebuggerDescribeType.get(object);
            type = parseType(description.@name);
            base = parseType(description.@base);
            isDynamic = description.@isDynamic;
            if(object is Class)
            {
               label = "Class = " + type;
               type = "Class";
               childXML.appendChild(parseClass(object,target,description,currentDepth,maxDepth,includeDisplayObjects).children());
            }
            else if(type == "XML")
            {
               childXML.appendChild(parseXML(object,target + ".children()",currentDepth,maxDepth).children());
            }
            else if(type == "XMLList")
            {
               label = type + " [" + String(object.length()) + "]";
               childXML.appendChild(parseXMLList(object,target,currentDepth,maxDepth).children());
            }
            else if(type == "Array" || type.indexOf("Vector.") == 0)
            {
               label = type + " [" + String(object["length"]) + "]";
               childXML.appendChild(parseArray(object,target,currentDepth,maxDepth).children());
            }
            else if(type == "String" || type == "Boolean" || type == "Number" || type == "int" || type == "uint")
            {
               childXML.appendChild(parseBasics(object,target,type).children());
            }
            else if(type == "Object")
            {
               childXML.appendChild(parseObject(object,target,currentDepth,maxDepth,includeDisplayObjects).children());
            }
            else
            {
               childXML.appendChild(parseClass(object,target,description,currentDepth,maxDepth,includeDisplayObjects).children());
            }
         }
         if(currentDepth == 1)
         {
            topXML = <node/>;
            topXML.@icon = icon;
            topXML.@label = type;
            topXML.@type = type;
            topXML.@target = target;
            if(label != null)
            {
               topXML.@label = label;
            }
            topXML.appendChild(childXML.children());
            rootXML.appendChild(topXML);
         }
         else
         {
            rootXML.appendChild(childXML.children());
         }
         return rootXML;
      }
      
      private static function parseBasics(object:*, target:String, type:String) : XML
      {
         var rootXML:XML = <root/>;
         var nodeXML:XML = <node/>;
         nodeXML.@icon = "iconVariable";
         nodeXML.@access = "variable";
         nodeXML.@permission = "readwrite";
         nodeXML.@label = type + " = " + printValue(object,type,true);
         nodeXML.@name = "";
         nodeXML.@type = type;
         nodeXML.@value = printValue(object,type);
         nodeXML.@target = target;
         rootXML.appendChild(nodeXML);
         return rootXML;
      }
      
      private static function parseArray(object:*, target:String, currentDepth:int = 1, maxDepth:int = 5, includeDisplayObjects:Boolean = true) : XML
      {
         var childXML:* = null;
         var rootXML:XML = <root/>;
         var childType:String = "";
         var childTarget:String = "";
         var i:int = 0;
         var keys:Array = [];
         var isNumeric:Boolean = true;
         var _loc15_:int = 0;
         var _loc14_:* = object;
         for(var key in object)
         {
            if(!(key is int))
            {
               isNumeric = false;
            }
            keys.push(key);
         }
         if(isNumeric)
         {
            keys.sort(16);
         }
         else
         {
            keys.sort(1);
         }
         for(i = 0; i < keys.length; )
         {
            childType = parseType(MonsterDebuggerDescribeType.get(object[keys[i]]).@name);
            childTarget = target + "." + String(keys[i]);
            if(childType == "String" || childType == "Boolean" || childType == "Number" || childType == "int" || childType == "uint" || childType == "Function")
            {
               childXML = <node/>;
               childXML.@icon = "iconVariable";
               childXML.@access = "variable";
               childXML.@permission = "readwrite";
               childXML.@label = "[" + keys[i] + "] (" + childType + ") = " + printValue(object[keys[i]],childType,true);
               childXML.@name = "[" + keys[i] + "]";
               childXML.@type = childType;
               childXML.@value = printValue(object[keys[i]],childType);
               childXML.@target = childTarget;
               rootXML.appendChild(childXML);
            }
            else
            {
               childXML = <node/>;
               childXML.@icon = "iconVariable";
               childXML.@access = "variable";
               childXML.@permission = "readwrite";
               childXML.@label = "[" + keys[i] + "] (" + childType + ")";
               childXML.@name = "[" + keys[i] + "]";
               childXML.@type = childType;
               childXML.@value = "";
               childXML.@target = childTarget;
               if(object[keys[i]] == null)
               {
                  childXML.@icon = "iconWarning";
                  childXML.@label = childXML.@label + " = null";
               }
               childXML.appendChild(parse(object[keys[i]],childTarget,currentDepth + 1,maxDepth,includeDisplayObjects).children());
               rootXML.appendChild(childXML);
            }
            i++;
         }
         return rootXML;
      }
      
      public static function parseXML(xml:*, target:String = "", currentDepth:int = 1, maxDepth:int = -1) : XML
      {
         var nodeXML:* = null;
         var childXML:* = null;
         var childTarget:* = null;
         var rootXML:XML = <root/>;
         var i:int = 0;
         if(maxDepth != -1 && currentDepth > maxDepth)
         {
            return rootXML;
         }
         if(target.indexOf("@") != -1)
         {
            nodeXML = <node/>;
            nodeXML.@icon = "iconXMLAttribute";
            nodeXML.@type = "XMLAttribute";
            nodeXML.@access = "variable";
            nodeXML.@permission = "readwrite";
            nodeXML.@label = xml;
            nodeXML.@name = "";
            nodeXML.@value = xml;
            nodeXML.@target = target;
            rootXML.appendChild(nodeXML);
         }
         else if("name" in xml && xml.name() == null)
         {
            nodeXML = <node/>;
            nodeXML.@icon = "iconXMLValue";
            nodeXML.@type = "XMLValue";
            nodeXML.@access = "variable";
            nodeXML.@permission = "readwrite";
            nodeXML.@label = "(XMLValue) = " + printValue(xml,"XMLValue",true);
            nodeXML.@name = "";
            nodeXML.@value = printValue(xml,"XMLValue");
            nodeXML.@target = target;
            rootXML.appendChild(nodeXML);
         }
         else if("hasSimpleContent" in xml && xml.hasSimpleContent())
         {
            nodeXML = <node/>;
            nodeXML.@icon = "iconXMLNode";
            nodeXML.@type = "XMLNode";
            nodeXML.@access = "variable";
            nodeXML.@permission = "readwrite";
            nodeXML.@label = xml.name() + " (" + "XMLNode" + ")";
            nodeXML.@name = xml.name();
            nodeXML.@value = "";
            nodeXML.@target = target;
            if(xml != "")
            {
               childXML = <node/>;
               childXML.@icon = "iconXMLValue";
               childXML.@type = "XMLValue";
               childXML.@access = "variable";
               childXML.@permission = "readwrite";
               childXML.@label = "(XMLValue) = " + printValue(xml,"XMLValue");
               childXML.@name = "";
               childXML.@value = printValue(xml,"XMLValue");
               childXML.@target = target;
               nodeXML.appendChild(childXML);
            }
            i = 0;
            while(i < xml.attributes().length())
            {
               childXML = <node/>;
               childXML.@icon = "iconXMLAttribute";
               childXML.@type = "XMLAttribute";
               childXML.@access = "variable";
               childXML.@permission = "readwrite";
               childXML.@label = "@" + xml.attributes()[i].name() + " (" + "XMLAttribute" + ") = " + xml.attributes()[i];
               childXML.@name = "";
               childXML.@value = xml.attributes()[i];
               childXML.@target = target + "." + "@" + xml.attributes()[i].name();
               nodeXML.appendChild(childXML);
               i++;
            }
            rootXML.appendChild(nodeXML);
         }
         else
         {
            nodeXML = <node/>;
            nodeXML.@icon = "iconXMLNode";
            nodeXML.@type = "XMLNode";
            nodeXML.@access = "variable";
            nodeXML.@permission = "readwrite";
            nodeXML.@label = xml.name() + " (" + "XMLNode" + ")";
            nodeXML.@name = xml.name();
            nodeXML.@value = "";
            nodeXML.@target = target;
            for(i = 0; i < xml.attributes().length(); )
            {
               childXML = <node/>;
               childXML.@icon = "iconXMLAttribute";
               childXML.@type = "XMLAttribute";
               childXML.@access = "variable";
               childXML.@permission = "readwrite";
               childXML.@label = "@" + xml.attributes()[i].name() + " (" + "XMLAttribute" + ") = " + xml.attributes()[i];
               childXML.@name = "";
               childXML.@value = xml.attributes()[i];
               childXML.@target = target + "." + "@" + xml.attributes()[i].name();
               nodeXML.appendChild(childXML);
               i++;
            }
            for(i = 0; i < xml.children().length(); )
            {
               childTarget = target + "." + "children()" + "." + i;
               nodeXML.appendChild(parseXML(xml.children()[i],childTarget,currentDepth + 1,maxDepth).children());
               i++;
            }
            rootXML.appendChild(nodeXML);
         }
         return rootXML;
      }
      
      public static function parseXMLList(xml:*, target:String = "", currentDepth:int = 1, maxDepth:int = -1) : XML
      {
         var i:int = 0;
         var rootXML:XML = <root/>;
         if(maxDepth != -1 && currentDepth > maxDepth)
         {
            return rootXML;
         }
         for(i = 0; i < xml.length(); )
         {
            rootXML.appendChild(parseXML(xml[i],target + "." + String(i) + ".children()",currentDepth,maxDepth).children());
            i++;
         }
         return rootXML;
      }
      
      private static function parseObject(object:*, target:String, currentDepth:int = 1, maxDepth:int = 5, includeDisplayObjects:Boolean = true) : XML
      {
         var childXML:* = null;
         var rootXML:XML = <root/>;
         var nodeXML:XML = <node/>;
         var childType:String = "";
         var childTarget:String = "";
         var i:int = 0;
         var properties:Array = [];
         var isNumeric:Boolean = true;
         var _loc16_:int = 0;
         var _loc15_:* = object;
         for(var prop in object)
         {
            if(!(prop is int))
            {
               isNumeric = false;
            }
            properties.push(prop);
         }
         if(isNumeric)
         {
            properties.sort(16);
         }
         else
         {
            properties.sort(1);
         }
         for(i = 0; i < properties.length; )
         {
            childType = parseType(MonsterDebuggerDescribeType.get(object[properties[i]]).@name);
            childTarget = target + "." + properties[i];
            if(childType == "String" || childType == "Boolean" || childType == "Number" || childType == "int" || childType == "uint" || childType == "Function")
            {
               childXML = <node/>;
               childXML.@icon = "iconVariable";
               childXML.@access = "variable";
               childXML.@permission = "readwrite";
               childXML.@label = properties[i] + " (" + childType + ") = " + printValue(object[properties[i]],childType,true);
               childXML.@name = properties[i];
               childXML.@type = childType;
               childXML.@value = printValue(object[properties[i]],childType);
               childXML.@target = childTarget;
               nodeXML.appendChild(childXML);
            }
            else
            {
               childXML = <node/>;
               childXML.@icon = "iconVariable";
               childXML.@access = "variable";
               childXML.@permission = "readwrite";
               childXML.@label = properties[i] + " (" + childType + ")";
               childXML.@name = properties[i];
               childXML.@type = childType;
               childXML.@value = "";
               childXML.@target = childTarget;
               if(object[properties[i]] == null)
               {
                  childXML.@icon = "iconWarning";
                  childXML.@label = childXML.@label + " = null";
               }
               childXML.appendChild(parse(object[properties[i]],childTarget,currentDepth + 1,maxDepth,includeDisplayObjects).children());
               nodeXML.appendChild(childXML);
            }
            i++;
         }
         rootXML.appendChild(nodeXML.children());
         return rootXML;
      }
      
      private static function parseClass(object:*, target:String, description:XML, currentDepth:int = 1, maxDepth:int = 5, includeDisplayObjects:Boolean = true) : XML
      {
         var key:* = null;
         var itemsArrayLength:int = 0;
         var item:* = undefined;
         var itemXML:* = null;
         var itemAccess:* = null;
         var itemPermission:* = null;
         var itemIcon:* = null;
         var itemType:* = null;
         var itemName:* = null;
         var itemTarget:* = null;
         var i:int = 0;
         var displayObject:* = null;
         var displayObjects:* = null;
         var child:* = null;
         var starlingDisplayObject:* = null;
         var starlingChild:* = null;
         var rootXML:XML = <root/>;
         var nodeXML:XML = <node/>;
         var variables:XMLList = description..variable;
         var accessors:XMLList = description..accessor;
         var constants:XMLList = description..constant;
         var isDynamic:Boolean = description.@isDynamic;
         var variablesLength:int = variables.length();
         var accessorsLength:int = accessors.length();
         var constantsLength:int = constants.length();
         var childLength:int = 0;
         var keys:Object = {};
         var itemsArray:Array = [];
         if(isDynamic)
         {
            var _loc37_:int = 0;
            var _loc36_:* = object;
            for(key in object)
            {
               if(!keys.hasOwnProperty(key))
               {
                  keys[key] = key;
                  itemName = key;
                  itemType = parseType(getQualifiedClassName(object[key]));
                  itemTarget = target + "." + key;
                  itemAccess = "variable";
                  itemPermission = "readwrite";
                  itemIcon = "iconVariable";
                  itemsArray[itemsArray.length] = {
                     "name":itemName,
                     "type":itemType,
                     "target":itemTarget,
                     "access":itemAccess,
                     "permission":itemPermission,
                     "icon":itemIcon
                  };
               }
            }
         }
         for(i = 0; i < variablesLength; )
         {
            key = variables[i].@name;
            if(!keys.hasOwnProperty(key))
            {
               keys[key] = key;
               itemName = key;
               itemType = parseType(variables[i].@type);
               itemTarget = target + "." + key;
               itemAccess = "variable";
               itemPermission = "readwrite";
               itemIcon = "iconVariable";
               itemsArray[itemsArray.length] = {
                  "name":itemName,
                  "type":itemType,
                  "target":itemTarget,
                  "access":itemAccess,
                  "permission":itemPermission,
                  "icon":itemIcon
               };
            }
            i++;
         }
         for(i = 0; i < accessorsLength; )
         {
            key = accessors[i].@name;
            if(!keys.hasOwnProperty(key))
            {
               keys[key] = key;
               itemName = key;
               itemType = parseType(accessors[i].@type);
               itemTarget = target + "." + key;
               itemAccess = "accessor";
               itemPermission = "readwrite";
               itemIcon = "iconVariable";
               if(accessors[i].@access == "readonly")
               {
                  itemPermission = "readonly";
                  itemIcon = "iconVariableReadonly";
               }
               if(accessors[i].@access == "writeonly")
               {
                  itemPermission = "writeonly";
                  itemIcon = "iconVariableWriteonly";
               }
               itemsArray[itemsArray.length] = {
                  "name":itemName,
                  "type":itemType,
                  "target":itemTarget,
                  "access":itemAccess,
                  "permission":itemPermission,
                  "icon":itemIcon
               };
            }
            i++;
         }
         for(i = 0; i < constantsLength; )
         {
            key = constants[i].@name;
            if(!keys.hasOwnProperty(key))
            {
               keys[key] = key;
               itemName = key;
               itemType = parseType(constants[i].@type);
               itemTarget = target + "." + key;
               itemAccess = "constant";
               itemPermission = "readonly";
               itemIcon = "iconVariableReadonly";
               itemsArray[itemsArray.length] = {
                  "name":itemName,
                  "type":itemType,
                  "target":itemTarget,
                  "access":itemAccess,
                  "permission":itemPermission,
                  "icon":itemIcon
               };
            }
            i++;
         }
         itemsArray.sortOn("name",1);
         if(includeDisplayObjects && object is flash.display.DisplayObjectContainer)
         {
            displayObject = flash.display.DisplayObjectContainer(object);
            displayObjects = [];
            childLength = displayObject.numChildren;
            for(i = 0; i < childLength; )
            {
               child = null;
               try
               {
                  child = displayObject.getChildAt(i);
               }
               catch(e1:Error)
               {
               }
               if(child != null)
               {
                  itemXML = MonsterDebuggerDescribeType.get(child);
                  itemType = parseType(itemXML.@name);
                  itemName = "DisplayObject";
                  if(child.name != null)
                  {
                     itemName = itemName + (" - " + child.name);
                  }
                  itemTarget = target + "." + "getChildAt(" + i + ")";
                  itemAccess = "displayObject";
                  itemPermission = "readwrite";
                  itemIcon = child is flash.display.DisplayObjectContainer?"iconRoot":"iconDisplayObject";
                  displayObjects[displayObjects.length] = {
                     "name":itemName,
                     "type":itemType,
                     "target":itemTarget,
                     "access":itemAccess,
                     "permission":itemPermission,
                     "icon":itemIcon,
                     "index":i
                  };
               }
               i++;
            }
            displayObjects.sortOn("name",1);
            itemsArray = displayObjects.concat(itemsArray);
         }
         else if(includeDisplayObjects && object is starling.display.DisplayObjectContainer)
         {
            starlingDisplayObject = starling.display.DisplayObjectContainer(object);
            displayObjects = [];
            childLength = starlingDisplayObject.numChildren;
            for(i = 0; i < childLength; )
            {
               starlingChild = null;
               try
               {
                  starlingChild = starlingDisplayObject.getChildAt(i);
               }
               catch(e1:Error)
               {
               }
               if(starlingChild != null)
               {
                  itemXML = MonsterDebuggerDescribeType.get(starlingChild);
                  itemType = parseType(itemXML.@name);
                  itemName = "Starling DisplayObject";
                  if(starlingChild.name != null)
                  {
                     itemName = itemName + (" - " + starlingChild.name);
                  }
                  itemTarget = target + "." + "getChildAt(" + i + ")";
                  itemAccess = "displayObject";
                  itemPermission = "readwrite";
                  itemIcon = starlingChild is starling.display.DisplayObjectContainer?"iconRoot":"iconDisplayObject";
                  displayObjects[displayObjects.length] = {
                     "name":itemName,
                     "type":itemType,
                     "target":itemTarget,
                     "access":itemAccess,
                     "permission":itemPermission,
                     "icon":itemIcon,
                     "index":i
                  };
               }
               i++;
            }
            displayObjects.sortOn("name",1);
            itemsArray = displayObjects.concat(itemsArray);
         }
         itemsArrayLength = itemsArray.length;
         for(i = 0; i < itemsArrayLength; )
         {
            itemType = itemsArray[i].type;
            itemName = itemsArray[i].name;
            itemTarget = itemsArray[i].target;
            itemPermission = itemsArray[i].permission;
            itemAccess = itemsArray[i].access;
            itemIcon = itemsArray[i].icon;
            if(itemPermission != "writeonly")
            {
               try
               {
                  if(itemAccess == "displayObject")
                  {
                     if(object is flash.display.DisplayObjectContainer)
                     {
                        item = flash.display.DisplayObjectContainer(object).getChildAt(itemsArray[i].index);
                     }
                     else if(object is starling.display.DisplayObjectContainer)
                     {
                        item = starling.display.DisplayObjectContainer(object).getChildAt(itemsArray[i].index);
                     }
                  }
                  else
                  {
                     item = object[itemName];
                  }
               }
               catch(e2:Error)
               {
                  item = null;
               }
               if(itemType == "String" || itemType == "Boolean" || itemType == "Number" || itemType == "int" || itemType == "uint" || itemType == "Function")
               {
                  nodeXML = <node/>;
                  nodeXML.@icon = itemIcon;
                  nodeXML.@label = itemName + " (" + itemType + ") = " + printValue(item,itemType,true);
                  nodeXML.@name = itemName;
                  nodeXML.@type = itemType;
                  nodeXML.@value = printValue(item,itemType);
                  nodeXML.@target = itemTarget;
                  nodeXML.@access = itemAccess;
                  nodeXML.@permission = itemPermission;
                  rootXML.appendChild(nodeXML);
               }
               else
               {
                  nodeXML = <node/>;
                  nodeXML.@icon = itemIcon;
                  nodeXML.@label = itemName + " (" + itemType + ")";
                  nodeXML.@name = itemName;
                  nodeXML.@type = itemType;
                  nodeXML.@target = itemTarget;
                  nodeXML.@access = itemAccess;
                  nodeXML.@permission = itemPermission;
                  if(item == null)
                  {
                     nodeXML.@icon = "iconWarning";
                     nodeXML.@label = nodeXML.@label + " = null";
                  }
                  nodeXML.appendChild(parse(item,itemTarget,currentDepth + 1,maxDepth,includeDisplayObjects).children());
                  rootXML.appendChild(nodeXML);
               }
            }
            i++;
         }
         return rootXML;
      }
      
      public static function parseFunctions(object:*, target:String = "") : XML
      {
         var itemXML:* = null;
         var key:* = null;
         var returnType:* = null;
         var parameters:* = null;
         var parametersLength:int = 0;
         var args:* = null;
         var argsString:* = null;
         var methodXML:* = null;
         var parameterXML:* = null;
         var rootXML:XML = <root/>;
         var description:XML = MonsterDebuggerDescribeType.get(object);
         var type:String = parseType(description.@name);
         var itemType:String = "";
         var itemName:String = "";
         var itemTarget:String = "";
         var keys:Object = {};
         var methods:XMLList = description..method;
         var methodsArr:Array = [];
         var methodsLength:int = methods.length();
         var optional:Boolean = false;
         var i:int = 0;
         var n:int = 0;
         itemXML = <node/>;
         itemXML.@icon = "iconDefault";
         itemXML.@label = "(" + type + ")";
         itemXML.@target = target;
         for(i = 0; i < methodsLength; )
         {
            key = methods[i].@name;
            try
            {
               if(!keys.hasOwnProperty(key))
               {
                  keys[key] = key;
                  methodsArr[methodsArr.length] = {
                     "name":key,
                     "xml":methods[i],
                     "access":"method"
                  };
               }
            }
            catch(e:Error)
            {
            }
            i++;
         }
         methodsArr.sortOn("name",1);
         methodsLength = methodsArr.length;
         for(i = 0; i < methodsLength; )
         {
            itemType = "Function";
            itemName = methodsArr[i].xml.@name;
            itemTarget = target + "." + itemName;
            returnType = parseType(methodsArr[i].xml.@returnType);
            parameters = methodsArr[i].xml..parameter;
            parametersLength = parameters.length();
            args = [];
            argsString = "";
            optional = false;
            for(n = 0; n < parametersLength; )
            {
               if(parameters[n].@optional == "true" && !optional)
               {
                  optional = true;
                  args[args.length] = "[";
               }
               args[args.length] = parseType(parameters[n].@type);
               n++;
            }
            if(optional)
            {
               args[args.length] = "]";
            }
            argsString = args.join(", ");
            argsString = argsString.replace("[, ","[");
            argsString = argsString.replace(", ]","]");
            methodXML = <node/>;
            methodXML.@icon = "iconFunction";
            methodXML.@type = "Function";
            methodXML.@access = "method";
            methodXML.@label = itemName + "(" + argsString + "):" + returnType;
            methodXML.@name = itemName;
            methodXML.@target = itemTarget;
            methodXML.@args = argsString;
            methodXML.@returnType = returnType;
            for(n = 0; n < parametersLength; )
            {
               parameterXML = <node/>;
               parameterXML.@type = parseType(parameters[n].@type);
               parameterXML.@index = parameters[n].@index;
               parameterXML.@optional = parameters[n].@optional;
               methodXML.appendChild(parameterXML);
               n++;
            }
            itemXML.appendChild(methodXML);
            i++;
         }
         rootXML.appendChild(itemXML);
         return rootXML;
      }
      
      public static function parseType(type:String) : String
      {
         var part1:* = null;
         var part2:* = null;
         if(type.indexOf("::") != -1)
         {
            type = type.substring(type.indexOf("::") + 2,type.length);
         }
         if(type.indexOf("::") != -1)
         {
            part1 = type.substring(0,type.indexOf("<") + 1);
            part2 = type.substring(type.indexOf("::") + 2,type.length);
            type = part1 + part2;
         }
         type = type.replace("()","");
         type = type.replace("MethodClosure","Function");
         return type;
      }
      
      public static function isDisplayObject(object:*) : Boolean
      {
         return object is flash.display.DisplayObject || object is flash.display.DisplayObjectContainer;
      }
      
      public static function isStarlingDisplayObject(object:*) : Boolean
      {
         return object is starling.display.DisplayObject || object is starling.display.DisplayObjectContainer;
      }
      
      public static function printValue(value:*, type:String, limit:Boolean = false) : String
      {
         if(type == "ByteArray")
         {
            return value["length"] + " bytes";
         }
         if(value == null)
         {
            return "null";
         }
         var v:String = String(value);
         if(limit && v.length > 140)
         {
            v = v.substr(0,140) + "...";
         }
         return v;
      }
      
      public static function getObjectUnderPoint(container:flash.display.DisplayObjectContainer, point:Point) : flash.display.DisplayObject
      {
         var objects:* = null;
         var object:* = null;
         var i:int = 0;
         var o:* = null;
         if(container.areInaccessibleObjectsUnderPoint(point))
         {
            return container;
         }
         objects = container.getObjectsUnderPoint(point);
         objects.reverse();
         if(objects == null || objects.length == 0)
         {
            return container;
         }
         object = objects[0];
         objects.length = 0;
         while(true)
         {
            objects[objects.length] = object;
            if(object.parent != null)
            {
               object = object.parent;
               continue;
            }
            break;
         }
         objects.reverse();
         for(i = 0; i < objects.length; )
         {
            o = objects[i];
            if(o is flash.display.DisplayObjectContainer)
            {
               object = o;
               if(flash.display.DisplayObjectContainer(o).mouseChildren)
               {
                  i++;
                  continue;
               }
               break;
            }
            break;
         }
         return object;
      }
      
      public static function getStarlingObjectUnderPoint(container:starling.display.DisplayObjectContainer, point:Point) : starling.display.DisplayObject
      {
         var i:int = 0;
         var o:* = null;
         var object:* = container.hitTest(point,false);
         if(object == null || object == container)
         {
            return container;
         }
         var objects:Array = [];
         while(true)
         {
            objects[objects.length] = object;
            if(object.parent != null)
            {
               object = object.parent;
               continue;
            }
            break;
         }
         objects.reverse();
         for(i = 0; i < objects.length; )
         {
            o = objects[i];
            if(o is starling.display.DisplayObjectContainer)
            {
               container = starling.display.DisplayObjectContainer(o);
               if(!container.touchable || !container.visible)
               {
                  if(container.stage == container)
                  {
                     return container;
                  }
                  break;
               }
               object = o;
               i++;
               continue;
            }
            break;
         }
         return object;
      }
   }
}
