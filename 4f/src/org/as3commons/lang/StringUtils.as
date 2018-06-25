package org.as3commons.lang{   public final class StringUtils   {            private static var WIN_BREAK:String = String.fromCharCode(13) + String.fromCharCode(10);            private static var MAC_BREAK:String = String.fromCharCode(13);            public static var DEFAULT_ESCAPE_MAP:Array = ["\\t","\t","\\n","\n","\\r","\r","\\\"","\"","\\\\","\\","\\\'","\'","\\f","\f","\\b","\b","\\",""];            private static var PROPERTIES_ESCAPE_MAP:Array = ["\\t","\t","\\n","\n","\\r","\r","\\\"","\"","\\\\","\\","\\\'","\'","\\f","\f"];            private static const EMPTY:String = "";            private static const INDEX_NOT_FOUND:int = -1;            private static const PAD_LIMIT:uint = 8192;            private static const FILENAME_CHARS_NOT_ALLOWED:RegExp = /|\\|:|\*|\?|<|>|\||%|"/;                   public function StringUtils() { super(); }
            public static function toInitials(str:String) : String { return null; }
            public static function chomp(str:String) : String { return null; }
            public static function chompString(str:String, separator:String) : String { return null; }
            public static function trim(str:String) : String { return null; }
            public static function deleteSpaces(str:String) : String { return null; }
            public static function deleteWhitespace(str:String) : String { return null; }
            private static function deleteFromString(str:String, pattern:RegExp) : String { return null; }
            public static function left(str:String, len:int) : String { return null; }
            public static function center(str:String, size:int, padStr:String) : String { return null; }
            public static function leftPad(str:String, size:int, padStr:String) : String { return null; }
            public static function leftPadChar(str:String, size:int, padChar:String) : String { return null; }
            public static function rightPad(str:String, size:int, padStr:String) : String { return null; }
            public static function rightPadChar(str:String, size:int, padChar:String) : String { return null; }
            private static function padding(repeat:int, padChar:String) : String { return null; }
            public static function replace(text:String, pattern:String, repl:String) : String { return null; }
            public static function replaceTo(text:String, pattern:String, repl:String, max:int) : String { return null; }
            public static function replaceOnce(text:String, pattern:String, repl:String) : String { return null; }
            public static function defaultIfEmpty(str:String, defaultStr:String) : String { return null; }
            public static function isEmpty(str:String) : Boolean { return false; }
            public static function isNotEmpty(str:String) : Boolean { return false; }
            public static function isBlank(str:String) : Boolean { return false; }
            public static function isNotBlank(str:String) : Boolean { return false; }
            public static function trimToNull(str:String) : String { return null; }
            public static function trimToEmpty(str:String) : String { return null; }
            public static function capitalize(str:String) : String { return null; }
            public static function uncapitalize(str:String) : String { return null; }
            public static function titleize(str:String) : String { return null; }
            public static function substringAfter(str:String, separator:String) : String { return null; }
            public static function substringAfterLast(str:String, separator:String) : String { return null; }
            public static function substringBefore(str:String, separator:String) : String { return null; }
            public static function substringBeforeLast(str:String, separator:String) : String { return null; }
            public static function substringBetween(str:String, open:String, close:String) : String { return null; }
            public static function strip(str:String, stripChars:String) : String { return null; }
            public static function stripStart(str:String, stripChars:String) : String { return null; }
            public static function stripEnd(str:String, stripChars:String) : String { return null; }
            public static function abbreviate(str:String, offset:int, maxWidth:int) : String { return null; }
            public static function ordinalIndexOf(str:String, searchStr:String, ordinal:int) : int { return 0; }
            public static function countMatches(str:String, sub:String) : int { return 0; }
            public static function contains(str:String, searchStr:String) : Boolean { return false; }
            public static function containsIgnoreCase(str:String, searchStr:String) : Boolean { return false; }
            public static function containsNone(str:String, invalidChars:String) : Boolean { return false; }
            public static function containsOnly(str:String, validChars:String) : Boolean { return false; }
            public static function indexOfAny(str:String, searchChars:String) : int { return 0; }
            public static function indexOfAnyBut(str:String, searchChars:String) : int { return 0; }
            public static function difference(str1:String, str2:String) : String { return null; }
            public static function indexOfDifference(str1:String, str2:String) : int { return 0; }
            public static function equals(str1:String, str2:String) : Boolean { return false; }
            public static function equalsIgnoreCase(str1:String, str2:String) : Boolean { return false; }
            public static function isAlpha(str:String) : Boolean { return false; }
            public static function isAlphaSpace(str:String) : Boolean { return false; }
            public static function isAlphanumeric(str:String) : Boolean { return false; }
            public static function isAlphanumericSpace(str:String) : Boolean { return false; }
            public static function isNumeric(str:String) : Boolean { return false; }
            public static function isNumericSpace(str:String) : Boolean { return false; }
            public static function isWhitespace(str:String) : Boolean { return false; }
            private static function testString(str:String, pattern:RegExp) : Boolean { return false; }
            public static function overlay(str:String, overlay:String, start:int, end:int) : String { return null; }
            public static function remove(str:String, remove:String) : String { return null; }
            public static function removeEnd(str:String, remove:String) : String { return null; }
            public static function removeStart(str:String, remove:String) : String { return null; }
            private static function safeRemove(str:String, pattern:RegExp) : String { return null; }
            public static function endsWith(str:String, end:String) : Boolean { return false; }
            public static function endsWithIgnoreCase(str:String, end:String) : Boolean { return false; }
            public static function startsWith(str:String, start:String) : Boolean { return false; }
            public static function startsWithIgnoreCase(str:String, start:String) : Boolean { return false; }
            public static function compareToIgnoreCase(str1:String, str2:String) : int { return 0; }
            public static function compareTo(str1:String, str2:String) : int { return 0; }
            public static function addAt(string:String, value:*, position:int) : String { return null; }
            public static function replaceAt(string:String, value:*, beginIndex:int, endIndex:int) : String { return null; }
            public static function removeAt(string:String, beginIndex:int, endIndex:int) : String { return null; }
            public static function fixNewlines(string:String) : String { return null; }
            public static function hasText(string:String) : Boolean { return false; }
            public static function leftTrim(string:String) : String { return null; }
            public static function rightTrim(string:String) : String { return null; }
            public static function leftTrimForChars(string:String, chars:String) : String { return null; }
            public static function rightTrimForChars(string:String, chars:String) : String { return null; }
            public static function leftTrimForChar(string:String, char:String) : String { return null; }
            public static function rightTrimForChar(string:String, char:String) : String { return null; }
            public static function nthIndexOf(haystack:String, n:uint, needle:String, startIndex:Number = 0) : int { return 0; }
            public static function characterIsWhitespace(a:String) : Boolean { return false; }
            public static function characterIsDigit(a:String) : Boolean { return false; }
            public static function naturalCompare(a:String, b:String) : int { return 0; }
            private static function compareRight(a:String, b:String) : int { return 0; }
            public static function tokenizeToArray(string:String, delimiters:String) : Array { return null; }
            public static function tokenizeToVector(string:String, delimiters:String) : Vector.<String> { return null; }
            public static function substitute(str:String, ... rest) : String { return null; }
            public static function escape(string:String, keyMap:Array = null, ignoreUnicode:Boolean = true) : String { return null; }
            public static function isValidFileName(fileName:String) : Boolean { return false; }
            public static function parseProperties(str:String, properties:Object = null) : Object { return null; }
   }}