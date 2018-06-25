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
      
      public static function trimLeft(targetString:String) : String
      {
         if(!targetString)
         {
            return targetString;
         }
         return targetString.replace(/^\s*/g,"");
      }
      
      public static function trim(str:String) : String
      {
         if(!str)
         {
            return str;
         }
         return str.replace(/(^\s*)|(\s*$)/g,"");
      }
      
      public static function trimRight(targetString:String) : String
      {
         return targetString.replace(/\s*$/g,"");
      }
      
      public static function trimAll(str:String) : String
      {
         var i:* = 0;
         var s:String = trim(str);
         var newStr:String = "";
         for(i = uint(0); i < s.length; )
         {
            if(blankSpaceType.indexOf(s.charCodeAt(i)) <= -1)
            {
               newStr = newStr + s.charAt(i);
            }
            i++;
         }
         return newStr;
      }
      
      public static function replaceStr(str:String, sourceWord:String, targetWord:String) : String
      {
         return str.split(sourceWord).join(targetWord);
      }
      
      public static function isNullOrEmpty(str:String) : Boolean
      {
         return str == null || str == "";
      }
      
      public static function stringToPath(pathString:String) : Array
      {
         var i:int = 0;
         var x:int = 0;
         var y:int = 0;
         var path:Array = [];
         for(i = 0; i < pathString.length; )
         {
            x = pathString.charCodeAt(i);
            y = pathString.charCodeAt(i + 1);
            path.push(new Point(x - 2000,y - 2000));
            i = i + 2;
         }
         return path;
      }
      
      public static function stringToPoint(str:String) : Point
      {
         return new Point(str.charCodeAt(0) - 2000,str.charCodeAt(1) - 2000);
      }
      
      public static function pathToString(path:Array) : String
      {
         var i:int = 0;
         if(path == null || path.length <= 0)
         {
            return "";
         }
         var pathString:String = "";
         for(i = 0; i < path.length; )
         {
            pathString = pathString + String.fromCharCode(Math.round(path[i].x + 2000));
            pathString = pathString + String.fromCharCode(Math.round(path[i].y + 2000));
            i++;
         }
         return pathString;
      }
      
      public static function pointToString(point:Point) : String
      {
         var result:String = "";
         result = result + String.fromCharCode(Math.round(point.x + 2000));
         result = result + String.fromCharCode(Math.round(point.y + 2000));
         return result;
      }
      
      public static function numberToString(number:Number) : String
      {
         return String.fromCharCode(Math.round(number + 2000));
      }
      
      public static function stringToNumber(str:String) : Number
      {
         return str.charCodeAt(0) - 2000;
      }
      
      public static function getIsBiggerMaxCHchar(str:String, max:uint) : Boolean
      {
         var b:ByteArray = new ByteArray();
         b.writeUTF(trim(str));
         if(b.length > max * 3 + 2)
         {
            return true;
         }
         return false;
      }
      
      public static function getRandomNumber() : String
      {
         var n:uint = Math.round(Math.random() * 1000000);
         return n.toString();
      }
      
      public static function checkTextFieldLength(textfield:TextField, max:uint, input:String = null) : void
      {
         var ulen1:uint = !!textfield.text?textfield.text.match(reg).join("").length:0;
         var ulen2:uint = !!input?input.match(reg).join("").length:0;
         textfield.maxChars = max > ulen1 + ulen2?max - ulen1 - ulen2:Number(max > ulen2?max - ulen2:Number(max / 2));
      }
      
      public static function rePlaceHtmlTextField(s:String) : String
      {
         s = s.replace(_leftReg,"&lt;");
         s = s.replace(_rightReg,"&gt;");
         return s;
      }
      
      public static function reverseHtmlTextField(s:String) : String
      {
         s = s.replace(_reverseLeftReg,"<");
         s = s.replace(_reverseRightReg,">");
         return s;
      }
      
      public static function parseTime(res:String, len:uint) : String
      {
         var str:* = res;
         var mlk:Date = new Date(Number(str.substr(0,4)),str.substr(5,2) - 1,Number(str.substr(8,2)));
         var targetDate:Date = new Date();
         targetDate.setTime(mlk.getTime() + (len + 1) * 24 * 60 * 60 * 1000);
         str = String(targetDate.getUTCFullYear()) + "-" + (targetDate.getUTCMonth() + 1) + "-" + targetDate.getUTCDate();
         return str;
      }
      
      public static function cidCheck(id:String) : Boolean
      {
         if(idArr.indexOf(int(id.slice(0,2))) != -1 && (idR1.test(id) || idR2.test(id)))
         {
            return true;
         }
         return false;
      }
      
      public static function cageCheck(value:String) : Boolean
      {
         var year:int = value.slice(0,4);
         var month:int = value.slice(4,6);
         var day:int = value.slice(6);
         var nowDate:Date = new Date();
         if(nowDate.fullYear - year > 18)
         {
            return true;
         }
         if(nowDate.fullYear - year == 18)
         {
            if(nowDate.month + 1 > month)
            {
               return true;
            }
            if(nowDate.month + 1 == month)
            {
               if(nowDate.date >= day)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function replaceHtmlTag(str:String) : String
      {
         str = str.replace(/<(\S*?)[^>]*>|<.*? \/>/g,"");
         return str;
      }
      
      public static function replaceToHtmlText(s:String) : String
      {
         var txt:TextField = new TextField();
         txt.text = s;
         s = replaceHtmlTag(txt.htmlText);
         return s;
      }
      
      public static function getConvertedHtmlArray(str:String) : Array
      {
         return str.match(/&[a-z]*?;/g);
      }
      
      public static function format(str:String, ... args) : String
      {
         var i:* = 0;
         if(args == null || args.length <= 0)
         {
            return str;
         }
         i = uint(0);
         while(i < args.length)
         {
            str = replaceStr(str,"{" + i.toString() + "}",args[i]);
            i++;
         }
         return str;
      }
      
      public static function getConvertedLst(fromCharCode:String) : Array
      {
         return fromCharCode.match(/&[a-z]*?;/g);
      }
      
      public static function trimHtmlText(value:String) : String
      {
         var result:* = null;
         value = trim(value);
         var startIdx:int = 0;
         var endIdx:int = 0;
         var reg:RegExp = /<[\S+]>/g;
         var obj:Object = reg.exec(value);
         var fragments:Vector.<String> = new Vector.<String>();
         while(obj)
         {
            endIdx = obj.index;
            fragments.push(value.substring(startIdx,endIdx));
            fragments.push(obj[0]);
            startIdx = reg.lastIndex;
            obj = reg.exec(value);
         }
         fragments.push(value.substring(startIdx));
         fragments[2] = trimLeft(fragments[2]);
         fragments[fragments.length - 2] = trimRight(fragments[fragments.length - 2]);
         return fragments.join("");
      }
      
      public static function parseMoneyFormat(value:int) : String
      {
         var i:int = 0;
         var tmp:String = reverseString(value.toString());
         var str:String = "";
         for(i = 0; i < tmp.length; )
         {
            if(i != 0 && i % 3 == 0)
            {
               str = str + ",";
            }
            str = str + tmp.charAt(i);
            i++;
         }
         return reverseString(str);
      }
      
      private static function reverseString(value:String) : String
      {
         var i:int = 0;
         var str:String = "";
         for(i = value.length - 1; i >= 0; )
         {
            str = str + value.charAt(i);
            i--;
         }
         return str;
      }
   }
}
