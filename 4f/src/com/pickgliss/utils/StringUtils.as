package com.pickgliss.utils
{
   import flash.utils.Dictionary;
   
   public final class StringUtils
   {
      
      public static const BASE64:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
      
      private static var _reg:RegExp = /\{(\d+)\}/;
       
      
      public function StringUtils(){super();}
      
      public static function afterFirst(param1:String, param2:String) : String{return null;}
      
      public static function afterLast(param1:String, param2:String) : String{return null;}
      
      public static function beginsWith(param1:String, param2:String) : Boolean{return false;}
      
      public static function beforeFirst(param1:String, param2:String) : String{return null;}
      
      public static function beforeLast(param1:String, param2:String) : String{return null;}
      
      public static function between(param1:String, param2:String, param3:String) : String{return null;}
      
      public static function block(param1:String, param2:uint, param3:String = ".") : Array{return null;}
      
      public static function capitalize(param1:String, ... rest) : String{return null;}
      
      public static function ljust(param1:String, param2:uint, param3:String = " ") : String{return null;}
      
      public static function rjust(param1:String, param2:uint, param3:String = " ") : String{return null;}
      
      public static function center(param1:String, param2:uint, param3:String = " ") : String{return null;}
      
      public static function repeat(param1:String, param2:uint = 1) : String{return null;}
      
      public static function base64Encode(param1:String) : String{return null;}
      
      public static function contains(param1:String, param2:String) : Boolean{return false;}
      
      public static function countOf(param1:String, param2:String, param3:Boolean = true) : uint{return null;}
      
      public static function editDistance(param1:String, param2:String) : uint{return null;}
      
      public static function endsWith(param1:String, param2:String) : Boolean{return false;}
      
      public static function hasText(param1:String) : Boolean{return false;}
      
      public static function isEmpty(param1:String) : Boolean{return false;}
      
      public static function isNumeric(param1:String) : Boolean{return false;}
      
      public static function padLeft(param1:String, param2:String, param3:uint) : String{return null;}
      
      public static function padRight(param1:String, param2:String, param3:uint) : String{return null;}
      
      public static function properCase(param1:String) : String{return null;}
      
      public static function quote(param1:String) : String{return null;}
      
      public static function relativePath(param1:String, param2:String, param3:String = "/") : String{return null;}
      
      public static function remove(param1:String, param2:String, param3:Boolean = true) : String{return null;}
      
      public static function removeExtraWhitespace(param1:String) : String{return null;}
      
      public static function reverse(param1:String) : String{return null;}
      
      public static function reverseWords(param1:String) : String{return null;}
      
      public static function similarity(param1:String, param2:String) : Number{return 0;}
      
      public static function stripTags(param1:String) : String{return null;}
      
      public static function supplant(param1:String, ... rest) : String{return null;}
      
      public static function swapCase(param1:String) : String{return null;}
      
      public static function trim(param1:String) : String{return null;}
      
      public static function trimLeft(param1:String) : String{return null;}
      
      public static function trimRight(param1:String) : String{return null;}
      
      public static function truncate(param1:String, param2:uint, param3:String = "...") : String{return null;}
      
      public static function wordCount(param1:String) : uint{return null;}
      
      private static function escapePattern(param1:String) : String{return null;}
      
      private static function _quote(param1:String, ... rest) : String{return null;}
      
      private static function _upperCase(param1:String, ... rest) : String{return null;}
      
      private static function _swapCase(param1:String, ... rest) : String{return null;}
      
      public static function converBoolean(param1:String) : Boolean{return false;}
      
      public static function dictionaryKeyToString(param1:Dictionary) : String{return null;}
      
      public static function trimHtmlText(param1:String) : String{return null;}
      
      public static function replaceValueByIndex(param1:String, ... rest) : String{return null;}
      
      public static function getTimeTick() : String{return null;}
      
      public static function getSuffixStr(param1:String) : String{return null;}
   }
}
