package ddt.utils
{
   import com.gskinner.geom.ColorMatrix;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class Helpers
   {
      
      private static var _stage:Stage;
      
      public static const STAGE_UP_EVENT:String = "STAGE_UP_EVENT";
      
      public static const MOUSE_DOWN_AND_DRAGING_EVENT:String = "MOUSE_DOWN_AND_DRAGING_EVENT";
      
      private static var enterFrameDispatcher:Sprite = new Sprite();
      
      private static const encode_arr:Array = [["%","%01"],["]","%02"],["\\[","%03"]];
      
      private static const decode_arr:Array = [["%","%01"],["]","%02"],["[","%03"]];
       
      
      public function Helpers()
      {
         super();
      }
      
      public static function setTextfieldFormat(textfield:TextField, chageObject:Object, setAll:Boolean = false) : void
      {
         var textformat:TextFormat = textfield.getTextFormat();
         var _loc7_:int = 0;
         var _loc6_:* = chageObject;
         for(var i in chageObject)
         {
            textformat[i] = chageObject[i] || textformat[i];
         }
         if(setAll)
         {
            textfield.setTextFormat(textformat);
         }
         textfield.defaultTextFormat = textformat;
      }
      
      public static function hidePosMc(object:DisplayObjectContainer) : void
      {
         var child:* = null;
         var i:int = 0;
         var reg:RegExp = /_pos$/;
         for(i = 0; i < object.numChildren; )
         {
            child = object.getChildAt(i);
            if(reg.test(child.name))
            {
               child.visible = false;
            }
            i++;
         }
      }
      
      public static function registExtendMouseEvent(dobj:InteractiveObject) : void
      {
         dobj.addEventListener("mouseDown",__dobjDown);
      }
      
      private static function __dobjDown(e:MouseEvent) : void
      {
         e = e;
         var dobj:InteractiveObject = e.currentTarget as InteractiveObject;
         var fun_up:Function = function(e:MouseEvent):void
         {
            dobj.dispatchEvent(new Event("STAGE_UP_EVENT"));
            dobj.stage.removeEventListener("mouseUp",fun_up);
            dobj.stage.removeEventListener("mouseMove",fun_move);
         };
         var fun_move:Function = function(e:MouseEvent):void
         {
            dobj.dispatchEvent(new Event("MOUSE_DOWN_AND_DRAGING_EVENT"));
         };
         dobj.stage.addEventListener("mouseUp",fun_up);
         dobj.stage.addEventListener("mouseMove",fun_move);
      }
      
      public static function delayCall(fun:Function, delay_frame:int = 1) : void
      {
         fun = fun;
         delay_frame = delay_frame;
         var fun_new:Function = function(e:Event):void
         {
            delay_frame = delay_frame - 1;
            if(delay_frame - 1 <= 0)
            {
               fun();
               enterFrameDispatcher.removeEventListener("enterFrame",fun_new);
            }
         };
         enterFrameDispatcher.addEventListener("enterFrame",fun_new);
      }
      
      public static function copyProperty(from_obja:Object, to_objb:Object, propertiy:Array = null) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = propertiy;
         for each(var i in propertiy)
         {
            to_objb[i] = from_obja[i];
         }
      }
      
      public static function enCodeString(str:String) : String
      {
         var i:int = 0;
         for(i = 0; i < encode_arr.length; )
         {
            str = str.replace(new RegExp(encode_arr[i][0],"g"),encode_arr[i][1]);
            i++;
         }
         return str;
      }
      
      public static function deCodeString(str:String) : String
      {
         var i:int = 0;
         for(i = decode_arr.length - 1; i >= 0; )
         {
            str = str.replace(new RegExp(decode_arr[i][1],"g"),decode_arr[i][0]);
            i--;
         }
         return str;
      }
      
      public static function setup(stage:Stage) : void
      {
         _stage = stage;
      }
      
      public static function randomPick(arr:Array) : *
      {
         var len:int = arr.length;
         var index:int = Math.floor(len * Math.random());
         return arr[index];
      }
      
      public static function clone(source:Object) : *
      {
         var byteArr:ByteArray = new ByteArray();
         byteArr.writeObject(source);
         byteArr.position = 0;
         return byteArr.readObject();
      }
      
      public static function grey(target:DisplayObject) : void
      {
         var matrix:Array = [];
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0,0,0,1,0]);
         var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
         var filters:Array = [];
         filters.push(filter);
         target.filters = filters;
      }
      
      public static function colorful(target:DisplayObject) : void
      {
         target.filters = [];
      }
      
      public static function setHue(target:DisplayObject, hueValue:int) : void
      {
         var sx_Matrix:ColorMatrix = new ColorMatrix();
         var sx_Filter:ColorMatrixFilter = new ColorMatrixFilter();
         sx_Matrix.adjustHue(hueValue);
         sx_Filter.matrix = sx_Matrix;
         target.filters = [sx_Filter];
      }
      
      public static function resetHue(target:DisplayObject) : void
      {
         target.filters = [];
      }
      
      public static function getTimeString(time:Number, type:String = "") : String
      {
         var dUnit:* = null;
         var hUnit:* = null;
         var mUnit:* = null;
         var sUnit:* = null;
         var seconds:* = null;
         var minutes:* = null;
         var hours:* = null;
         var days:* = null;
         time = Math.max(0,time);
         if(type == "cn")
         {
            dUnit = "天";
            hUnit = "小时";
            mUnit = "分";
            sUnit = "秒";
         }
         else if(type == "")
         {
            dUnit = " ";
            hUnit = ":";
            mUnit = ":";
            sUnit = "";
         }
         seconds = String(Math.floor(time / 1000 % 60));
         minutes = String(Math.floor(time / 60000 % 60));
         hours = String(Math.floor(time / 3600000 % 24));
         days = String(Math.floor(time / 86400000));
         seconds = fixZero(seconds) + sUnit;
         minutes = fixZero(minutes) + mUnit;
         hours = fixZero(hours) + hUnit;
         days = days == "0"?"":fixZero(days) + dUnit;
         return days + hours + minutes + seconds;
      }
      
      public static function fixZero(str:String) : String
      {
         if(str.length == 1)
         {
            str = "0" + str;
         }
         return str;
      }
      
      public static function scaleDisplayObject($displayObject:DisplayObject, $width:*, $height:*, scaleTo:Number = 0) : void
      {
         if($width != null && $height == null)
         {
            $displayObject.width = $width;
            $displayObject.height = $displayObject.scaleX * $displayObject.height;
         }
         else if($width == null && $height != null)
         {
            $displayObject.height = $height;
            $displayObject.width = $displayObject.scaleY * $displayObject.width;
         }
         else if($width == null && $height == null && scaleTo > 0)
         {
            if($displayObject.width < $displayObject.height)
            {
               scaleDisplayObject($displayObject,scaleTo,null);
            }
            else
            {
               scaleDisplayObject($displayObject,null,scaleTo);
            }
         }
      }
      
      public static function spaceString(stringWidth:Number, spaceWidth:Number = 8) : String
      {
         var i:int = 0;
         var spaceString:String = "";
         var len:int = stringWidth / spaceWidth;
         for(i = 0; i < len; )
         {
            spaceString = spaceString + " ";
            i++;
         }
         return spaceString;
      }
   }
}
