package com.pickgliss.utils
{
   import flash.utils.Dictionary;
   
   public final class StringUtils
   {
      
      public static const BASE64:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
      
      private static var _reg:RegExp = /\{(\d+)\}/;
       
      
      public function StringUtils()
      {
         super();
      }
      
      public static function afterFirst(param1:String, param2:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc3_:int = param1.indexOf(param2);
         if(_loc3_ == -1)
         {
            return "";
         }
         _loc3_ = _loc3_ + param2.length;
         return param1.substr(_loc3_);
      }
      
      public static function afterLast(param1:String, param2:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc3_:int = param1.lastIndexOf(param2);
         if(_loc3_ == -1)
         {
            return "";
         }
         _loc3_ = _loc3_ + param2.length;
         return param1.substr(_loc3_);
      }
      
      public static function beginsWith(param1:String, param2:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return param1.indexOf(param2) == 0;
      }
      
      public static function beforeFirst(param1:String, param2:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc3_:int = param1.indexOf(param2);
         if(_loc3_ == -1)
         {
            return "";
         }
         return param1.substr(0,_loc3_);
      }
      
      public static function beforeLast(param1:String, param2:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc3_:int = param1.lastIndexOf(param2);
         if(_loc3_ == -1)
         {
            return "";
         }
         return param1.substr(0,_loc3_);
      }
      
      public static function between(param1:String, param2:String, param3:String) : String
      {
         var _loc4_:int = 0;
         var _loc5_:String = "";
         if(param1 == null)
         {
            return _loc5_;
         }
         var _loc6_:int = param1.indexOf(param2);
         if(_loc6_ != -1)
         {
            _loc6_ = _loc6_ + param2.length;
            _loc4_ = param1.indexOf(param3,_loc6_);
            if(_loc4_ != -1)
            {
               _loc5_ = param1.substr(_loc6_,_loc4_ - _loc6_);
            }
         }
         return _loc5_;
      }
      
      public static function block(param1:String, param2:uint, param3:String = ".") : Array
      {
         var _loc6_:* = null;
         var _loc5_:Array = [];
         if(param1 == null || !contains(param1,param3))
         {
            return _loc5_;
         }
         var _loc4_:uint = 0;
         var _loc7_:uint = param1.length;
         while(_loc4_ < _loc7_)
         {
            _loc6_ = param1.substr(_loc4_,param2);
            if(!contains(_loc6_,param3))
            {
               _loc5_.push(truncate(_loc6_,_loc6_.length));
               _loc4_ = _loc4_ + _loc6_.length;
            }
            _loc6_ = _loc6_.replace(new RegExp("[^" + param3 + "]+$"),"");
            _loc5_.push(_loc6_);
            _loc4_ = _loc4_ + _loc6_.length;
         }
         return _loc5_;
      }
      
      public static function capitalize(param1:String, ... rest) : String
      {
         var _loc3_:String = trimLeft(param1);
         if(rest[0] === true)
         {
            return _loc3_.replace(/^.|\s+(.)/,_upperCase);
         }
         return _loc3_.replace(/(^\w)/,_upperCase);
      }
      
      public static function ljust(param1:String, param2:uint, param3:String = " ") : String
      {
         var _loc4_:String = param3.substr(0,1);
         if(param1.length < param2)
         {
            return param1 + repeat(_loc4_,param2 - param1.length);
         }
         return param1;
      }
      
      public static function rjust(param1:String, param2:uint, param3:String = " ") : String
      {
         var _loc4_:String = param3.substr(0,1);
         if(param1.length < param2)
         {
            return repeat(_loc4_,param2 - param1.length) + param1;
         }
         return param1;
      }
      
      public static function center(param1:String, param2:uint, param3:String = " ") : String
      {
         var _loc7_:* = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:String = param3.substr(0,1);
         if(param1.length < param2)
         {
            _loc7_ = uint(param2 - param1.length);
            _loc6_ = _loc7_ % 2 == 0?"":_loc4_;
            _loc5_ = repeat(_loc4_,Math.round(_loc7_ / 2));
            return _loc5_ + param1 + _loc5_ + _loc6_;
         }
         return param1;
      }
      
      public static function repeat(param1:String, param2:uint = 1) : String
      {
         var _loc3_:String = "";
         while(param2--)
         {
            _loc3_ = _loc3_ + param1;
         }
         return _loc3_;
      }
      
      public static function base64Encode(param1:String) : String
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc7_:String = "";
         var _loc6_:uint = 0;
         var _loc5_:uint = param1.length;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.charCodeAt(_loc6_++) & 255;
            if(_loc6_ == _loc5_)
            {
               _loc7_ = _loc7_ + ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(_loc2_ >> 2) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt((_loc2_ & 3) << 4) + "==");
               break;
            }
            _loc3_ = param1.charCodeAt(_loc6_++);
            if(_loc6_ == _loc5_)
            {
               _loc7_ = _loc7_ + ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(_loc2_ >> 2) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt((_loc2_ & 3) << 4 | (_loc3_ & 240) >> 4) + "=");
               break;
            }
            _loc4_ = param1.charCodeAt(_loc6_++);
            _loc7_ = _loc7_ + ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(_loc2_ >> 2) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt((_loc2_ & 3) << 4 | (_loc3_ & 240) >> 4) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt((_loc3_ & 15) << 2 | (_loc4_ & 192) >> 6) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(_loc4_ & 63));
         }
         return _loc7_;
      }
      
      public static function contains(param1:String, param2:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return param1.indexOf(param2) != -1;
      }
      
      public static function countOf(param1:String, param2:String, param3:Boolean = true) : uint
      {
         if(param1 == null)
         {
            return 0;
         }
         var _loc5_:String = escapePattern(param2);
         var _loc4_:String = !param3?"ig":"g";
         return param1.match(new RegExp(_loc5_,_loc4_)).length;
      }
      
      public static function editDistance(param1:String, param2:String) : uint
      {
         var _loc11_:* = 0;
         var _loc6_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc13_:* = 0;
         var _loc8_:* = null;
         var _loc10_:* = 0;
         var _loc12_:* = null;
         if(param1 == null)
         {
            param1 = "";
         }
         if(param2 == null)
         {
            param2 = "";
         }
         if(param1 == param2)
         {
            return 0;
         }
         var _loc3_:Array = [];
         var _loc7_:uint = param1.length;
         var _loc9_:uint = param2.length;
         if(_loc7_ == 0)
         {
            return _loc9_;
         }
         if(_loc9_ == 0)
         {
            return _loc7_;
         }
         _loc6_ = uint(0);
         while(_loc6_ <= _loc7_)
         {
            _loc3_[_loc6_] = [];
            _loc6_++;
         }
         _loc4_ = uint(0);
         while(_loc4_ <= _loc7_)
         {
            _loc3_[_loc4_][0] = _loc4_;
            _loc4_++;
         }
         _loc5_ = uint(0);
         while(_loc5_ <= _loc9_)
         {
            _loc3_[0][_loc5_] = _loc5_;
            _loc5_++;
         }
         _loc13_ = uint(1);
         while(_loc13_ <= _loc7_)
         {
            _loc8_ = param1.charAt(_loc13_ - 1);
            _loc10_ = uint(1);
            while(_loc10_ <= _loc9_)
            {
               _loc12_ = param2.charAt(_loc10_ - 1);
               if(_loc8_ == _loc12_)
               {
                  _loc11_ = uint(0);
               }
               else
               {
                  _loc11_ = uint(1);
               }
               _loc3_[_loc13_][_loc10_] = Math.min(_loc3_[_loc13_ - 1][_loc10_] + 1,_loc3_[_loc13_][_loc10_ - 1] + 1,_loc3_[_loc13_ - 1][_loc10_ - 1] + _loc11_);
               _loc10_++;
            }
            _loc13_++;
         }
         return _loc3_[_loc7_][_loc9_];
      }
      
      public static function endsWith(param1:String, param2:String) : Boolean
      {
         return new RegExp(param2 + "$").test(param1);
      }
      
      public static function hasText(param1:String) : Boolean
      {
         var _loc2_:String = removeExtraWhitespace(param1);
         return !!_loc2_.length;
      }
      
      public static function isEmpty(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return true;
         }
         return !param1.length;
      }
      
      public static function isNumeric(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:RegExp = /^[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?$/;
         return _loc2_.test(param1);
      }
      
      public static function padLeft(param1:String, param2:String, param3:uint) : String
      {
         var _loc4_:* = param1;
         while(_loc4_.length < param3)
         {
            _loc4_ = param2 + _loc4_;
         }
         return _loc4_;
      }
      
      public static function padRight(param1:String, param2:String, param3:uint) : String
      {
         var _loc4_:* = param1;
         while(_loc4_.length < param3)
         {
            _loc4_ = _loc4_ + param2;
         }
         return _loc4_;
      }
      
      public static function properCase(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc2_:String = param1.toLowerCase().replace(/\b([^.?;!]+)/,capitalize);
         return _loc2_.replace(/\b[i]\b/,"I");
      }
      
      public static function quote(param1:String) : String
      {
         var _loc2_:RegExp = /[\\"\r\n]/g;
         return "\"" + param1.replace(_loc2_,_quote) + "\"";
      }
      
      public static function relativePath(param1:String, param2:String, param3:String = "/") : String
      {
         var _loc11_:* = 0;
         var _loc5_:* = param1;
         if(endsWith(param1,"/"))
         {
            _loc5_ = StringUtils.beforeLast(param1,"/");
         }
         var _loc10_:* = param2;
         if(endsWith(param2,"/"))
         {
            _loc10_ = StringUtils.beforeLast(param2,"/");
         }
         var _loc6_:Array = _loc5_.split(param3);
         var _loc9_:Array = _loc10_.split(param3);
         var _loc8_:int = Math.min(_loc6_.length,_loc9_.length);
         var _loc4_:int = 0;
         _loc11_ = 0;
         while(_loc11_ < _loc8_)
         {
            if(_loc6_[_loc11_].toLowerCase() === _loc9_[_loc11_].toLowerCase())
            {
               _loc4_++;
               _loc11_++;
               continue;
            }
            break;
         }
         if(_loc4_ == 0)
         {
            return param2;
         }
         var _loc7_:String = "";
         _loc8_ = _loc6_.length;
         _loc11_ = _loc4_;
         while(_loc11_ < _loc8_)
         {
            if(_loc11_ > _loc4_)
            {
               _loc7_ = _loc7_ + param3;
            }
            _loc7_ = _loc7_ + "..";
            _loc11_++;
         }
         if(_loc7_.length == 0)
         {
            _loc7_ = ".";
         }
         _loc8_ = _loc9_.length;
         _loc11_ = _loc4_;
         while(_loc11_ < _loc8_)
         {
            _loc7_ = _loc7_ + param3;
            _loc7_ = _loc7_ + _loc9_[_loc11_];
            _loc11_++;
         }
         return _loc7_;
      }
      
      public static function remove(param1:String, param2:String, param3:Boolean = true) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc5_:String = escapePattern(param2);
         var _loc4_:String = !param3?"ig":"g";
         return param1.replace(new RegExp(_loc5_,_loc4_),"");
      }
      
      public static function removeExtraWhitespace(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc2_:String = trim(param1);
         return _loc2_.replace(/\s+/g," ");
      }
      
      public static function reverse(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return param1.split("").reverse().join("");
      }
      
      public static function reverseWords(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return param1.split(/\s+/).reverse().join("");
      }
      
      public static function similarity(param1:String, param2:String) : Number
      {
         var _loc4_:uint = editDistance(param1,param2);
         var _loc3_:uint = Math.max(param1.length,param2.length);
         if(_loc3_ == 0)
         {
            return 1;
         }
         return 1 - _loc4_ / _loc3_;
      }
      
      public static function stripTags(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return param1.replace(/<\/?[^>]+>/gim,"");
      }
      
      public static function supplant(param1:String, ... rest) : String
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:* = param1;
         if(rest[0] is Object)
         {
            var _loc8_:int = 0;
            var _loc7_:* = rest[0];
            for(var _loc4_ in rest[0])
            {
               _loc3_ = _loc3_.replace(new RegExp("\\{" + _loc4_ + "\\}","g"),rest[0][_loc4_]);
            }
         }
         else
         {
            _loc5_ = rest.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc3_ = _loc3_.replace(new RegExp("\\{" + _loc6_ + "\\}","g"),rest[_loc6_]);
               _loc6_++;
            }
         }
         return _loc3_;
      }
      
      public static function swapCase(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return param1.replace(/(\w)/,_swapCase);
      }
      
      public static function trim(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return param1.replace(/^\s+|\s+$/g,"");
      }
      
      public static function trimLeft(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return param1.replace(/^\s+/,"");
      }
      
      public static function trimRight(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return param1.replace(/\s+$/,"");
      }
      
      public static function truncate(param1:String, param2:uint, param3:String = "...") : String
      {
         if(param1 == null)
         {
            return "";
         }
         if(param2 == 0)
         {
            param2 = param1.length;
         }
         param2 = param2 - param3.length;
         var _loc4_:* = param1;
         if(_loc4_.length > param2)
         {
            _loc4_ = _loc4_.substr(0,param2);
            if(/[^\s]/.test(param1.charAt(param2)))
            {
               _loc4_ = trimRight(_loc4_.replace(/\w+$|\s+$/,""));
            }
            _loc4_ = _loc4_ + param3;
         }
         return _loc4_;
      }
      
      public static function wordCount(param1:String) : uint
      {
         if(param1 == null)
         {
            return 0;
         }
         return param1.match(/\b\w+\b/g).length;
      }
      
      private static function escapePattern(param1:String) : String
      {
         return param1.replace(/(\]|\[|\{|\}|\(|\)|\*|\+|\?|\.|\\)/g,"\\$1");
      }
      
      private static function _quote(param1:String, ... rest) : String
      {
         var _loc3_:* = param1;
         if("\\" !== _loc3_)
         {
            if("\r" !== _loc3_)
            {
               if("\n" !== _loc3_)
               {
                  if("\"" !== _loc3_)
                  {
                     return null;
                  }
                  return "\\\"";
               }
               return "\\n";
            }
            return "\\r";
         }
         return "\\\\";
      }
      
      private static function _upperCase(param1:String, ... rest) : String
      {
         return param1.toUpperCase();
      }
      
      private static function _swapCase(param1:String, ... rest) : String
      {
         var _loc4_:String = param1.toLowerCase();
         var _loc3_:String = param1.toUpperCase();
         var _loc5_:* = param1;
         if(_loc4_ !== _loc5_)
         {
            if(_loc3_ !== _loc5_)
            {
               return param1;
            }
            return _loc4_;
         }
         return _loc3_;
      }
      
      public static function converBoolean(param1:String) : Boolean
      {
         if(param1.toLowerCase() == "true")
         {
            return true;
         }
         return false;
      }
      
      public static function dictionaryKeyToString(param1:Dictionary) : String
      {
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(var _loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_.join(",");
      }
      
      public static function trimHtmlText(param1:String) : String
      {
         return null;
      }
      
      public static function replaceValueByIndex(param1:String, ... rest) : String
      {
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc6_:Object = _reg.exec(param1);
         while(_loc6_ && rest.length > 0)
         {
            _loc3_ = _loc6_[1];
            _loc5_ = String(rest[_loc3_]);
            if(_loc3_ >= 0 && _loc3_ < rest.length)
            {
               _loc4_ = _loc5_.indexOf("$");
               if(_loc4_ > -1)
               {
                  _loc5_ = _loc5_.slice(0,_loc4_) + "$" + _loc5_.slice(_loc4_);
               }
               param1 = param1.replace(_reg,_loc5_);
            }
            else
            {
               param1 = param1.replace(_reg,"{}");
            }
            _loc6_ = _reg.exec(param1);
         }
         return param1;
      }
      
      public static function getTimeTick() : String
      {
         var _loc1_:Date = new Date();
         return _loc1_.time.toString();
      }
      
      public static function getSuffixStr(param1:String) : String
      {
         return param1.substring(param1.lastIndexOf(".") + 1,param1.length);
      }
   }
}
