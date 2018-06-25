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
      
      public static function afterFirst(p_string:String, p_char:String) : String
      {
         if(p_string == null)
         {
            return "";
         }
         var idx:int = p_string.indexOf(p_char);
         if(idx == -1)
         {
            return "";
         }
         idx = idx + p_char.length;
         return p_string.substr(idx);
      }
      
      public static function afterLast(p_string:String, p_char:String) : String
      {
         if(p_string == null)
         {
            return "";
         }
         var idx:int = p_string.lastIndexOf(p_char);
         if(idx == -1)
         {
            return "";
         }
         idx = idx + p_char.length;
         return p_string.substr(idx);
      }
      
      public static function beginsWith(p_string:String, p_begin:String) : Boolean
      {
         if(p_string == null)
         {
            return false;
         }
         return p_string.indexOf(p_begin) == 0;
      }
      
      public static function beforeFirst(p_string:String, p_char:String) : String
      {
         if(p_string == null)
         {
            return "";
         }
         var idx:int = p_string.indexOf(p_char);
         if(idx == -1)
         {
            return "";
         }
         return p_string.substr(0,idx);
      }
      
      public static function beforeLast(p_string:String, p_char:String) : String
      {
         if(p_string == null)
         {
            return "";
         }
         var idx:int = p_string.lastIndexOf(p_char);
         if(idx == -1)
         {
            return "";
         }
         return p_string.substr(0,idx);
      }
      
      public static function between(p_string:String, p_start:String, p_end:String) : String
      {
         var endIdx:int = 0;
         var str:String = "";
         if(p_string == null)
         {
            return str;
         }
         var startIdx:int = p_string.indexOf(p_start);
         if(startIdx != -1)
         {
            startIdx = startIdx + p_start.length;
            endIdx = p_string.indexOf(p_end,startIdx);
            if(endIdx != -1)
            {
               str = p_string.substr(startIdx,endIdx - startIdx);
            }
         }
         return str;
      }
      
      public static function block(p_string:String, p_len:uint, p_delim:String = ".") : Array
      {
         var subString:* = null;
         var arr:Array = [];
         if(p_string == null || !contains(p_string,p_delim))
         {
            return arr;
         }
         var chrIndex:uint = 0;
         var strLen:uint = p_string.length;
         while(chrIndex < strLen)
         {
            subString = p_string.substr(chrIndex,p_len);
            if(!contains(subString,p_delim))
            {
               arr.push(truncate(subString,subString.length));
               chrIndex = chrIndex + subString.length;
            }
            subString = subString.replace(new RegExp("[^" + p_delim + "]+$"),"");
            arr.push(subString);
            chrIndex = chrIndex + subString.length;
         }
         return arr;
      }
      
      public static function capitalize(p_string:String, ... args) : String
      {
         var str:String = trimLeft(p_string);
         if(args[0] === true)
         {
            return str.replace(/^.|\s+(.)/,_upperCase);
         }
         return str.replace(/(^\w)/,_upperCase);
      }
      
      public static function ljust(p_string:String, p_width:uint, p_pad:String = " ") : String
      {
         var pad:String = p_pad.substr(0,1);
         if(p_string.length < p_width)
         {
            return p_string + repeat(pad,p_width - p_string.length);
         }
         return p_string;
      }
      
      public static function rjust(p_string:String, p_width:uint, p_pad:String = " ") : String
      {
         var pad:String = p_pad.substr(0,1);
         if(p_string.length < p_width)
         {
            return repeat(pad,p_width - p_string.length) + p_string;
         }
         return p_string;
      }
      
      public static function center(p_string:String, p_width:uint, p_pad:String = " ") : String
      {
         var len:* = 0;
         var rem:* = null;
         var pads:* = null;
         var pad:String = p_pad.substr(0,1);
         if(p_string.length < p_width)
         {
            len = uint(p_width - p_string.length);
            rem = len % 2 == 0?"":pad;
            pads = repeat(pad,Math.round(len / 2));
            return pads + p_string + pads + rem;
         }
         return p_string;
      }
      
      public static function repeat(p_string:String, p_count:uint = 1) : String
      {
         var s:String = "";
         while(p_count--)
         {
            s = s + p_string;
         }
         return s;
      }
      
      public static function base64Encode(p_string:String) : String
      {
         var c1:Number = NaN;
         var c2:Number = NaN;
         var c3:Number = NaN;
         var out:String = "";
         var i:uint = 0;
         var len:uint = p_string.length;
         while(i < len)
         {
            c1 = p_string.charCodeAt(i++) & 255;
            if(i == len)
            {
               out = out + ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(c1 >> 2) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt((c1 & 3) << 4) + "==");
               break;
            }
            c2 = p_string.charCodeAt(i++);
            if(i == len)
            {
               out = out + ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(c1 >> 2) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt((c1 & 3) << 4 | (c2 & 240) >> 4) + "=");
               break;
            }
            c3 = p_string.charCodeAt(i++);
            out = out + ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(c1 >> 2) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt((c1 & 3) << 4 | (c2 & 240) >> 4) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt((c2 & 15) << 2 | (c3 & 192) >> 6) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(c3 & 63));
         }
         return out;
      }
      
      public static function contains(p_string:String, p_char:String) : Boolean
      {
         if(p_string == null)
         {
            return false;
         }
         return p_string.indexOf(p_char) != -1;
      }
      
      public static function countOf(p_string:String, p_char:String, p_caseSensitive:Boolean = true) : uint
      {
         if(p_string == null)
         {
            return 0;
         }
         var char:String = escapePattern(p_char);
         var flags:String = !p_caseSensitive?"ig":"g";
         return p_string.match(new RegExp(char,flags)).length;
      }
      
      public static function editDistance(p_source:String, p_target:String) : uint
      {
         var cost:* = 0;
         var a:* = 0;
         var b:* = 0;
         var c:* = 0;
         var i:* = 0;
         var s_i:* = null;
         var j:* = 0;
         var t_j:* = null;
         if(p_source == null)
         {
            p_source = "";
         }
         if(p_target == null)
         {
            p_target = "";
         }
         if(p_source == p_target)
         {
            return 0;
         }
         var d:Array = [];
         var n:uint = p_source.length;
         var m:uint = p_target.length;
         if(n == 0)
         {
            return m;
         }
         if(m == 0)
         {
            return n;
         }
         for(a = uint(0); a <= n; d[a] = [],a++)
         {
         }
         for(b = uint(0); b <= n; d[b][0] = b,b++)
         {
         }
         for(c = uint(0); c <= m; d[0][c] = c,c++)
         {
         }
         for(i = uint(1); i <= n; )
         {
            s_i = p_source.charAt(i - 1);
            for(j = uint(1); j <= m; )
            {
               t_j = p_target.charAt(j - 1);
               if(s_i == t_j)
               {
                  cost = uint(0);
               }
               else
               {
                  cost = uint(1);
               }
               d[i][j] = Math.min(d[i - 1][j] + 1,d[i][j - 1] + 1,d[i - 1][j - 1] + cost);
               j++;
            }
            i++;
         }
         return d[n][m];
      }
      
      public static function endsWith(p_string:String, p_end:String) : Boolean
      {
         return new RegExp(p_end + "$").test(p_string);
      }
      
      public static function hasText(p_string:String) : Boolean
      {
         var str:String = removeExtraWhitespace(p_string);
         return !!str.length;
      }
      
      public static function isEmpty(p_string:String) : Boolean
      {
         if(p_string == null)
         {
            return true;
         }
         return !p_string.length;
      }
      
      public static function isNumeric(p_string:String) : Boolean
      {
         if(p_string == null)
         {
            return false;
         }
         var regx:RegExp = /^[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?$/;
         return regx.test(p_string);
      }
      
      public static function padLeft(p_string:String, p_padChar:String, p_length:uint) : String
      {
         var s:* = p_string;
         while(s.length < p_length)
         {
            s = p_padChar + s;
         }
         return s;
      }
      
      public static function padRight(p_string:String, p_padChar:String, p_length:uint) : String
      {
         var s:* = p_string;
         while(s.length < p_length)
         {
            s = s + p_padChar;
         }
         return s;
      }
      
      public static function properCase(p_string:String) : String
      {
         if(p_string == null)
         {
            return "";
         }
         var str:String = p_string.toLowerCase().replace(/\b([^.?;!]+)/,capitalize);
         return str.replace(/\b[i]\b/,"I");
      }
      
      public static function quote(p_string:String) : String
      {
         var regx:RegExp = /[\\"\r\n]/g;
         return "\"" + p_string.replace(regx,_quote) + "\"";
      }
      
      public static function relativePath(p_base:String, p_path:String, p_delim:String = "/") : String
      {
         var i:* = 0;
         var baseUri:* = p_base;
         if(endsWith(p_base,"/"))
         {
            baseUri = StringUtils.beforeLast(p_base,"/");
         }
         var pathUri:* = p_path;
         if(endsWith(p_path,"/"))
         {
            pathUri = StringUtils.beforeLast(p_path,"/");
         }
         var baseParts:Array = baseUri.split(p_delim);
         var pathParts:Array = pathUri.split(p_delim);
         var l:int = Math.min(baseParts.length,pathParts.length);
         var sameCounter:int = 0;
         for(i = 0; i < l; )
         {
            if(baseParts[i].toLowerCase() !== pathParts[i].toLowerCase())
            {
               break;
            }
            sameCounter++;
            i++;
         }
         if(sameCounter == 0)
         {
            return p_path;
         }
         var newPath:String = "";
         l = baseParts.length;
         for(i = sameCounter; i < l; )
         {
            if(i > sameCounter)
            {
               newPath = newPath + p_delim;
            }
            newPath = newPath + "..";
            i++;
         }
         if(newPath.length == 0)
         {
            newPath = ".";
         }
         l = pathParts.length;
         for(i = sameCounter; i < l; )
         {
            newPath = newPath + p_delim;
            newPath = newPath + pathParts[i];
            i++;
         }
         return newPath;
      }
      
      public static function remove(p_string:String, p_remove:String, p_caseSensitive:Boolean = true) : String
      {
         if(p_string == null)
         {
            return "";
         }
         var rem:String = escapePattern(p_remove);
         var flags:String = !p_caseSensitive?"ig":"g";
         return p_string.replace(new RegExp(rem,flags),"");
      }
      
      public static function removeExtraWhitespace(p_string:String) : String
      {
         if(p_string == null)
         {
            return "";
         }
         var str:String = trim(p_string);
         return str.replace(/\s+/g," ");
      }
      
      public static function reverse(p_string:String) : String
      {
         if(p_string == null)
         {
            return "";
         }
         return p_string.split("").reverse().join("");
      }
      
      public static function reverseWords(p_string:String) : String
      {
         if(p_string == null)
         {
            return "";
         }
         return p_string.split(/\s+/).reverse().join("");
      }
      
      public static function similarity(p_source:String, p_target:String) : Number
      {
         var ed:uint = editDistance(p_source,p_target);
         var maxLen:uint = Math.max(p_source.length,p_target.length);
         if(maxLen == 0)
         {
            return 1;
         }
         return 1 - ed / maxLen;
      }
      
      public static function stripTags(p_string:String) : String
      {
         if(p_string == null)
         {
            return "";
         }
         return p_string.replace(/<\/?[^>]+>/gim,"");
      }
      
      public static function supplant(p_string:String, ... args) : String
      {
         var l:int = 0;
         var i:int = 0;
         var str:* = p_string;
         if(args[0] is Object)
         {
            var _loc8_:int = 0;
            var _loc7_:* = args[0];
            for(var n in args[0])
            {
               str = str.replace(new RegExp("\\{" + n + "\\}","g"),args[0][n]);
            }
         }
         else
         {
            l = args.length;
            for(i = 0; i < l; )
            {
               str = str.replace(new RegExp("\\{" + i + "\\}","g"),args[i]);
               i++;
            }
         }
         return str;
      }
      
      public static function swapCase(p_string:String) : String
      {
         if(p_string == null)
         {
            return "";
         }
         return p_string.replace(/(\w)/,_swapCase);
      }
      
      public static function trim(p_string:String) : String
      {
         if(p_string == null)
         {
            return "";
         }
         return p_string.replace(/^\s+|\s+$/g,"");
      }
      
      public static function trimLeft(p_string:String) : String
      {
         if(p_string == null)
         {
            return "";
         }
         return p_string.replace(/^\s+/,"");
      }
      
      public static function trimRight(p_string:String) : String
      {
         if(p_string == null)
         {
            return "";
         }
         return p_string.replace(/\s+$/,"");
      }
      
      public static function truncate(p_string:String, p_len:uint, p_suffix:String = "...") : String
      {
         if(p_string == null)
         {
            return "";
         }
         if(p_len == 0)
         {
            p_len = p_string.length;
         }
         p_len = p_len - p_suffix.length;
         var trunc:* = p_string;
         if(trunc.length > p_len)
         {
            trunc = trunc.substr(0,p_len);
            if(/[^\s]/.test(p_string.charAt(p_len)))
            {
               trunc = trimRight(trunc.replace(/\w+$|\s+$/,""));
            }
            trunc = trunc + p_suffix;
         }
         return trunc;
      }
      
      public static function wordCount(p_string:String) : uint
      {
         if(p_string == null)
         {
            return 0;
         }
         return p_string.match(/\b\w+\b/g).length;
      }
      
      private static function escapePattern(p_pattern:String) : String
      {
         return p_pattern.replace(/(\]|\[|\{|\}|\(|\)|\*|\+|\?|\.|\\)/g,"\\$1");
      }
      
      private static function _quote(p_string:String, ... args) : String
      {
         var _loc3_:* = p_string;
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
      
      private static function _upperCase(p_char:String, ... args) : String
      {
         return p_char.toUpperCase();
      }
      
      private static function _swapCase(p_char:String, ... args) : String
      {
         var lowChar:String = p_char.toLowerCase();
         var upChar:String = p_char.toUpperCase();
         var _loc5_:* = p_char;
         if(lowChar !== _loc5_)
         {
            if(upChar !== _loc5_)
            {
               return p_char;
            }
            return lowChar;
         }
         return upChar;
      }
      
      public static function converBoolean(value:String) : Boolean
      {
         if(value.toLowerCase() == "true")
         {
            return true;
         }
         return false;
      }
      
      public static function dictionaryKeyToString(dic:Dictionary) : String
      {
         var result:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = dic;
         for(var key in dic)
         {
            result.push(key);
         }
         return result.join(",");
      }
      
      public static function trimHtmlText(value:String) : String
      {
         return null;
      }
      
      public static function replaceValueByIndex(input:String, ... args) : String
      {
         var id:int = 0;
         var str:* = null;
         var idx:int = 0;
         var obj:Object = _reg.exec(input);
         while(obj && args.length > 0)
         {
            id = obj[1];
            str = String(args[id]);
            if(id >= 0 && id < args.length)
            {
               idx = str.indexOf("$");
               if(idx > -1)
               {
                  str = str.slice(0,idx) + "$" + str.slice(idx);
               }
               input = input.replace(_reg,str);
            }
            else
            {
               input = input.replace(_reg,"{}");
            }
            obj = _reg.exec(input);
         }
         return input;
      }
      
      public static function getTimeTick() : String
      {
         var date:Date = new Date();
         return date.time.toString();
      }
      
      public static function getSuffixStr(value:String) : String
      {
         return value.substring(value.lastIndexOf(".") + 1,value.length);
      }
   }
}
