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
      
      private static const FILENAME_CHARS_NOT_ALLOWED:RegExp = null;
       
      
      public function StringUtils(){super();}
      
      public static function toInitials(param1:String) : String{return null;}
      
      public static function chomp(param1:String) : String{return null;}
      
      public static function chompString(param1:String, param2:String) : String{return null;}
      
      public static function trim(param1:String) : String{return null;}
      
      public static function deleteSpaces(param1:String) : String{return null;}
      
      public static function deleteWhitespace(param1:String) : String{return null;}
      
      private static function deleteFromString(param1:String, param2:RegExp) : String{return null;}
      
      public static function left(param1:String, param2:int) : String{return null;}
      
      public static function center(param1:String, param2:int, param3:String) : String{return null;}
      
      public static function leftPad(param1:String, param2:int, param3:String) : String{return null;}
      
      public static function leftPadChar(param1:String, param2:int, param3:String) : String{return null;}
      
      public static function rightPad(param1:String, param2:int, param3:String) : String{return null;}
      
      public static function rightPadChar(param1:String, param2:int, param3:String) : String{return null;}
      
      private static function padding(param1:int, param2:String) : String{return null;}
      
      public static function replace(param1:String, param2:String, param3:String) : String{return null;}
      
      public static function replaceTo(param1:String, param2:String, param3:String, param4:int) : String{return null;}
      
      public static function replaceOnce(param1:String, param2:String, param3:String) : String{return null;}
      
      public static function defaultIfEmpty(param1:String, param2:String) : String{return null;}
      
      public static function isEmpty(param1:String) : Boolean{return false;}
      
      public static function isNotEmpty(param1:String) : Boolean{return false;}
      
      public static function isBlank(param1:String) : Boolean{return false;}
      
      public static function isNotBlank(param1:String) : Boolean{return false;}
      
      public static function trimToNull(param1:String) : String{return null;}
      
      public static function trimToEmpty(param1:String) : String{return null;}
      
      public static function capitalize(param1:String) : String{return null;}
      
      public static function uncapitalize(param1:String) : String{return null;}
      
      public static function titleize(param1:String) : String{return null;}
      
      public static function substringAfter(param1:String, param2:String) : String{return null;}
      
      public static function substringAfterLast(param1:String, param2:String) : String{return null;}
      
      public static function substringBefore(param1:String, param2:String) : String{return null;}
      
      public static function substringBeforeLast(param1:String, param2:String) : String{return null;}
      
      public static function substringBetween(param1:String, param2:String, param3:String) : String{return null;}
      
      public static function strip(param1:String, param2:String) : String{return null;}
      
      public static function stripStart(param1:String, param2:String) : String{return null;}
      
      public static function stripEnd(param1:String, param2:String) : String{return null;}
      
      public static function abbreviate(param1:String, param2:int, param3:int) : String{return null;}
      
      public static function ordinalIndexOf(param1:String, param2:String, param3:int) : int{return 0;}
      
      public static function countMatches(param1:String, param2:String) : int{return 0;}
      
      public static function contains(param1:String, param2:String) : Boolean{return false;}
      
      public static function containsIgnoreCase(param1:String, param2:String) : Boolean{return false;}
      
      public static function containsNone(param1:String, param2:String) : Boolean{return false;}
      
      public static function containsOnly(param1:String, param2:String) : Boolean{return false;}
      
      public static function indexOfAny(param1:String, param2:String) : int{return 0;}
      
      public static function indexOfAnyBut(param1:String, param2:String) : int{return 0;}
      
      public static function difference(param1:String, param2:String) : String{return null;}
      
      public static function indexOfDifference(param1:String, param2:String) : int{return 0;}
      
      public static function equals(param1:String, param2:String) : Boolean{return false;}
      
      public static function equalsIgnoreCase(param1:String, param2:String) : Boolean{return false;}
      
      public static function isAlpha(param1:String) : Boolean{return false;}
      
      public static function isAlphaSpace(param1:String) : Boolean{return false;}
      
      public static function isAlphanumeric(param1:String) : Boolean{return false;}
      
      public static function isAlphanumericSpace(param1:String) : Boolean{return false;}
      
      public static function isNumeric(param1:String) : Boolean{return false;}
      
      public static function isNumericSpace(param1:String) : Boolean{return false;}
      
      public static function isWhitespace(param1:String) : Boolean{return false;}
      
      private static function testString(param1:String, param2:RegExp) : Boolean{return false;}
      
      public static function overlay(param1:String, param2:String, param3:int, param4:int) : String{return null;}
      
      public static function remove(param1:String, param2:String) : String{return null;}
      
      public static function removeEnd(param1:String, param2:String) : String{return null;}
      
      public static function removeStart(param1:String, param2:String) : String{return null;}
      
      private static function safeRemove(param1:String, param2:RegExp) : String{return null;}
      
      public static function endsWith(param1:String, param2:String) : Boolean{return false;}
      
      public static function endsWithIgnoreCase(param1:String, param2:String) : Boolean{return false;}
      
      public static function startsWith(param1:String, param2:String) : Boolean{return false;}
      
      public static function startsWithIgnoreCase(param1:String, param2:String) : Boolean{return false;}
      
      public static function compareToIgnoreCase(param1:String, param2:String) : int{return 0;}
      
      public static function compareTo(param1:String, param2:String) : int{return 0;}
      
      public static function addAt(param1:String, param2:*, param3:int) : String{return null;}
      
      public static function replaceAt(param1:String, param2:*, param3:int, param4:int) : String{return null;}
      
      public static function removeAt(param1:String, param2:int, param3:int) : String{return null;}
      
      public static function fixNewlines(param1:String) : String{return null;}
      
      public static function hasText(param1:String) : Boolean{return false;}
      
      public static function leftTrim(param1:String) : String{return null;}
      
      public static function rightTrim(param1:String) : String{return null;}
      
      public static function leftTrimForChars(param1:String, param2:String) : String{return null;}
      
      public static function rightTrimForChars(param1:String, param2:String) : String{return null;}
      
      public static function leftTrimForChar(param1:String, param2:String) : String{return null;}
      
      public static function rightTrimForChar(param1:String, param2:String) : String{return null;}
      
      public static function nthIndexOf(param1:String, param2:uint, param3:String, param4:Number = 0) : int{return 0;}
      
      public static function characterIsWhitespace(param1:String) : Boolean{return false;}
      
      public static function characterIsDigit(param1:String) : Boolean{return false;}
      
      public static function naturalCompare(param1:String, param2:String) : int{return 0;}
      
      private static function compareRight(param1:String, param2:String) : int{return 0;}
      
      public static function tokenizeToArray(param1:String, param2:String) : Array{return null;}
      
      public static function tokenizeToVector(param1:String, param2:String) : Vector.<String>{return null;}
      
      public static function substitute(param1:String, ... rest) : String{return null;}
      
      public static function escape(param1:String, param2:Array = null, param3:Boolean = true) : String{return null;}
      
      public static function isValidFileName(param1:String) : Boolean{return false;}
      
      public static function parseProperties(param1:String, param2:Object = null) : Object{return null;}
   }
}
