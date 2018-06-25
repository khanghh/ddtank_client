package com.pickgliss.utils{   import flash.utils.Dictionary;      public final class StringUtils   {            public static const BASE64:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";            private static var _reg:RegExp = /\{(\d+)\}/;                   public function StringUtils() { super(); }
            public static function afterFirst(p_string:String, p_char:String) : String { return null; }
            public static function afterLast(p_string:String, p_char:String) : String { return null; }
            public static function beginsWith(p_string:String, p_begin:String) : Boolean { return false; }
            public static function beforeFirst(p_string:String, p_char:String) : String { return null; }
            public static function beforeLast(p_string:String, p_char:String) : String { return null; }
            public static function between(p_string:String, p_start:String, p_end:String) : String { return null; }
            public static function block(p_string:String, p_len:uint, p_delim:String = ".") : Array { return null; }
            public static function capitalize(p_string:String, ... args) : String { return null; }
            public static function ljust(p_string:String, p_width:uint, p_pad:String = " ") : String { return null; }
            public static function rjust(p_string:String, p_width:uint, p_pad:String = " ") : String { return null; }
            public static function center(p_string:String, p_width:uint, p_pad:String = " ") : String { return null; }
            public static function repeat(p_string:String, p_count:uint = 1) : String { return null; }
            public static function base64Encode(p_string:String) : String { return null; }
            public static function contains(p_string:String, p_char:String) : Boolean { return false; }
            public static function countOf(p_string:String, p_char:String, p_caseSensitive:Boolean = true) : uint { return null; }
            public static function editDistance(p_source:String, p_target:String) : uint { return null; }
            public static function endsWith(p_string:String, p_end:String) : Boolean { return false; }
            public static function hasText(p_string:String) : Boolean { return false; }
            public static function isEmpty(p_string:String) : Boolean { return false; }
            public static function isNumeric(p_string:String) : Boolean { return false; }
            public static function padLeft(p_string:String, p_padChar:String, p_length:uint) : String { return null; }
            public static function padRight(p_string:String, p_padChar:String, p_length:uint) : String { return null; }
            public static function properCase(p_string:String) : String { return null; }
            public static function quote(p_string:String) : String { return null; }
            public static function relativePath(p_base:String, p_path:String, p_delim:String = "/") : String { return null; }
            public static function remove(p_string:String, p_remove:String, p_caseSensitive:Boolean = true) : String { return null; }
            public static function removeExtraWhitespace(p_string:String) : String { return null; }
            public static function reverse(p_string:String) : String { return null; }
            public static function reverseWords(p_string:String) : String { return null; }
            public static function similarity(p_source:String, p_target:String) : Number { return 0; }
            public static function stripTags(p_string:String) : String { return null; }
            public static function supplant(p_string:String, ... args) : String { return null; }
            public static function swapCase(p_string:String) : String { return null; }
            public static function trim(p_string:String) : String { return null; }
            public static function trimLeft(p_string:String) : String { return null; }
            public static function trimRight(p_string:String) : String { return null; }
            public static function truncate(p_string:String, p_len:uint, p_suffix:String = "...") : String { return null; }
            public static function wordCount(p_string:String) : uint { return null; }
            private static function escapePattern(p_pattern:String) : String { return null; }
            private static function _quote(p_string:String, ... args) : String { return null; }
            private static function _upperCase(p_char:String, ... args) : String { return null; }
            private static function _swapCase(p_char:String, ... args) : String { return null; }
            public static function converBoolean(value:String) : Boolean { return false; }
            public static function dictionaryKeyToString(dic:Dictionary) : String { return null; }
            public static function trimHtmlText(value:String) : String { return null; }
            public static function replaceValueByIndex(input:String, ... args) : String { return null; }
            public static function getTimeTick() : String { return null; }
            public static function getSuffixStr(value:String) : String { return null; }
   }}