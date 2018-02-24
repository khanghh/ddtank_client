package road7th.utils
{
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class StringHelper
   {
      
      private static var blankSpaceType:Array = [9,61656,59349,59350,59351,59352,59353,59354,59355,59355,59356,59357,59358,59359,59360,59361,59362,59363,59364,59365];
      
      private static const OFFSET:Number = 2000;
      
      private static const reg:RegExp = /[^\x00-\xff]{1,}/g;
      
      public static const _leftReg:RegExp = /</g;
      
      public static const _rightReg:RegExp = />/g;
      
      public static const _reverseLeftReg:RegExp = /&lt;/g;
      
      public static const _reverseRightReg:RegExp = /&gt;/g;
      
      private static var idR1:RegExp = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
      
      private static var idR2:RegExp = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}(\d|x|X)$/;
      
      private static var idArr:Array = [11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65];
       
      
      public function StringHelper(){super();}
      
      public static function trimLeft(param1:String) : String{return null;}
      
      public static function trim(param1:String) : String{return null;}
      
      public static function trimRight(param1:String) : String{return null;}
      
      public static function trimAll(param1:String) : String{return null;}
      
      public static function replaceStr(param1:String, param2:String, param3:String) : String{return null;}
      
      public static function isNullOrEmpty(param1:String) : Boolean{return false;}
      
      public static function stringToPath(param1:String) : Array{return null;}
      
      public static function stringToPoint(param1:String) : Point{return null;}
      
      public static function pathToString(param1:Array) : String{return null;}
      
      public static function pointToString(param1:Point) : String{return null;}
      
      public static function numberToString(param1:Number) : String{return null;}
      
      public static function stringToNumber(param1:String) : Number{return 0;}
      
      public static function getIsBiggerMaxCHchar(param1:String, param2:uint) : Boolean{return false;}
      
      public static function getRandomNumber() : String{return null;}
      
      public static function checkTextFieldLength(param1:TextField, param2:uint, param3:String = null) : void{}
      
      public static function rePlaceHtmlTextField(param1:String) : String{return null;}
      
      public static function reverseHtmlTextField(param1:String) : String{return null;}
      
      public static function parseTime(param1:String, param2:uint) : String{return null;}
      
      public static function cidCheck(param1:String) : Boolean{return false;}
      
      public static function cageCheck(param1:String) : Boolean{return false;}
      
      public static function replaceHtmlTag(param1:String) : String{return null;}
      
      public static function replaceToHtmlText(param1:String) : String{return null;}
      
      public static function getConvertedHtmlArray(param1:String) : Array{return null;}
      
      public static function format(param1:String, ... rest) : String{return null;}
      
      public static function getConvertedLst(param1:String) : Array{return null;}
      
      public static function trimHtmlText(param1:String) : String{return null;}
      
      public static function parseMoneyFormat(param1:int) : String{return null;}
      
      private static function reverseString(param1:String) : String{return null;}
   }
}
