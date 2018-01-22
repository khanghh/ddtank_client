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
       
      
      public function StringHelper()
      {
         super();
      }
      
      public static function trimLeft(param1:String) : String
      {
         if(!param1)
         {
            return param1;
         }
         return param1.replace(/^\s*/g,"");
      }
      
      public static function trim(param1:String) : String
      {
         if(!param1)
         {
            return param1;
         }
         return param1.replace(/(^\s*)|(\s*$)/g,"");
      }
      
      public static function trimRight(param1:String) : String
      {
         return param1.replace(/\s*$/g,"");
      }
      
      public static function trimAll(param1:String) : String
      {
         var _loc4_:* = 0;
         var _loc2_:String = trim(param1);
         var _loc3_:String = "";
         _loc4_ = uint(0);
         while(_loc4_ < _loc2_.length)
         {
            if(blankSpaceType.indexOf(_loc2_.charCodeAt(_loc4_)) <= -1)
            {
               _loc3_ = _loc3_ + _loc2_.charAt(_loc4_);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function replaceStr(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
      
      public static function isNullOrEmpty(param1:String) : Boolean
      {
         return param1 == null || param1 == "";
      }
      
      public static function stringToPath(param1:String) : Array
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = param1.charCodeAt(_loc5_);
            _loc3_ = param1.charCodeAt(_loc5_ + 1);
            _loc2_.push(new Point(_loc4_ - 2000,_loc3_ - 2000));
            _loc5_ = _loc5_ + 2;
         }
         return _loc2_;
      }
      
      public static function stringToPoint(param1:String) : Point
      {
         return new Point(param1.charCodeAt(0) - 2000,param1.charCodeAt(1) - 2000);
      }
      
      public static function pathToString(param1:Array) : String
      {
         var _loc3_:int = 0;
         if(param1 == null || param1.length <= 0)
         {
            return "";
         }
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = _loc2_ + String.fromCharCode(Math.round(param1[_loc3_].x + 2000));
            _loc2_ = _loc2_ + String.fromCharCode(Math.round(param1[_loc3_].y + 2000));
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function pointToString(param1:Point) : String
      {
         var _loc2_:String = "";
         _loc2_ = _loc2_ + String.fromCharCode(Math.round(param1.x + 2000));
         _loc2_ = _loc2_ + String.fromCharCode(Math.round(param1.y + 2000));
         return _loc2_;
      }
      
      public static function numberToString(param1:Number) : String
      {
         return String.fromCharCode(Math.round(param1 + 2000));
      }
      
      public static function stringToNumber(param1:String) : Number
      {
         return param1.charCodeAt(0) - 2000;
      }
      
      public static function getIsBiggerMaxCHchar(param1:String, param2:uint) : Boolean
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTF(trim(param1));
         if(_loc3_.length > param2 * 3 + 2)
         {
            return true;
         }
         return false;
      }
      
      public static function getRandomNumber() : String
      {
         var _loc1_:uint = Math.round(Math.random() * 1000000);
         return _loc1_.toString();
      }
      
      public static function checkTextFieldLength(param1:TextField, param2:uint, param3:String = null) : void
      {
         var _loc4_:uint = !!param1.text?param1.text.match(reg).join("").length:0;
         var _loc5_:uint = !!param3?param3.match(reg).join("").length:0;
         param1.maxChars = param2 > _loc4_ + _loc5_?param2 - _loc4_ - _loc5_:Number(param2 > _loc5_?param2 - _loc5_:Number(param2 / 2));
      }
      
      public static function rePlaceHtmlTextField(param1:String) : String
      {
         param1 = param1.replace(_leftReg,"&lt;");
         param1 = param1.replace(_rightReg,"&gt;");
         return param1;
      }
      
      public static function reverseHtmlTextField(param1:String) : String
      {
         param1 = param1.replace(_reverseLeftReg,"<");
         param1 = param1.replace(_reverseRightReg,">");
         return param1;
      }
      
      public static function parseTime(param1:String, param2:uint) : String
      {
         var _loc4_:* = param1;
         var _loc3_:Date = new Date(Number(_loc4_.substr(0,4)),_loc4_.substr(5,2) - 1,Number(_loc4_.substr(8,2)));
         var _loc5_:Date = new Date();
         _loc5_.setTime(_loc3_.getTime() + (param2 + 1) * 24 * 60 * 60 * 1000);
         _loc4_ = String(_loc5_.getUTCFullYear()) + "-" + (_loc5_.getUTCMonth() + 1) + "-" + _loc5_.getUTCDate();
         return _loc4_;
      }
      
      public static function cidCheck(param1:String) : Boolean
      {
         if(idArr.indexOf(int(param1.slice(0,2))) != -1 && (idR1.test(param1) || idR2.test(param1)))
         {
            return true;
         }
         return false;
      }
      
      public static function cageCheck(param1:String) : Boolean
      {
         var _loc4_:int = param1.slice(0,4);
         var _loc3_:int = param1.slice(4,6);
         var _loc5_:int = param1.slice(6);
         var _loc2_:Date = new Date();
         if(_loc2_.fullYear - _loc4_ > 18)
         {
            return true;
         }
         if(_loc2_.fullYear - _loc4_ == 18)
         {
            if(_loc2_.month + 1 > _loc3_)
            {
               return true;
            }
            if(_loc2_.month + 1 == _loc3_)
            {
               if(_loc2_.date >= _loc5_)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function replaceHtmlTag(param1:String) : String
      {
         param1 = param1.replace(/<(\S*?)[^>]*>|<.*? \/>/g,"");
         return param1;
      }
      
      public static function replaceToHtmlText(param1:String) : String
      {
         var _loc2_:TextField = new TextField();
         _loc2_.text = param1;
         param1 = replaceHtmlTag(_loc2_.htmlText);
         return param1;
      }
      
      public static function getConvertedHtmlArray(param1:String) : Array
      {
         return param1.match(/&[a-z]*?;/g);
      }
      
      public static function format(param1:String, ... rest) : String
      {
         var _loc3_:* = 0;
         if(rest == null || rest.length <= 0)
         {
            return param1;
         }
         _loc3_ = uint(0);
         while(_loc3_ < rest.length)
         {
            param1 = replaceStr(param1,"{" + _loc3_.toString() + "}",rest[_loc3_]);
            _loc3_++;
         }
         return param1;
      }
      
      public static function getConvertedLst(param1:String) : Array
      {
         return param1.match(/&[a-z]*?;/g);
      }
      
      public static function trimHtmlText(param1:String) : String
      {
         var _loc3_:* = null;
         param1 = trim(param1);
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:RegExp = /<[\S+]>/g;
         var _loc6_:Object = _loc5_.exec(param1);
         var _loc4_:Vector.<String> = new Vector.<String>();
         while(_loc6_)
         {
            _loc2_ = _loc6_.index;
            _loc4_.push(param1.substring(_loc7_,_loc2_));
            _loc4_.push(_loc6_[0]);
            _loc7_ = _loc5_.lastIndex;
            _loc6_ = _loc5_.exec(param1);
         }
         _loc4_.push(param1.substring(_loc7_));
         _loc4_[2] = trimLeft(_loc4_[2]);
         _loc4_[_loc4_.length - 2] = trimRight(_loc4_[_loc4_.length - 2]);
         return _loc4_.join("");
      }
      
      public static function parseMoneyFormat(param1:int) : String
      {
         var _loc4_:int = 0;
         var _loc3_:String = reverseString(param1.toString());
         var _loc2_:String = "";
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc4_ != 0 && _loc4_ % 3 == 0)
            {
               _loc2_ = _loc2_ + ",";
            }
            _loc2_ = _loc2_ + _loc3_.charAt(_loc4_);
            _loc4_++;
         }
         return reverseString(_loc2_);
      }
      
      private static function reverseString(param1:String) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         _loc3_ = param1.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = _loc2_ + param1.charAt(_loc3_);
            _loc3_--;
         }
         return _loc2_;
      }
   }
}
