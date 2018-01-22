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
      
      public static function cloneSimpleObject(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function copyPorpertiesByXML(param1:Object, param2:XML) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc6_:XMLList = param2.attributes();
         var _loc10_:int = 0;
         var _loc9_:* = _loc6_;
         for each(var _loc4_ in _loc6_)
         {
            _loc3_ = _loc4_.name().toString();
            if(param1.hasOwnProperty(_loc3_))
            {
               try
               {
                  _loc5_ = _loc4_.toString();
                  if(_loc5_ == "false")
                  {
                     param1[_loc3_] = false;
                  }
                  else
                  {
                     param1[_loc3_] = _loc5_;
                  }
               }
               catch(e:Error)
               {
                  trace("-----类ObjectUtils报错:",e.message + "\n-----",_loc3_,_loc5_);
                  continue;
               }
            }
         }
      }
      
      public static function copyProperties(param1:Object, param2:Object) : void
      {
         var _loc10_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         if(_descriptOjbXMLs == null)
         {
            _descriptOjbXMLs = new Dictionary();
         }
         var _loc8_:Vector.<String> = getCopyAbleType();
         var _loc11_:XML = describeTypeSave(param2);
         _loc10_ = _loc11_.variable;
         var _loc13_:int = 0;
         var _loc12_:* = _loc10_;
         for each(var _loc9_ in _loc10_)
         {
            _loc6_ = _loc9_.@type;
            if(_loc8_.indexOf(_loc6_) != -1)
            {
               _loc3_ = _loc9_.@name;
               if(param1.hasOwnProperty(_loc3_))
               {
                  param1[_loc3_] = param2[_loc3_];
               }
            }
         }
         _loc10_ = _loc11_.accessor;
         var _loc15_:int = 0;
         var _loc14_:* = _loc10_;
         for each(var _loc5_ in _loc10_)
         {
            _loc7_ = _loc5_.@type;
            if(_loc8_.indexOf(_loc7_) != -1)
            {
               _loc4_ = _loc5_.@name;
               try
               {
                  param1[_loc4_] = param2[_loc4_];
               }
               catch(err:Error)
               {
                  continue;
               }
            }
         }
      }
      
      public static function disposeAllChildren(param1:DisplayObjectContainer) : void
      {
         var _loc2_:* = null;
         if(param1 == null)
         {
            return;
         }
         while(param1.numChildren > 0)
         {
            _loc2_ = param1.getChildAt(0);
            ObjectUtils.disposeObject(_loc2_);
         }
      }
      
      public static function removeChildAllChildren(param1:DisplayObjectContainer) : void
      {
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
      }
      
      public static function disposeObject(param1:Object) : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(param1 == null)
         {
            return;
         }
         if(param1 is Disposeable)
         {
            if(param1 is DisplayObject)
            {
               _loc5_ = param1 as DisplayObject;
               if(_loc5_.parent)
               {
                  _loc5_.parent.removeChild(_loc5_);
               }
            }
            Disposeable(param1).dispose();
         }
         else if(param1 is Bitmap)
         {
            _loc3_ = Bitmap(param1);
            if(_loc3_.parent)
            {
               _loc3_.parent.removeChild(_loc3_);
            }
            if(_loc3_.bitmapData)
            {
               _loc3_.bitmapData.dispose();
            }
         }
         else if(param1 is BitmapData)
         {
            _loc2_ = BitmapData(param1);
            _loc2_.dispose();
         }
         else if(param1 is DisplayObject)
         {
            _loc4_ = DisplayObject(param1);
            if(_loc4_.parent)
            {
               _loc4_.parent.removeChild(_loc4_);
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
      
      public static function describeTypeSave(param1:Object) : XML
      {
         var _loc2_:* = null;
         var _loc3_:String = getQualifiedClassName(param1);
         if(_descriptOjbXMLs[_loc3_] != null)
         {
            _loc2_ = _descriptOjbXMLs[_loc3_];
         }
         else
         {
            _loc2_ = describeType(param1);
            _descriptOjbXMLs[_loc3_] = _loc2_;
         }
         return _loc2_;
      }
      
      public static function encode(param1:String, param2:Object) : XML
      {
         var _loc5_:* = null;
         var _loc6_:String = "<" + param1 + " ";
         var _loc4_:XML = describeTypeSave(param2);
         if(_loc4_.@name.toString() == "Object")
         {
            var _loc9_:int = 0;
            var _loc8_:* = param2;
            for(var _loc7_ in param2)
            {
               _loc5_ = param2[_loc7_];
               if(!(_loc5_ is Function))
               {
                  _loc6_ = _loc6_ + encodingProperty(_loc7_,_loc5_);
               }
            }
         }
         else
         {
            var _loc13_:int = 0;
            var _loc10_:* = _loc4_..*;
            var _loc11_:int = 0;
            _loc8_ = new XMLList("");
            var _loc12_:* = _loc4_..*.(name() == "variable" || name() == "accessor");
            for each(var _loc3_ in _loc4_..*.(name() == "variable" || name() == "accessor"))
            {
               _loc6_ = _loc6_ + encodingProperty(_loc3_.@name.toString(),param2[_loc3_.@name]);
            }
         }
         _loc6_ = _loc6_ + "/>";
         return new XML(_loc6_);
      }
      
      private static function encodingProperty(param1:String, param2:Object) : String
      {
         if(param2 is Array)
         {
            return "";
         }
         return escapeString(param1) + "=\"" + String(param2) + "\" ";
      }
      
      private static function escapeString(param1:String) : String
      {
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc2_:String = "";
         var _loc4_:Number = param1.length;
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc5_ = param1.charAt(_loc7_);
            var _loc8_:* = _loc5_;
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
                                    if(_loc5_ < " ")
                                    {
                                       _loc3_ = _loc5_.charCodeAt(0).toString(16);
                                       _loc6_ = _loc3_.length == 2?"00":"000";
                                       _loc2_ = _loc2_ + ("\\u" + _loc6_ + _loc3_);
                                    }
                                    else
                                    {
                                       _loc2_ = _loc2_ + _loc5_;
                                    }
                                 }
                                 else
                                 {
                                    _loc2_ = _loc2_ + "\\t";
                                 }
                              }
                              else
                              {
                                 _loc2_ = _loc2_ + "\\r";
                              }
                           }
                           else
                           {
                              _loc2_ = _loc2_ + "\\n";
                           }
                        }
                        else
                        {
                           _loc2_ = _loc2_ + "\\f";
                        }
                     }
                     else
                     {
                        _loc2_ = _loc2_ + "\\b";
                     }
                  }
                  else
                  {
                     _loc2_ = _loc2_ + "\\\\";
                  }
               }
               else
               {
                  _loc2_ = _loc2_ + "\\/";
               }
            }
            else
            {
               _loc2_ = _loc2_ + "\\\"";
            }
            _loc7_++;
         }
         return _loc2_;
      }
      
      public static function modifyVisibility(param1:Boolean, ... rest) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < rest.length)
         {
            (rest[_loc3_] as DisplayObject).visible = param1;
            _loc3_++;
         }
      }
      
      public static function copyPropertyByRectangle(param1:DisplayObject, param2:Rectangle) : void
      {
         param1.x = param2.x;
         param1.y = param2.y;
         if(param2.width != 0)
         {
            param1.width = param2.width;
         }
         if(param2.height != 0)
         {
            param1.height = param2.height;
         }
      }
      
      public static function combineXML(param1:XML, param2:XML) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         if(param2 == null || param1 == null)
         {
            return;
            §§push(trace("警告！！！！  combineXML 出现问题  请马上解决"));
         }
         else
         {
            var _loc6_:XMLList = param2.attributes();
            var _loc8_:int = 0;
            var _loc7_:* = _loc6_;
            for each(var _loc4_ in _loc6_)
            {
               _loc3_ = _loc4_.name().toString();
               _loc5_ = _loc4_.toString();
               if(!param1.hasOwnProperty("@" + _loc3_))
               {
                  param1["@" + _loc3_] = _loc5_;
               }
            }
            return;
         }
      }
      
      public static function getDisplayObjectSuperParent(param1:*, param2:Class, param3:*) : *
      {
         while(param1 != null && param1 != param3)
         {
            if(param1 is param2)
            {
               return param1;
            }
            param1 = param1.parent;
         }
         return null;
      }
      
      public static function getDisplayObjectSuperParentByName(param1:*, param2:String, param3:*) : *
      {
         while(param1 != null && param1 != param3)
         {
            if(getQualifiedClassName(param1) == param2)
            {
               return param1;
            }
            param1 = param1.parent;
         }
         return null;
      }
   }
}
