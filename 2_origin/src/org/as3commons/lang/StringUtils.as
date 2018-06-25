package org.as3commons.lang
{
   public final class StringUtils
   {
      
      private static var WIN_BREAK:String = String.fromCharCode(13) + String.fromCharCode(10);
      
      private static var MAC_BREAK:String = String.fromCharCode(13);
      
      public static var DEFAULT_ESCAPE_MAP:Array = ["\\t","\t","\\n","\n","\\r","\r","\\\"","\"","\\\\","\\","\\\'","\'","\\f","\f","\\b","\b","\\",""];
      
      private static var PROPERTIES_ESCAPE_MAP:Array = ["\\t","\t","\\n","\n","\\r","\r","\\\"","\"","\\\\","\\","\\\'","\'","\\f","\f"];
      
      private static const EMPTY:String = "";
      
      private static const INDEX_NOT_FOUND:int = -1;
      
      private static const PAD_LIMIT:uint = 8192;
      
      private static const FILENAME_CHARS_NOT_ALLOWED:RegExp = //|\\|:|\*|\?|<|>|\||%|"/;
       
      
      public function StringUtils()
      {
         super();
      }
      
      public static function toInitials(str:String) : String
      {
         if(isEmpty(str))
         {
            return str;
         }
         return str.match(/[A-Z]/g).join("").toLowerCase();
      }
      
      public static function chomp(str:String) : String
      {
         return chompString(str,"(\r\n|\r|\n)");
      }
      
      public static function chompString(str:String, separator:String) : String
      {
         if(isEmpty(str) || separator == null)
         {
            return str;
         }
         return str.replace(new RegExp(separator + "$",""),"");
      }
      
      public static function trim(str:String) : String
      {
         if(str == null)
         {
            return null;
         }
         return str.replace(/^\s*/,"").replace(/\s*$/,"");
      }
      
      public static function deleteSpaces(str:String) : String
      {
         return deleteFromString(str,/\t|\r|\n|\b/g);
      }
      
      public static function deleteWhitespace(str:String) : String
      {
         return deleteFromString(str,/\s/g);
      }
      
      private static function deleteFromString(str:String, pattern:RegExp) : String
      {
         if(isEmpty(str))
         {
            return str;
         }
         return str.replace(pattern,"");
      }
      
      public static function left(str:String, len:int) : String
      {
         if(str == null)
         {
            return null;
         }
         if(len < 0)
         {
            return EMPTY;
         }
         if(str.length <= len)
         {
            return str;
         }
         return str.substring(0,len);
      }
      
      public static function center(str:String, size:int, padStr:String) : String
      {
         if(str == null || size <= 0)
         {
            return str;
         }
         if(isEmpty(padStr))
         {
            padStr = " ";
         }
         var strLen:int = str.length;
         var pads:int = size - strLen;
         if(pads <= 0)
         {
            return str;
         }
         str = leftPad(str,strLen + pads / 2,padStr);
         str = rightPad(str,size,padStr);
         return str;
      }
      
      public static function leftPad(str:String, size:int, padStr:String) : String
      {
         var padding:Array = null;
         var padChars:Array = null;
         var i:int = 0;
         if(str == null)
         {
            return null;
         }
         if(isEmpty(padStr))
         {
            padStr = " ";
         }
         var padLen:int = padStr.length;
         var strLen:int = str.length;
         var pads:int = size - strLen;
         if(pads <= 0)
         {
            return str;
         }
         if(padLen == 1 && pads <= PAD_LIMIT)
         {
            return leftPadChar(str,size,padStr.charAt(0));
         }
         if(pads == padLen)
         {
            return padStr.concat(str);
         }
         if(pads < padLen)
         {
            return padStr.substring(0,pads).concat(str);
         }
         padding = [];
         padChars = padStr.split("");
         for(i = 0; i < pads; i++)
         {
            padding[i] = padChars[i % padLen];
         }
         return padding.join("").concat(str);
      }
      
      public static function leftPadChar(str:String, size:int, padChar:String) : String
      {
         if(str == null)
         {
            return null;
         }
         var pads:int = size - str.length;
         if(pads <= 0)
         {
            return str;
         }
         if(pads > PAD_LIMIT)
         {
            return leftPad(str,size,padChar);
         }
         return padding(pads,padChar).concat(str);
      }
      
      public static function rightPad(str:String, size:int, padStr:String) : String
      {
         var padding:Array = null;
         var padChars:Array = null;
         var i:int = 0;
         if(str == null)
         {
            return null;
         }
         if(isEmpty(padStr))
         {
            padStr = " ";
         }
         var padLen:int = padStr.length;
         var strLen:int = str.length;
         var pads:int = size - strLen;
         if(pads <= 0)
         {
            return str;
         }
         if(padLen == 1 && pads <= PAD_LIMIT)
         {
            return rightPadChar(str,size,padStr.charAt(0));
         }
         if(pads == padLen)
         {
            return str.concat(padStr);
         }
         if(pads < padLen)
         {
            return str.concat(padStr.substring(0,pads));
         }
         padding = [];
         padChars = padStr.split("");
         for(i = 0; i < pads; i++)
         {
            padding[i] = padChars[i % padLen];
         }
         return str.concat(padding.join(""));
      }
      
      public static function rightPadChar(str:String, size:int, padChar:String) : String
      {
         if(str == null)
         {
            return null;
         }
         var pads:int = size - str.length;
         if(pads <= 0)
         {
            return str;
         }
         if(pads > PAD_LIMIT)
         {
            return rightPad(str,size,padChar);
         }
         return str.concat(padding(pads,padChar));
      }
      
      private static function padding(repeat:int, padChar:String) : String
      {
         var buffer:String = "";
         for(var i:int = 0; i < repeat; i++)
         {
            buffer = buffer + padChar;
         }
         return buffer;
      }
      
      public static function replace(text:String, pattern:String, repl:String) : String
      {
         if(text == null || isEmpty(pattern) || repl == null)
         {
            return text;
         }
         return text.replace(new RegExp(pattern,"g"),repl);
      }
      
      public static function replaceTo(text:String, pattern:String, repl:String, max:int) : String
      {
         if(text == null || isEmpty(pattern) || repl == null || max == 0)
         {
            return text;
         }
         var buf:String = "";
         var start:int = 0;
         var end:int = 0;
         while((end = text.indexOf(pattern,start)) != -1)
         {
            buf = buf + (text.substring(start,end) + repl);
            start = end + pattern.length;
            if(--max == 0)
            {
               break;
            }
         }
         return buf = buf + text.substring(start);
      }
      
      public static function replaceOnce(text:String, pattern:String, repl:String) : String
      {
         if(text == null || isEmpty(pattern) || repl == null)
         {
            return text;
         }
         return text.replace(new RegExp(pattern,""),repl);
      }
      
      public static function defaultIfEmpty(str:String, defaultStr:String) : String
      {
         return !!isEmpty(str)?defaultStr:str;
      }
      
      public static function isEmpty(str:String) : Boolean
      {
         if(str == null)
         {
            return true;
         }
         return str.length == 0;
      }
      
      public static function isNotEmpty(str:String) : Boolean
      {
         return !isEmpty(str);
      }
      
      public static function isBlank(str:String) : Boolean
      {
         return isEmpty(trimToEmpty(str));
      }
      
      public static function isNotBlank(str:String) : Boolean
      {
         return !isBlank(str);
      }
      
      public static function trimToNull(str:String) : String
      {
         var ts:String = trim(str);
         return !!isEmpty(ts)?null:ts;
      }
      
      public static function trimToEmpty(str:String) : String
      {
         return str == null?EMPTY:trim(str);
      }
      
      public static function capitalize(str:String) : String
      {
         if(isEmpty(str))
         {
            return str;
         }
         return str.charAt(0).toUpperCase() + str.substring(1);
      }
      
      public static function uncapitalize(str:String) : String
      {
         if(isEmpty(str))
         {
            return str;
         }
         return str.charAt(0).toLowerCase() + str.substring(1);
      }
      
      public static function titleize(str:String) : String
      {
         if(isEmpty(str))
         {
            return str;
         }
         var words:Array = str.toLowerCase().split(" ");
         for(var i:int = 0; i < words.length; i++)
         {
            words[i] = capitalize(words[i]);
         }
         return words.join(" ");
      }
      
      public static function substringAfter(str:String, separator:String) : String
      {
         if(isEmpty(str))
         {
            return str;
         }
         if(separator == null)
         {
            return EMPTY;
         }
         var pos:int = str.indexOf(separator);
         if(pos == INDEX_NOT_FOUND)
         {
            return EMPTY;
         }
         return str.substring(pos + separator.length);
      }
      
      public static function substringAfterLast(str:String, separator:String) : String
      {
         if(isEmpty(str))
         {
            return str;
         }
         if(isEmpty(separator))
         {
            return EMPTY;
         }
         var pos:int = str.lastIndexOf(separator);
         if(pos == INDEX_NOT_FOUND || pos == str.length - separator.length)
         {
            return EMPTY;
         }
         return str.substring(pos + separator.length);
      }
      
      public static function substringBefore(str:String, separator:String) : String
      {
         if(isEmpty(str) || separator == null)
         {
            return str;
         }
         if(separator.length == 0)
         {
            return EMPTY;
         }
         var pos:int = str.indexOf(separator);
         if(pos == INDEX_NOT_FOUND)
         {
            return str;
         }
         return str.substring(0,pos);
      }
      
      public static function substringBeforeLast(str:String, separator:String) : String
      {
         if(isEmpty(str) || isEmpty(separator))
         {
            return str;
         }
         var pos:int = str.lastIndexOf(separator);
         if(pos == INDEX_NOT_FOUND)
         {
            return str;
         }
         return str.substring(0,pos);
      }
      
      public static function substringBetween(str:String, open:String, close:String) : String
      {
         var end:int = 0;
         if(str == null || open == null || close == null)
         {
            return null;
         }
         var start:int = str.indexOf(open);
         if(start != INDEX_NOT_FOUND)
         {
            end = str.indexOf(close,start + open.length);
            if(end != INDEX_NOT_FOUND)
            {
               return str.substring(start + open.length,end);
            }
         }
         return null;
      }
      
      public static function strip(str:String, stripChars:String) : String
      {
         if(isEmpty(str))
         {
            return str;
         }
         return stripEnd(stripStart(str,stripChars),stripChars);
      }
      
      public static function stripStart(str:String, stripChars:String) : String
      {
         if(isEmpty(str))
         {
            return str;
         }
         var p:RegExp = new RegExp("^[" + (stripChars != null?stripChars:" ") + "]*","");
         return str.replace(p,"");
      }
      
      public static function stripEnd(str:String, stripChars:String) : String
      {
         if(isEmpty(str))
         {
            return str;
         }
         var p:RegExp = new RegExp("[" + (stripChars != null?stripChars:" ") + "]*$","");
         return str.replace(p,"");
      }
      
      public static function abbreviate(str:String, offset:int, maxWidth:int) : String
      {
         if(str == null)
         {
            return str;
         }
         if(maxWidth < 4)
         {
            throw new IllegalArgumentError("Minimum abbreviation width is 4");
         }
         if(str.length <= maxWidth)
         {
            return str;
         }
         if(offset > str.length)
         {
            offset = str.length;
         }
         if(str.length - offset < maxWidth - 3)
         {
            offset = str.length - (maxWidth - 3);
         }
         if(offset <= 4)
         {
            return str.substring(0,maxWidth - 3) + "...";
         }
         if(maxWidth < 7)
         {
            throw new IllegalArgumentError("Minimum abbreviation width with offset is 7");
         }
         if(offset + (maxWidth - 3) < str.length)
         {
            return "..." + abbreviate(str.substring(offset),0,maxWidth - 3);
         }
         return "..." + str.substring(str.length - (maxWidth - 3));
      }
      
      public static function ordinalIndexOf(str:String, searchStr:String, ordinal:int) : int
      {
         if(str == null || searchStr == null || ordinal <= 0)
         {
            return INDEX_NOT_FOUND;
         }
         if(searchStr.length == 0)
         {
            return 0;
         }
         var found:int = 0;
         var index:int = INDEX_NOT_FOUND;
         while(true)
         {
            index = str.indexOf(searchStr,index + 1);
            if(index < 0)
            {
               break;
            }
            found++;
            if(found >= ordinal)
            {
               return index;
            }
         }
         return index;
      }
      
      public static function countMatches(str:String, sub:String) : int
      {
         if(isEmpty(str) || isEmpty(sub))
         {
            return 0;
         }
         return str.match(new RegExp("(" + sub + ")","g")).length;
      }
      
      public static function contains(str:String, searchStr:String) : Boolean
      {
         if(str == null || searchStr == null)
         {
            return false;
         }
         return new RegExp("(" + searchStr + ")","g").test(str);
      }
      
      public static function containsIgnoreCase(str:String, searchStr:String) : Boolean
      {
         if(str == null || searchStr == null)
         {
            return false;
         }
         return new RegExp("(" + searchStr.toUpperCase() + ")","g").test(str.toUpperCase());
      }
      
      public static function containsNone(str:String, invalidChars:String) : Boolean
      {
         if(isEmpty(str) || invalidChars == null)
         {
            return true;
         }
         return new RegExp("^[^" + invalidChars + "]*$","").test(str);
      }
      
      public static function containsOnly(str:String, validChars:String) : Boolean
      {
         if(str == null || isEmpty(validChars))
         {
            return false;
         }
         if(str.length == 0)
         {
            return true;
         }
         return new RegExp("^[" + validChars + "]*$","g").test(str);
      }
      
      public static function indexOfAny(str:String, searchChars:String) : int
      {
         if(isEmpty(str) || isEmpty(searchChars))
         {
            return INDEX_NOT_FOUND;
         }
         return str.search(new RegExp("[" + searchChars + "]",""));
      }
      
      public static function indexOfAnyBut(str:String, searchChars:String) : int
      {
         if(isEmpty(str) || isEmpty(searchChars))
         {
            return INDEX_NOT_FOUND;
         }
         return str.search(new RegExp("[^" + searchChars + "]",""));
      }
      
      public static function difference(str1:String, str2:String) : String
      {
         if(str1 == null)
         {
            return str2;
         }
         if(str2 == null)
         {
            return str1;
         }
         var at:int = indexOfDifference(str1,str2);
         if(at == -1)
         {
            return EMPTY;
         }
         return str2.substring(at);
      }
      
      public static function indexOfDifference(str1:String, str2:String) : int
      {
         var i:int = 0;
         if(str1 == str2)
         {
            return INDEX_NOT_FOUND;
         }
         if(isEmpty(str1) || isEmpty(str2))
         {
            return 0;
         }
         i = 0;
         while(i < str1.length && i < str2.length)
         {
            if(str1.charAt(i) != str2.charAt(i))
            {
               break;
            }
            i++;
         }
         if(i < str2.length || i < str1.length)
         {
            return i;
         }
         return INDEX_NOT_FOUND;
      }
      
      public static function equals(str1:String, str2:String) : Boolean
      {
         return str1 === str2;
      }
      
      public static function equalsIgnoreCase(str1:String, str2:String) : Boolean
      {
         if(str1 == null && str2 == null)
         {
            return true;
         }
         if(str1 == null || str2 == null)
         {
            return false;
         }
         return equals(str1.toLowerCase(),str2.toLowerCase());
      }
      
      public static function isAlpha(str:String) : Boolean
      {
         return testString(str,/^[a-zA-Z]*$/);
      }
      
      public static function isAlphaSpace(str:String) : Boolean
      {
         return testString(str,/^[a-zA-Z\s]*$/);
      }
      
      public static function isAlphanumeric(str:String) : Boolean
      {
         return testString(str,/^[a-zA-Z0-9]*$/);
      }
      
      public static function isAlphanumericSpace(str:String) : Boolean
      {
         return testString(str,/^[a-zA-Z0-9\s]*$/);
      }
      
      public static function isNumeric(str:String) : Boolean
      {
         return testString(str,/^[0-9]*$/);
      }
      
      public static function isNumericSpace(str:String) : Boolean
      {
         return testString(str,/^[0-9\s]*$/);
      }
      
      public static function isWhitespace(str:String) : Boolean
      {
         return testString(str,/^[\s]*$/);
      }
      
      private static function testString(str:String, pattern:RegExp) : Boolean
      {
         return str != null && pattern.test(str);
      }
      
      public static function overlay(str:String, overlay:String, start:int, end:int) : String
      {
         var temp:int = 0;
         if(str == null)
         {
            return null;
         }
         if(overlay == null)
         {
            overlay = EMPTY;
         }
         var len:int = str.length;
         if(start < 0)
         {
            start = 0;
         }
         if(start > len)
         {
            start = len;
         }
         if(end < 0)
         {
            end = 0;
         }
         if(end > len)
         {
            end = len;
         }
         if(start > end)
         {
            temp = start;
            start = end;
            end = temp;
         }
         return str.substring(0,start).concat(overlay).concat(str.substring(end));
      }
      
      public static function remove(str:String, remove:String) : String
      {
         return safeRemove(str,new RegExp(remove,"g"));
      }
      
      public static function removeEnd(str:String, remove:String) : String
      {
         return safeRemove(str,new RegExp(remove + "$",""));
      }
      
      public static function removeStart(str:String, remove:String) : String
      {
         return safeRemove(str,new RegExp("^" + remove,""));
      }
      
      private static function safeRemove(str:String, pattern:RegExp) : String
      {
         if(isEmpty(str))
         {
            return str;
         }
         return str.replace(pattern,"");
      }
      
      public static function endsWith(str:String, end:String) : Boolean
      {
         if(str != null && end != null && str.length >= end.length)
         {
            return str.substr(str.length - end.length,str.length) == end;
         }
         return false;
      }
      
      public static function endsWithIgnoreCase(str:String, end:String) : Boolean
      {
         if(str != null && end != null && str.length >= end.length)
         {
            return str.toUpperCase().substr(str.length - end.length,str.length) == end.toUpperCase();
         }
         return false;
      }
      
      public static function startsWith(str:String, start:String) : Boolean
      {
         if(str != null && start != null && str.length >= start.length)
         {
            return str.substr(0,start.length) == start;
         }
         return false;
      }
      
      public static function startsWithIgnoreCase(str:String, start:String) : Boolean
      {
         if(str != null && start != null && str.length >= start.length)
         {
            return str.toUpperCase().substr(0,start.length) == start.toUpperCase();
         }
         return false;
      }
      
      public static function compareToIgnoreCase(str1:String, str2:String) : int
      {
         if(str1 == null)
         {
            str1 = "";
         }
         if(str2 == null)
         {
            str2 = "";
         }
         return compareTo(str1.toLowerCase(),str2.toLowerCase());
      }
      
      public static function compareTo(str1:String, str2:String) : int
      {
         if(str1 == null)
         {
            str1 = "";
         }
         if(str2 == null)
         {
            str2 = "";
         }
         return str1.localeCompare(str2);
      }
      
      public static function addAt(string:String, value:*, position:int) : String
      {
         if(position > string.length)
         {
            position = string.length;
         }
         var firstPart:String = string.substring(0,position);
         var secondPart:String = string.substring(position,string.length);
         return firstPart + value + secondPart;
      }
      
      public static function replaceAt(string:String, value:*, beginIndex:int, endIndex:int) : String
      {
         beginIndex = Math.max(beginIndex,0);
         endIndex = Math.min(endIndex,string.length);
         var firstPart:String = string.substr(0,beginIndex);
         var secondPart:String = string.substr(endIndex,string.length);
         return firstPart + value + secondPart;
      }
      
      public static function removeAt(string:String, beginIndex:int, endIndex:int) : String
      {
         return StringUtils.replaceAt(string,"",beginIndex,endIndex);
      }
      
      public static function fixNewlines(string:String) : String
      {
         return string.replace(/\r\n/gm,"\n");
      }
      
      public static function hasText(string:String) : Boolean
      {
         if(!string)
         {
            return false;
         }
         return StringUtils.trim(string).length > 0;
      }
      
      public static function leftTrim(string:String) : String
      {
         return leftTrimForChars(string,"\n\t\n ");
      }
      
      public static function rightTrim(string:String) : String
      {
         return rightTrimForChars(string,"\n\t\n ");
      }
      
      public static function leftTrimForChars(string:String, chars:String) : String
      {
         var from:* = 0;
         var to:Number = string.length;
         while(from < to && chars.indexOf(string.charAt(from)) >= 0)
         {
            from++;
         }
         return from > 0?string.substr(from,to):string;
      }
      
      public static function rightTrimForChars(string:String, chars:String) : String
      {
         var from:* = 0;
         var to:Number = string.length - 1;
         while(from < to && chars.indexOf(string.charAt(to)) >= 0)
         {
            to--;
         }
         return to >= 0?string.substr(from,to + 1):string;
      }
      
      public static function leftTrimForChar(string:String, char:String) : String
      {
         if(char.length != 1)
         {
            throw new IllegalArgumentError("The Second Attribute char [" + char + "] must exactly one character.");
         }
         return leftTrimForChars(string,char);
      }
      
      public static function rightTrimForChar(string:String, char:String) : String
      {
         if(char.length != 1)
         {
            throw new IllegalArgumentError("The Second Attribute char [" + char + "] must exactly one character.");
         }
         return rightTrimForChars(string,char);
      }
      
      public static function nthIndexOf(haystack:String, n:uint, needle:String, startIndex:Number = 0) : int
      {
         var i:int = 0;
         var result:int = startIndex;
         if(n >= 1)
         {
            result = haystack.indexOf(needle,result);
            i = 1;
            while(result != -1 && i < n)
            {
               result = haystack.indexOf(needle,result + 1);
               i++;
            }
         }
         return result;
      }
      
      public static function characterIsWhitespace(a:String) : Boolean
      {
         return a.charCodeAt(0) <= 32;
      }
      
      public static function characterIsDigit(a:String) : Boolean
      {
         var charCode:Number = a.charCodeAt(0);
         return charCode >= 48 && charCode <= 57;
      }
      
      public static function naturalCompare(a:String, b:String) : int
      {
         var ca:String = null;
         var cb:String = null;
         var result:int = 0;
         var ia:int = 0;
         var ib:int = 0;
         var nza:int = 0;
         var nzb:int = 0;
         var lowerCaseBeforeUpperCase:Boolean = true;
         if(!a)
         {
            a = "";
         }
         if(!b)
         {
            b = "";
         }
         var stringsAreCaseInsensitiveEqual:Boolean = false;
         if(a.toLocaleLowerCase() == b.toLocaleLowerCase())
         {
            stringsAreCaseInsensitiveEqual = true;
         }
         else
         {
            a = a.toLowerCase();
            b = b.toLowerCase();
         }
         while(true)
         {
            nza = nzb = 0;
            ca = a.charAt(ia);
            cb = b.charAt(ib);
            while(StringUtils.characterIsWhitespace(ca) || ca == "0")
            {
               if(ca == "0")
               {
                  nza++;
               }
               else
               {
                  nza = 0;
               }
               ca = a.charAt(++ia);
            }
            while(StringUtils.characterIsWhitespace(cb) || cb == "0")
            {
               if(cb == "0")
               {
                  nzb++;
               }
               else
               {
                  nzb = 0;
               }
               cb = b.charAt(++ib);
            }
            if(StringUtils.characterIsDigit(ca) && StringUtils.characterIsDigit(cb))
            {
               if((result = compareRight(a.substring(ia),b.substring(ib))) != 0)
               {
                  break;
               }
            }
            if(ca.length == 0 && cb.length == 0)
            {
               return nza - nzb;
            }
            if(stringsAreCaseInsensitiveEqual)
            {
               if(ca != cb)
               {
                  if(ca < cb)
                  {
                     return !!lowerCaseBeforeUpperCase?1:-1;
                  }
                  if(ca > cb)
                  {
                     return !!lowerCaseBeforeUpperCase?-1:1;
                  }
               }
            }
            if(ca < cb)
            {
               return -1;
            }
            if(ca > cb)
            {
               return 1;
            }
            ia++;
            ib++;
         }
         return result;
      }
      
      private static function compareRight(a:String, b:String) : int
      {
         var ca:String = null;
         var cb:String = null;
         var bias:int = 0;
         var ia:int = 0;
         var ib:int = 0;
         while(true)
         {
            ca = a.charAt(ia);
            cb = b.charAt(ib);
            if(!StringUtils.characterIsDigit(ca) && !StringUtils.characterIsDigit(cb))
            {
               break;
            }
            if(!StringUtils.characterIsDigit(ca))
            {
               return -1;
            }
            if(!StringUtils.characterIsDigit(cb))
            {
               return 1;
            }
            if(ca < cb)
            {
               if(bias == 0)
               {
                  bias = -1;
               }
            }
            else if(ca > cb)
            {
               if(bias == 0)
               {
                  bias = 1;
               }
            }
            else if(ca.length == 0 && cb.length == 0)
            {
               return bias;
            }
            ia++;
            ib++;
         }
         return bias;
      }
      
      public static function tokenizeToArray(string:String, delimiters:String) : Array
      {
         var character:String = null;
         var result:Array = [];
         var numCharacters:int = string.length;
         var token:String = "";
         for(var i:int = 0; i < numCharacters; i++)
         {
            character = string.charAt(i);
            if(delimiters.indexOf(character) == -1)
            {
               token = token + character;
            }
            else
            {
               result.push(token);
               token = "";
            }
            if(i == numCharacters - 1)
            {
               result.push(token);
            }
         }
         return result;
      }
      
      public static function tokenizeToVector(string:String, delimiters:String) : Vector.<String>
      {
         var character:String = null;
         var result:Vector.<String> = new Vector.<String>();
         var numCharacters:int = string.length;
         var token:String = "";
         for(var i:int = 0; i < numCharacters; i++)
         {
            character = string.charAt(i);
            if(delimiters.indexOf(character) == -1)
            {
               token = token + character;
            }
            else
            {
               result[result.length] = token;
               token = "";
            }
            if(i == numCharacters - 1)
            {
               result[result.length] = token;
            }
         }
         return result;
      }
      
      public static function substitute(str:String, ... rest) : String
      {
         var args:Array = null;
         var item:* = undefined;
         if(str == null)
         {
            return "";
         }
         var len:uint = rest.length;
         if(len == 1 && rest[0] is Array)
         {
            args = rest[0];
            len = args.length;
         }
         else
         {
            args = rest;
         }
         for(var i:int = 0; i < len; i++)
         {
            item = args[i];
            str = str.split("{" + i.toString() + "}").join(item != null?item.toString():"[null]");
         }
         return str;
      }
      
      public static function escape(string:String, keyMap:Array = null, ignoreUnicode:Boolean = true) : String
      {
         if(string == null)
         {
            return string;
         }
         if(!keyMap)
         {
            keyMap = DEFAULT_ESCAPE_MAP;
         }
         var i:* = 0;
         var l:Number = keyMap.length;
         while(i < l)
         {
            string = string.split(keyMap[i]).join(keyMap[i + 1]);
            i = Number(i + 2);
         }
         if(!ignoreUnicode)
         {
            i = 0;
            l = string.length;
            while(i < l)
            {
               if(string.substring(i,i + 2) == "\\u")
               {
                  string = string.substring(0,i) + String.fromCharCode(parseInt(string.substring(i + 2,i + 6),16)) + string.substring(i + 6);
               }
               i++;
            }
         }
         return string;
      }
      
      public static function isValidFileName(fileName:String) : Boolean
      {
         if(!isEmpty(fileName))
         {
            return FILENAME_CHARS_NOT_ALLOWED.exec(fileName) == null;
         }
         return false;
      }
      
      public static function parseProperties(str:String, properties:Object = null) : Object
      {
         var i:* = NaN;
         var key:String = null;
         var value:String = null;
         var formerKey:String = null;
         var formerValue:String = null;
         var line:String = null;
         var sep:Number = NaN;
         var j:* = NaN;
         var l:Number = NaN;
         var char:String = null;
         properties = properties || {};
         var lines:Array = str.split(WIN_BREAK).join("\n").split(MAC_BREAK).join("\n").split("\n");
         var length:Number = lines.length;
         var useNextLine:Boolean = false;
         for(i = 0; i < length; i++)
         {
            line = lines[i];
            line = trim(line);
            if(line.indexOf("#") != 0 && line.indexOf("!") != 0 && line.length != 0)
            {
               if(useNextLine)
               {
                  key = formerKey;
                  value = formerValue + line;
                  useNextLine = false;
               }
               else
               {
                  l = line.length;
                  for(j = 0; j < l; j++)
                  {
                     char = line.charAt(j);
                     if(char == "\'")
                     {
                        j++;
                     }
                     else if(char == ":" || char == "=" || char == "\t")
                     {
                        break;
                     }
                  }
                  sep = j == l?Number(line.length):Number(j);
                  key = rightTrim(line.substr(0,sep));
                  value = line.substring(sep + 1);
                  formerKey = key;
                  formerValue = value;
               }
               value = leftTrim(value);
               if(value.charAt(value.length - 1) == "\\")
               {
                  formerValue = value = value.substr(0,value.length - 1);
                  useNextLine = true;
               }
               else
               {
                  properties[key] = escape(value,PROPERTIES_ESCAPE_MAP,false);
               }
            }
         }
         return properties;
      }
   }
}
