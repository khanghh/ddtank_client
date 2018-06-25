package road7th.utils{   import flash.geom.Point;   import flash.text.TextField;   import flash.utils.ByteArray;      public class StringHelper   {            private static var blankSpaceType:Array = [9,61656,59349,59350,59351,59352,59353,59354,59355,59355,59356,59357,59358,59359,59360,59361,59362,59363,59364,59365];            private static const OFFSET:Number = 2000;            private static const reg:RegExp = /[^\x00-\xff]{1,}/g;            public static const _leftReg:RegExp = /</g;            public static const _rightReg:RegExp = />/g;            public static const _reverseLeftReg:RegExp = /&lt;/g;            public static const _reverseRightReg:RegExp = /&gt;/g;            private static var idR1:RegExp = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;            private static var idR2:RegExp = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}(\d|x|X)$/;            private static var idArr:Array = [11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65];                   public function StringHelper() { super(); }
            public static function trimLeft(targetString:String) : String { return null; }
            public static function trim(str:String) : String { return null; }
            public static function trimRight(targetString:String) : String { return null; }
            public static function trimAll(str:String) : String { return null; }
            public static function replaceStr(str:String, sourceWord:String, targetWord:String) : String { return null; }
            public static function isNullOrEmpty(str:String) : Boolean { return false; }
            public static function stringToPath(pathString:String) : Array { return null; }
            public static function stringToPoint(str:String) : Point { return null; }
            public static function pathToString(path:Array) : String { return null; }
            public static function pointToString(point:Point) : String { return null; }
            public static function numberToString(number:Number) : String { return null; }
            public static function stringToNumber(str:String) : Number { return 0; }
            public static function getIsBiggerMaxCHchar(str:String, max:uint) : Boolean { return false; }
            public static function getRandomNumber() : String { return null; }
            public static function checkTextFieldLength(textfield:TextField, max:uint, input:String = null) : void { }
            public static function rePlaceHtmlTextField(s:String) : String { return null; }
            public static function reverseHtmlTextField(s:String) : String { return null; }
            public static function parseTime(res:String, len:uint) : String { return null; }
            public static function cidCheck(id:String) : Boolean { return false; }
            public static function cageCheck(value:String) : Boolean { return false; }
            public static function replaceHtmlTag(str:String) : String { return null; }
            public static function replaceToHtmlText(s:String) : String { return null; }
            public static function getConvertedHtmlArray(str:String) : Array { return null; }
            public static function format(str:String, ... args) : String { return null; }
            public static function getConvertedLst(fromCharCode:String) : Array { return null; }
            public static function trimHtmlText(value:String) : String { return null; }
            public static function parseMoneyFormat(value:int) : String { return null; }
            private static function reverseString(value:String) : String { return null; }
   }}