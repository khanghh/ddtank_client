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
      
      public static function snapshot(param1:flash.display.DisplayObject, param2:Rectangle = null) : BitmapData
      {
         var _loc7_:* = null;
         var _loc11_:* = null;
         var _loc10_:Number = NaN;
         var _loc6_:* = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc5_:Boolean = param1.visible;
         var _loc13_:Number = param1.alpha;
         var _loc12_:Number = param1.rotation;
         var _loc3_:Number = param1.scaleX;
         var _loc4_:Number = param1.scaleY;
         try
         {
            param1.visible = true;
            param1.alpha = 1;
            param1.rotation = 0;
            param1.scaleX = 1;
            param1.scaleY = 1;
         }
         catch(e1:Error)
         {
         }
         var _loc8_:Rectangle = param1.getBounds(param1);
         _loc8_.x = int(_loc8_.x + 0.5);
         _loc8_.y = int(_loc8_.y + 0.5);
         _loc8_.width = int(_loc8_.width + 0.5);
         _loc8_.height = int(_loc8_.height + 0.5);
         if(param1 is Stage)
         {
            _loc8_.x = 0;
            _loc8_.y = 0;
            _loc8_.width = Stage(param1).stageWidth;
            _loc8_.height = Stage(param1).stageHeight;
         }
         var _loc9_:* = null;
         if(_loc8_.width <= 0 || _loc8_.height <= 0)
         {
            return null;
         }
         try
         {
            _loc9_ = new BitmapData(_loc8_.width,_loc8_.height,false,16777215);
            _loc7_ = new Matrix();
            _loc7_.tx = -_loc8_.x;
            _loc7_.ty = -_loc8_.y;
            _loc9_.draw(param1,_loc7_,null,null,null,false);
         }
         catch(e2:Error)
         {
            _loc9_ = null;
         }
         try
         {
            param1.visible = _loc5_;
            param1.alpha = _loc13_;
            param1.rotation = _loc12_;
            param1.scaleX = _loc3_;
            param1.scaleY = _loc4_;
         }
         catch(e3:Error)
         {
         }
         if(_loc9_ == null)
         {
            return null;
         }
         if(param2 != null)
         {
            if(_loc8_.width <= param2.width && _loc8_.height <= param2.height)
            {
               return _loc9_;
            }
            _loc11_ = _loc8_.clone();
            _loc11_.width = param2.width;
            _loc11_.height = param2.width * (_loc8_.height / _loc8_.width);
            if(_loc11_.height > param2.height)
            {
               _loc11_ = _loc8_.clone();
               _loc11_.width = param2.height * (_loc8_.width / _loc8_.height);
               _loc11_.height = param2.height;
            }
            _loc10_ = _loc11_.width / _loc8_.width;
            try
            {
               _loc6_ = new BitmapData(_loc11_.width,_loc11_.height,false,0);
               _loc7_ = new Matrix();
               _loc7_.scale(_loc10_,_loc10_);
               _loc6_.draw(_loc9_,_loc7_,null,null,null,true);
               _loc9_.dispose();
               _loc9_ = _loc6_;
            }
            catch(e4:Error)
            {
               _loc9_.dispose();
               _loc9_ = null;
            }
         }
         return _loc9_;
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
         var _loc12_:* = null;
         var _loc10_:* = null;
         var _loc4_:int = 0;
         var _loc7_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc1_:* = null;
         var _loc11_:* = null;
         var _loc8_:* = null;
         var _loc3_:* = null;
         var _loc13_:* = null;
         var _loc2_:XML = <root/>;
         var _loc9_:XML = <node/>;
         try
         {
            throw new Error();
         }
         catch(e:Error)
         {
            _loc12_ = e.getStackTrace();
            if(_loc12_ == null || _loc12_ == "")
            {
               var _loc15_:* = <root><error>Stack unavailable</error></root>;
               return _loc15_;
            }
            _loc12_ = _loc12_.split("\t").join("");
            _loc10_ = _loc12_.split("\n");
            if(_loc10_.length <= 4)
            {
               var _loc17_:* = <root><error>Stack to short</error></root>;
               return _loc17_;
            }
            _loc10_.shift();
            _loc10_.shift();
            _loc10_.shift();
            _loc10_.shift();
            _loc4_ = 0;
            while(_loc4_ < _loc10_.length)
            {
               _loc7_ = _loc10_[_loc4_];
               _loc7_ = _loc7_.substring(3,_loc7_.length);
               _loc5_ = _loc7_.indexOf("[");
               _loc6_ = int(_loc7_.indexOf("/"));
               if(_loc5_ == -1)
               {
                  _loc5_ = _loc7_.length;
               }
               if(_loc6_ == -1)
               {
                  _loc6_ = _loc5_;
               }
               _loc1_ = MonsterDebuggerUtils.parseType(_loc7_.substring(0,_loc6_));
               _loc11_ = "";
               _loc8_ = "";
               _loc3_ = "";
               if(_loc6_ != _loc7_.length && _loc6_ != _loc5_)
               {
                  _loc11_ = _loc7_.substring(_loc6_ + 1,_loc5_);
               }
               if(_loc5_ != _loc7_.length)
               {
                  _loc8_ = _loc7_.substring(_loc5_ + 1,_loc7_.lastIndexOf(":"));
                  _loc3_ = _loc7_.substring(_loc7_.lastIndexOf(":") + 1,_loc7_.length - 1);
               }
               _loc13_ = <node/>;
               _loc13_.@classname = _loc1_;
               _loc13_.@method = _loc11_;
               _loc13_.@file = _loc8_;
               _loc13_.@line = _loc3_;
               _loc9_.appendChild(_loc13_);
               _loc4_++;
            }
         }
         _loc2_.appendChild(_loc9_.children());
         return _loc2_;
      }
      
      public static function getReferenceID(param1:*) : String
      {
         if(param1 in _references)
         {
            return _references[param1];
         }
         var _loc2_:String = "#" + String(_reference);
         _references[param1] = _loc2_;
         _reference = Number(_reference) + 1;
         return _loc2_;
      }
      
      public static function getReference(param1:String) : *
      {
         var _loc2_:* = null;
         if(param1.charAt(0) != "#")
         {
            return null;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _references;
         for(var _loc3_ in _references)
         {
            _loc2_ = _references[_loc3_];
            if(_loc2_ == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function getObject(param1:*, param2:String = "", param3:int = 0) : *
      {
         var _loc7_:int = 0;
         var _loc4_:Number = NaN;
         if(param2 == null || param2 == "")
         {
            return param1;
         }
         if(param2.charAt(0) == "#")
         {
            return getReference(param2);
         }
         var _loc6_:* = param1;
         var _loc5_:Array = param2.split(".");
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length - param3)
         {
            if(_loc5_[_loc7_] != "")
            {
               try
               {
                  if(_loc5_[_loc7_] == "children()")
                  {
                     _loc6_ = _loc6_.children();
                  }
                  else if(_loc6_ is flash.display.DisplayObjectContainer && _loc5_[_loc7_].indexOf("getChildAt(") == 0)
                  {
                     _loc4_ = _loc5_[_loc7_].substring(11,_loc5_[_loc7_].indexOf(")",11));
                     _loc6_ = flash.display.DisplayObjectContainer(_loc6_).getChildAt(_loc4_);
                  }
                  else if(_loc6_ is starling.display.DisplayObjectContainer && _loc5_[_loc7_].indexOf("getChildAt(") == 0)
                  {
                     _loc4_ = _loc5_[_loc7_].substring(11,_loc5_[_loc7_].indexOf(")",11));
                     _loc6_ = starling.display.DisplayObjectContainer(_loc6_).getChildAt(_loc4_);
                  }
                  else
                  {
                     _loc6_ = _loc6_[_loc5_[_loc7_]];
                  }
               }
               catch(e:Error)
               {
                  break;
               }
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      public static function parse(param1:*, param2:String = "", param3:int = 1, param4:int = 5, param5:Boolean = true) : XML
      {
         var _loc11_:* = null;
         var _loc7_:XML = <root/>;
         var _loc13_:XML = <node/>;
         var _loc12_:XML = new XML();
         var _loc10_:String = "";
         var _loc14_:String = "";
         var _loc8_:Boolean = false;
         var _loc9_:String = null;
         var _loc6_:String = "iconRoot";
         if(param4 != -1 && param3 > param4)
         {
            return _loc7_;
         }
         if(param1 == null)
         {
            _loc10_ = "null";
            _loc9_ = "null";
            _loc6_ = "iconWarning";
         }
         else
         {
            _loc12_ = MonsterDebuggerDescribeType.get(param1);
            _loc10_ = parseType(_loc12_.@name);
            _loc14_ = parseType(_loc12_.@base);
            _loc8_ = _loc12_.@isDynamic;
            if(param1 is Class)
            {
               _loc9_ = "Class = " + _loc10_;
               _loc10_ = "Class";
               _loc13_.appendChild(parseClass(param1,param2,_loc12_,param3,param4,param5).children());
            }
            else if(_loc10_ == "XML")
            {
               _loc13_.appendChild(parseXML(param1,param2 + ".children()",param3,param4).children());
            }
            else if(_loc10_ == "XMLList")
            {
               _loc9_ = _loc10_ + " [" + String(param1.length()) + "]";
               _loc13_.appendChild(parseXMLList(param1,param2,param3,param4).children());
            }
            else if(_loc10_ == "Array" || _loc10_.indexOf("Vector.") == 0)
            {
               _loc9_ = _loc10_ + " [" + String(param1["length"]) + "]";
               _loc13_.appendChild(parseArray(param1,param2,param3,param4).children());
            }
            else if(_loc10_ == "String" || _loc10_ == "Boolean" || _loc10_ == "Number" || _loc10_ == "int" || _loc10_ == "uint")
            {
               _loc13_.appendChild(parseBasics(param1,param2,_loc10_).children());
            }
            else if(_loc10_ == "Object")
            {
               _loc13_.appendChild(parseObject(param1,param2,param3,param4,param5).children());
            }
            else
            {
               _loc13_.appendChild(parseClass(param1,param2,_loc12_,param3,param4,param5).children());
            }
         }
         if(param3 == 1)
         {
            _loc11_ = <node/>;
            _loc11_.@icon = _loc6_;
            _loc11_.@label = _loc10_;
            _loc11_.@type = _loc10_;
            _loc11_.@target = param2;
            if(_loc9_ != null)
            {
               _loc11_.@label = _loc9_;
            }
            _loc11_.appendChild(_loc13_.children());
            _loc7_.appendChild(_loc11_);
         }
         else
         {
            _loc7_.appendChild(_loc13_.children());
         }
         return _loc7_;
      }
      
      private static function parseBasics(param1:*, param2:String, param3:String) : XML
      {
         var _loc5_:XML = <root/>;
         var _loc4_:XML = <node/>;
         _loc4_.@icon = "iconVariable";
         _loc4_.@access = "variable";
         _loc4_.@permission = "readwrite";
         _loc4_.@label = param3 + " = " + printValue(param1,param3,true);
         _loc4_.@name = "";
         _loc4_.@type = param3;
         _loc4_.@value = printValue(param1,param3);
         _loc4_.@target = param2;
         _loc5_.appendChild(_loc4_);
         return _loc5_;
      }
      
      private static function parseArray(param1:*, param2:String, param3:int = 1, param4:int = 5, param5:Boolean = true) : XML
      {
         var _loc11_:* = null;
         var _loc9_:XML = <root/>;
         var _loc12_:String = "";
         var _loc7_:String = "";
         var _loc10_:int = 0;
         var _loc8_:Array = [];
         var _loc6_:Boolean = true;
         var _loc15_:int = 0;
         var _loc14_:* = param1;
         for(var _loc13_ in param1)
         {
            if(!(_loc13_ is int))
            {
               _loc6_ = false;
            }
            _loc8_.push(_loc13_);
         }
         if(_loc6_)
         {
            _loc8_.sort(16);
         }
         else
         {
            _loc8_.sort(1);
         }
         _loc10_ = 0;
         while(_loc10_ < _loc8_.length)
         {
            _loc12_ = parseType(MonsterDebuggerDescribeType.get(param1[_loc8_[_loc10_]]).@name);
            _loc7_ = param2 + "." + String(_loc8_[_loc10_]);
            if(_loc12_ == "String" || _loc12_ == "Boolean" || _loc12_ == "Number" || _loc12_ == "int" || _loc12_ == "uint" || _loc12_ == "Function")
            {
               _loc11_ = <node/>;
               _loc11_.@icon = "iconVariable";
               _loc11_.@access = "variable";
               _loc11_.@permission = "readwrite";
               _loc11_.@label = "[" + _loc8_[_loc10_] + "] (" + _loc12_ + ") = " + printValue(param1[_loc8_[_loc10_]],_loc12_,true);
               _loc11_.@name = "[" + _loc8_[_loc10_] + "]";
               _loc11_.@type = _loc12_;
               _loc11_.@value = printValue(param1[_loc8_[_loc10_]],_loc12_);
               _loc11_.@target = _loc7_;
               _loc9_.appendChild(_loc11_);
            }
            else
            {
               _loc11_ = <node/>;
               _loc11_.@icon = "iconVariable";
               _loc11_.@access = "variable";
               _loc11_.@permission = "readwrite";
               _loc11_.@label = "[" + _loc8_[_loc10_] + "] (" + _loc12_ + ")";
               _loc11_.@name = "[" + _loc8_[_loc10_] + "]";
               _loc11_.@type = _loc12_;
               _loc11_.@value = "";
               _loc11_.@target = _loc7_;
               if(param1[_loc8_[_loc10_]] == null)
               {
                  _loc11_.@icon = "iconWarning";
                  _loc11_.@label = _loc11_.@label + " = null";
               }
               _loc11_.appendChild(parse(param1[_loc8_[_loc10_]],_loc7_,param3 + 1,param4,param5).children());
               _loc9_.appendChild(_loc11_);
            }
            _loc10_++;
         }
         return _loc9_;
      }
      
      public static function parseXML(param1:*, param2:String = "", param3:int = 1, param4:int = -1) : XML
      {
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc8_:XML = <root/>;
         var _loc9_:int = 0;
         if(param4 != -1 && param3 > param4)
         {
            return _loc8_;
         }
         if(param2.indexOf("@") != -1)
         {
            _loc7_ = <node/>;
            _loc7_.@icon = "iconXMLAttribute";
            _loc7_.@type = "XMLAttribute";
            _loc7_.@access = "variable";
            _loc7_.@permission = "readwrite";
            _loc7_.@label = param1;
            _loc7_.@name = "";
            _loc7_.@value = param1;
            _loc7_.@target = param2;
            _loc8_.appendChild(_loc7_);
         }
         else if("name" in param1 && param1.name() == null)
         {
            _loc7_ = <node/>;
            _loc7_.@icon = "iconXMLValue";
            _loc7_.@type = "XMLValue";
            _loc7_.@access = "variable";
            _loc7_.@permission = "readwrite";
            _loc7_.@label = "(XMLValue) = " + printValue(param1,"XMLValue",true);
            _loc7_.@name = "";
            _loc7_.@value = printValue(param1,"XMLValue");
            _loc7_.@target = param2;
            _loc8_.appendChild(_loc7_);
         }
         else if("hasSimpleContent" in param1 && param1.hasSimpleContent())
         {
            _loc7_ = <node/>;
            _loc7_.@icon = "iconXMLNode";
            _loc7_.@type = "XMLNode";
            _loc7_.@access = "variable";
            _loc7_.@permission = "readwrite";
            _loc7_.@label = param1.name() + " (" + "XMLNode" + ")";
            _loc7_.@name = param1.name();
            _loc7_.@value = "";
            _loc7_.@target = param2;
            if(param1 != "")
            {
               _loc6_ = <node/>;
               _loc6_.@icon = "iconXMLValue";
               _loc6_.@type = "XMLValue";
               _loc6_.@access = "variable";
               _loc6_.@permission = "readwrite";
               _loc6_.@label = "(XMLValue) = " + printValue(param1,"XMLValue");
               _loc6_.@name = "";
               _loc6_.@value = printValue(param1,"XMLValue");
               _loc6_.@target = param2;
               _loc7_.appendChild(_loc6_);
            }
            _loc9_ = 0;
            while(_loc9_ < param1.attributes().length())
            {
               _loc6_ = <node/>;
               _loc6_.@icon = "iconXMLAttribute";
               _loc6_.@type = "XMLAttribute";
               _loc6_.@access = "variable";
               _loc6_.@permission = "readwrite";
               _loc6_.@label = "@" + param1.attributes()[_loc9_].name() + " (" + "XMLAttribute" + ") = " + param1.attributes()[_loc9_];
               _loc6_.@name = "";
               _loc6_.@value = param1.attributes()[_loc9_];
               _loc6_.@target = param2 + "." + "@" + param1.attributes()[_loc9_].name();
               _loc7_.appendChild(_loc6_);
               _loc9_++;
            }
            _loc8_.appendChild(_loc7_);
         }
         else
         {
            _loc7_ = <node/>;
            _loc7_.@icon = "iconXMLNode";
            _loc7_.@type = "XMLNode";
            _loc7_.@access = "variable";
            _loc7_.@permission = "readwrite";
            _loc7_.@label = param1.name() + " (" + "XMLNode" + ")";
            _loc7_.@name = param1.name();
            _loc7_.@value = "";
            _loc7_.@target = param2;
            _loc9_ = 0;
            while(_loc9_ < param1.attributes().length())
            {
               _loc6_ = <node/>;
               _loc6_.@icon = "iconXMLAttribute";
               _loc6_.@type = "XMLAttribute";
               _loc6_.@access = "variable";
               _loc6_.@permission = "readwrite";
               _loc6_.@label = "@" + param1.attributes()[_loc9_].name() + " (" + "XMLAttribute" + ") = " + param1.attributes()[_loc9_];
               _loc6_.@name = "";
               _loc6_.@value = param1.attributes()[_loc9_];
               _loc6_.@target = param2 + "." + "@" + param1.attributes()[_loc9_].name();
               _loc7_.appendChild(_loc6_);
               _loc9_++;
            }
            _loc9_ = 0;
            while(_loc9_ < param1.children().length())
            {
               _loc5_ = param2 + "." + "children()" + "." + _loc9_;
               _loc7_.appendChild(parseXML(param1.children()[_loc9_],_loc5_,param3 + 1,param4).children());
               _loc9_++;
            }
            _loc8_.appendChild(_loc7_);
         }
         return _loc8_;
      }
      
      public static function parseXMLList(param1:*, param2:String = "", param3:int = 1, param4:int = -1) : XML
      {
         var _loc6_:int = 0;
         var _loc5_:XML = <root/>;
         if(param4 != -1 && param3 > param4)
         {
            return _loc5_;
         }
         _loc6_ = 0;
         while(_loc6_ < param1.length())
         {
            _loc5_.appendChild(parseXML(param1[_loc6_],param2 + "." + String(_loc6_) + ".children()",param3,param4).children());
            _loc6_++;
         }
         return _loc5_;
      }
      
      private static function parseObject(param1:*, param2:String, param3:int = 1, param4:int = 5, param5:Boolean = true) : XML
      {
         var _loc13_:* = null;
         var _loc9_:XML = <root/>;
         var _loc10_:XML = <node/>;
         var _loc14_:String = "";
         var _loc7_:String = "";
         var _loc12_:int = 0;
         var _loc11_:Array = [];
         var _loc6_:Boolean = true;
         var _loc16_:int = 0;
         var _loc15_:* = param1;
         for(var _loc8_ in param1)
         {
            if(!(_loc8_ is int))
            {
               _loc6_ = false;
            }
            _loc11_.push(_loc8_);
         }
         if(_loc6_)
         {
            _loc11_.sort(16);
         }
         else
         {
            _loc11_.sort(1);
         }
         _loc12_ = 0;
         while(_loc12_ < _loc11_.length)
         {
            _loc14_ = parseType(MonsterDebuggerDescribeType.get(param1[_loc11_[_loc12_]]).@name);
            _loc7_ = param2 + "." + _loc11_[_loc12_];
            if(_loc14_ == "String" || _loc14_ == "Boolean" || _loc14_ == "Number" || _loc14_ == "int" || _loc14_ == "uint" || _loc14_ == "Function")
            {
               _loc13_ = <node/>;
               _loc13_.@icon = "iconVariable";
               _loc13_.@access = "variable";
               _loc13_.@permission = "readwrite";
               _loc13_.@label = _loc11_[_loc12_] + " (" + _loc14_ + ") = " + printValue(param1[_loc11_[_loc12_]],_loc14_,true);
               _loc13_.@name = _loc11_[_loc12_];
               _loc13_.@type = _loc14_;
               _loc13_.@value = printValue(param1[_loc11_[_loc12_]],_loc14_);
               _loc13_.@target = _loc7_;
               _loc10_.appendChild(_loc13_);
            }
            else
            {
               _loc13_ = <node/>;
               _loc13_.@icon = "iconVariable";
               _loc13_.@access = "variable";
               _loc13_.@permission = "readwrite";
               _loc13_.@label = _loc11_[_loc12_] + " (" + _loc14_ + ")";
               _loc13_.@name = _loc11_[_loc12_];
               _loc13_.@type = _loc14_;
               _loc13_.@value = "";
               _loc13_.@target = _loc7_;
               if(param1[_loc11_[_loc12_]] == null)
               {
                  _loc13_.@icon = "iconWarning";
                  _loc13_.@label = _loc13_.@label + " = null";
               }
               _loc13_.appendChild(parse(param1[_loc11_[_loc12_]],_loc7_,param3 + 1,param4,param5).children());
               _loc10_.appendChild(_loc13_);
            }
            _loc12_++;
         }
         _loc9_.appendChild(_loc10_.children());
         return _loc9_;
      }
      
      private static function parseClass(param1:*, param2:String, param3:XML, param4:int = 1, param5:int = 5, param6:Boolean = true) : XML
      {
         var _loc17_:* = null;
         var _loc18_:int = 0;
         var _loc34_:* = undefined;
         var _loc19_:* = null;
         var _loc30_:* = null;
         var _loc10_:* = null;
         var _loc35_:* = null;
         var _loc23_:* = null;
         var _loc20_:* = null;
         var _loc22_:* = null;
         var _loc31_:int = 0;
         var _loc11_:* = null;
         var _loc7_:* = null;
         var _loc12_:* = null;
         var _loc29_:* = null;
         var _loc15_:* = null;
         var _loc28_:XML = <root/>;
         var _loc27_:XML = <node/>;
         var _loc32_:XMLList = param3..variable;
         var _loc9_:XMLList = param3..accessor;
         var _loc26_:XMLList = param3..constant;
         var _loc25_:Boolean = param3.@isDynamic;
         var _loc13_:int = _loc32_.length();
         var _loc8_:int = _loc9_.length();
         var _loc16_:int = _loc26_.length();
         var _loc14_:int = 0;
         var _loc21_:Object = {};
         var _loc33_:Array = [];
         if(_loc25_)
         {
            var _loc37_:int = 0;
            var _loc36_:* = param1;
            for(_loc17_ in param1)
            {
               if(!_loc21_.hasOwnProperty(_loc17_))
               {
                  _loc21_[_loc17_] = _loc17_;
                  _loc20_ = _loc17_;
                  _loc23_ = parseType(getQualifiedClassName(param1[_loc17_]));
                  _loc22_ = param2 + "." + _loc17_;
                  _loc30_ = "variable";
                  _loc10_ = "readwrite";
                  _loc35_ = "iconVariable";
                  _loc33_[_loc33_.length] = {
                     "name":_loc20_,
                     "type":_loc23_,
                     "target":_loc22_,
                     "access":_loc30_,
                     "permission":_loc10_,
                     "icon":_loc35_
                  };
               }
            }
         }
         _loc31_ = 0;
         while(_loc31_ < _loc13_)
         {
            _loc17_ = _loc32_[_loc31_].@name;
            if(!_loc21_.hasOwnProperty(_loc17_))
            {
               _loc21_[_loc17_] = _loc17_;
               _loc20_ = _loc17_;
               _loc23_ = parseType(_loc32_[_loc31_].@type);
               _loc22_ = param2 + "." + _loc17_;
               _loc30_ = "variable";
               _loc10_ = "readwrite";
               _loc35_ = "iconVariable";
               _loc33_[_loc33_.length] = {
                  "name":_loc20_,
                  "type":_loc23_,
                  "target":_loc22_,
                  "access":_loc30_,
                  "permission":_loc10_,
                  "icon":_loc35_
               };
            }
            _loc31_++;
         }
         _loc31_ = 0;
         while(_loc31_ < _loc8_)
         {
            _loc17_ = _loc9_[_loc31_].@name;
            if(!_loc21_.hasOwnProperty(_loc17_))
            {
               _loc21_[_loc17_] = _loc17_;
               _loc20_ = _loc17_;
               _loc23_ = parseType(_loc9_[_loc31_].@type);
               _loc22_ = param2 + "." + _loc17_;
               _loc30_ = "accessor";
               _loc10_ = "readwrite";
               _loc35_ = "iconVariable";
               if(_loc9_[_loc31_].@access == "readonly")
               {
                  _loc10_ = "readonly";
                  _loc35_ = "iconVariableReadonly";
               }
               if(_loc9_[_loc31_].@access == "writeonly")
               {
                  _loc10_ = "writeonly";
                  _loc35_ = "iconVariableWriteonly";
               }
               _loc33_[_loc33_.length] = {
                  "name":_loc20_,
                  "type":_loc23_,
                  "target":_loc22_,
                  "access":_loc30_,
                  "permission":_loc10_,
                  "icon":_loc35_
               };
            }
            _loc31_++;
         }
         _loc31_ = 0;
         while(_loc31_ < _loc16_)
         {
            _loc17_ = _loc26_[_loc31_].@name;
            if(!_loc21_.hasOwnProperty(_loc17_))
            {
               _loc21_[_loc17_] = _loc17_;
               _loc20_ = _loc17_;
               _loc23_ = parseType(_loc26_[_loc31_].@type);
               _loc22_ = param2 + "." + _loc17_;
               _loc30_ = "constant";
               _loc10_ = "readonly";
               _loc35_ = "iconVariableReadonly";
               _loc33_[_loc33_.length] = {
                  "name":_loc20_,
                  "type":_loc23_,
                  "target":_loc22_,
                  "access":_loc30_,
                  "permission":_loc10_,
                  "icon":_loc35_
               };
            }
            _loc31_++;
         }
         _loc33_.sortOn("name",1);
         if(param6 && param1 is flash.display.DisplayObjectContainer)
         {
            _loc11_ = flash.display.DisplayObjectContainer(param1);
            _loc7_ = [];
            _loc14_ = _loc11_.numChildren;
            _loc31_ = 0;
            while(_loc31_ < _loc14_)
            {
               _loc12_ = null;
               try
               {
                  _loc12_ = _loc11_.getChildAt(_loc31_);
               }
               catch(e1:Error)
               {
               }
               if(_loc12_ != null)
               {
                  _loc19_ = MonsterDebuggerDescribeType.get(_loc12_);
                  _loc23_ = parseType(_loc19_.@name);
                  _loc20_ = "DisplayObject";
                  if(_loc12_.name != null)
                  {
                     _loc20_ = _loc20_ + (" - " + _loc12_.name);
                  }
                  _loc22_ = param2 + "." + "getChildAt(" + _loc31_ + ")";
                  _loc30_ = "displayObject";
                  _loc10_ = "readwrite";
                  _loc35_ = _loc12_ is flash.display.DisplayObjectContainer?"iconRoot":"iconDisplayObject";
                  _loc7_[_loc7_.length] = {
                     "name":_loc20_,
                     "type":_loc23_,
                     "target":_loc22_,
                     "access":_loc30_,
                     "permission":_loc10_,
                     "icon":_loc35_,
                     "index":_loc31_
                  };
               }
               _loc31_++;
            }
            _loc7_.sortOn("name",1);
            _loc33_ = _loc7_.concat(_loc33_);
         }
         else if(param6 && param1 is starling.display.DisplayObjectContainer)
         {
            _loc29_ = starling.display.DisplayObjectContainer(param1);
            _loc7_ = [];
            _loc14_ = _loc29_.numChildren;
            _loc31_ = 0;
            while(_loc31_ < _loc14_)
            {
               _loc15_ = null;
               try
               {
                  _loc15_ = _loc29_.getChildAt(_loc31_);
               }
               catch(e1:Error)
               {
               }
               if(_loc15_ != null)
               {
                  _loc19_ = MonsterDebuggerDescribeType.get(_loc15_);
                  _loc23_ = parseType(_loc19_.@name);
                  _loc20_ = "Starling DisplayObject";
                  if(_loc15_.name != null)
                  {
                     _loc20_ = _loc20_ + (" - " + _loc15_.name);
                  }
                  _loc22_ = param2 + "." + "getChildAt(" + _loc31_ + ")";
                  _loc30_ = "displayObject";
                  _loc10_ = "readwrite";
                  _loc35_ = _loc15_ is starling.display.DisplayObjectContainer?"iconRoot":"iconDisplayObject";
                  _loc7_[_loc7_.length] = {
                     "name":_loc20_,
                     "type":_loc23_,
                     "target":_loc22_,
                     "access":_loc30_,
                     "permission":_loc10_,
                     "icon":_loc35_,
                     "index":_loc31_
                  };
               }
               _loc31_++;
            }
            _loc7_.sortOn("name",1);
            _loc33_ = _loc7_.concat(_loc33_);
         }
         _loc18_ = _loc33_.length;
         _loc31_ = 0;
         while(_loc31_ < _loc18_)
         {
            _loc23_ = _loc33_[_loc31_].type;
            _loc20_ = _loc33_[_loc31_].name;
            _loc22_ = _loc33_[_loc31_].target;
            _loc10_ = _loc33_[_loc31_].permission;
            _loc30_ = _loc33_[_loc31_].access;
            _loc35_ = _loc33_[_loc31_].icon;
            if(_loc10_ != "writeonly")
            {
               try
               {
                  if(_loc30_ == "displayObject")
                  {
                     if(param1 is flash.display.DisplayObjectContainer)
                     {
                        _loc34_ = flash.display.DisplayObjectContainer(param1).getChildAt(_loc33_[_loc31_].index);
                     }
                     else if(param1 is starling.display.DisplayObjectContainer)
                     {
                        _loc34_ = starling.display.DisplayObjectContainer(param1).getChildAt(_loc33_[_loc31_].index);
                     }
                  }
                  else
                  {
                     _loc34_ = param1[_loc20_];
                  }
               }
               catch(e2:Error)
               {
                  _loc34_ = null;
               }
               if(_loc23_ == "String" || _loc23_ == "Boolean" || _loc23_ == "Number" || _loc23_ == "int" || _loc23_ == "uint" || _loc23_ == "Function")
               {
                  _loc27_ = <node/>;
                  _loc27_.@icon = _loc35_;
                  _loc27_.@label = _loc20_ + " (" + _loc23_ + ") = " + printValue(_loc34_,_loc23_,true);
                  _loc27_.@name = _loc20_;
                  _loc27_.@type = _loc23_;
                  _loc27_.@value = printValue(_loc34_,_loc23_);
                  _loc27_.@target = _loc22_;
                  _loc27_.@access = _loc30_;
                  _loc27_.@permission = _loc10_;
                  _loc28_.appendChild(_loc27_);
               }
               else
               {
                  _loc27_ = <node/>;
                  _loc27_.@icon = _loc35_;
                  _loc27_.@label = _loc20_ + " (" + _loc23_ + ")";
                  _loc27_.@name = _loc20_;
                  _loc27_.@type = _loc23_;
                  _loc27_.@target = _loc22_;
                  _loc27_.@access = _loc30_;
                  _loc27_.@permission = _loc10_;
                  if(_loc34_ == null)
                  {
                     _loc27_.@icon = "iconWarning";
                     _loc27_.@label = _loc27_.@label + " = null";
                  }
                  _loc27_.appendChild(parse(_loc34_,_loc22_,param4 + 1,param5,param6).children());
                  _loc28_.appendChild(_loc27_);
               }
            }
            _loc31_++;
         }
         return _loc28_;
      }
      
      public static function parseFunctions(param1:*, param2:String = "") : XML
      {
         var _loc3_:* = null;
         var _loc24_:* = null;
         var _loc16_:* = null;
         var _loc23_:* = null;
         var _loc14_:int = 0;
         var _loc9_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc17_:* = null;
         var _loc13_:XML = <root/>;
         var _loc21_:XML = MonsterDebuggerDescribeType.get(param1);
         var _loc15_:String = parseType(_loc21_.@name);
         var _loc10_:String = "";
         var _loc7_:String = "";
         var _loc11_:String = "";
         var _loc8_:Object = {};
         var _loc4_:XMLList = _loc21_..method;
         var _loc19_:Array = [];
         var _loc20_:int = _loc4_.length();
         var _loc22_:Boolean = false;
         var _loc18_:int = 0;
         var _loc12_:int = 0;
         _loc3_ = <node/>;
         _loc3_.@icon = "iconDefault";
         _loc3_.@label = "(" + _loc15_ + ")";
         _loc3_.@target = param2;
         _loc18_ = 0;
         while(_loc18_ < _loc20_)
         {
            _loc24_ = _loc4_[_loc18_].@name;
            try
            {
               if(!_loc8_.hasOwnProperty(_loc24_))
               {
                  _loc8_[_loc24_] = _loc24_;
                  _loc19_[_loc19_.length] = {
                     "name":_loc24_,
                     "xml":_loc4_[_loc18_],
                     "access":"method"
                  };
               }
            }
            catch(e:Error)
            {
            }
            _loc18_++;
         }
         _loc19_.sortOn("name",1);
         _loc20_ = _loc19_.length;
         _loc18_ = 0;
         while(_loc18_ < _loc20_)
         {
            _loc10_ = "Function";
            _loc7_ = _loc19_[_loc18_].xml.@name;
            _loc11_ = param2 + "." + _loc7_;
            _loc16_ = parseType(_loc19_[_loc18_].xml.@returnType);
            _loc23_ = _loc19_[_loc18_].xml..parameter;
            _loc14_ = _loc23_.length();
            _loc9_ = [];
            _loc6_ = "";
            _loc22_ = false;
            _loc12_ = 0;
            while(_loc12_ < _loc14_)
            {
               if(_loc23_[_loc12_].@optional == "true" && !_loc22_)
               {
                  _loc22_ = true;
                  _loc9_[_loc9_.length] = "[";
               }
               _loc9_[_loc9_.length] = parseType(_loc23_[_loc12_].@type);
               _loc12_++;
            }
            if(_loc22_)
            {
               _loc9_[_loc9_.length] = "]";
            }
            _loc6_ = _loc9_.join(", ");
            _loc6_ = _loc6_.replace("[, ","[");
            _loc6_ = _loc6_.replace(", ]","]");
            _loc5_ = <node/>;
            _loc5_.@icon = "iconFunction";
            _loc5_.@type = "Function";
            _loc5_.@access = "method";
            _loc5_.@label = _loc7_ + "(" + _loc6_ + "):" + _loc16_;
            _loc5_.@name = _loc7_;
            _loc5_.@target = _loc11_;
            _loc5_.@args = _loc6_;
            _loc5_.@returnType = _loc16_;
            _loc12_ = 0;
            while(_loc12_ < _loc14_)
            {
               _loc17_ = <node/>;
               _loc17_.@type = parseType(_loc23_[_loc12_].@type);
               _loc17_.@index = _loc23_[_loc12_].@index;
               _loc17_.@optional = _loc23_[_loc12_].@optional;
               _loc5_.appendChild(_loc17_);
               _loc12_++;
            }
            _loc3_.appendChild(_loc5_);
            _loc18_++;
         }
         _loc13_.appendChild(_loc3_);
         return _loc13_;
      }
      
      public static function parseType(param1:String) : String
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.indexOf("::") != -1)
         {
            param1 = param1.substring(param1.indexOf("::") + 2,param1.length);
         }
         if(param1.indexOf("::") != -1)
         {
            _loc3_ = param1.substring(0,param1.indexOf("<") + 1);
            _loc2_ = param1.substring(param1.indexOf("::") + 2,param1.length);
            param1 = _loc3_ + _loc2_;
         }
         param1 = param1.replace("()","");
         param1 = param1.replace("MethodClosure","Function");
         return param1;
      }
      
      public static function isDisplayObject(param1:*) : Boolean
      {
         return param1 is flash.display.DisplayObject || param1 is flash.display.DisplayObjectContainer;
      }
      
      public static function isStarlingDisplayObject(param1:*) : Boolean
      {
         return param1 is starling.display.DisplayObject || param1 is starling.display.DisplayObjectContainer;
      }
      
      public static function printValue(param1:*, param2:String, param3:Boolean = false) : String
      {
         if(param2 == "ByteArray")
         {
            return param1["length"] + " bytes";
         }
         if(param1 == null)
         {
            return "null";
         }
         var _loc4_:String = String(param1);
         if(param3 && _loc4_.length > 140)
         {
            _loc4_ = _loc4_.substr(0,140) + "...";
         }
         return _loc4_;
      }
      
      public static function getObjectUnderPoint(param1:flash.display.DisplayObjectContainer, param2:Point) : flash.display.DisplayObject
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         if(param1.areInaccessibleObjectsUnderPoint(param2))
         {
            return param1;
         }
         _loc5_ = param1.getObjectsUnderPoint(param2);
         _loc5_.reverse();
         if(_loc5_ == null || _loc5_.length == 0)
         {
            return param1;
         }
         _loc4_ = _loc5_[0];
         _loc5_.length = 0;
         while(true)
         {
            _loc5_[_loc5_.length] = _loc4_;
            if(_loc4_.parent != null)
            {
               _loc4_ = _loc4_.parent;
               continue;
            }
            break;
         }
         _loc5_.reverse();
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc3_ = _loc5_[_loc6_];
            if(_loc3_ is flash.display.DisplayObjectContainer)
            {
               _loc4_ = _loc3_;
               if(flash.display.DisplayObjectContainer(_loc3_).mouseChildren)
               {
                  _loc6_++;
                  continue;
               }
               break;
            }
            break;
         }
         return _loc4_;
      }
      
      public static function getStarlingObjectUnderPoint(param1:starling.display.DisplayObjectContainer, param2:Point) : starling.display.DisplayObject
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = param1.hitTest(param2,false);
         if(_loc4_ == null || _loc4_ == param1)
         {
            return param1;
         }
         var _loc5_:Array = [];
         while(true)
         {
            _loc5_[_loc5_.length] = _loc4_;
            if(_loc4_.parent != null)
            {
               _loc4_ = _loc4_.parent;
               continue;
            }
            break;
         }
         _loc5_.reverse();
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc3_ = _loc5_[_loc6_];
            if(_loc3_ is starling.display.DisplayObjectContainer)
            {
               param1 = starling.display.DisplayObjectContainer(_loc3_);
               if(!param1.touchable || !param1.visible)
               {
                  if(param1.stage == param1)
                  {
                     return param1;
                  }
                  break;
               }
               _loc4_ = _loc3_;
               _loc6_++;
               continue;
            }
            break;
         }
         return _loc4_;
      }
   }
}
