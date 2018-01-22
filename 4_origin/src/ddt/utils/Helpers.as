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
      
      public static function setTextfieldFormat(param1:TextField, param2:Object, param3:Boolean = false) : void
      {
         var _loc4_:TextFormat = param1.getTextFormat();
         var _loc7_:int = 0;
         var _loc6_:* = param2;
         for(var _loc5_ in param2)
         {
            _loc4_[_loc5_] = param2[_loc5_] || _loc4_[_loc5_];
         }
         if(param3)
         {
            param1.setTextFormat(_loc4_);
         }
         param1.defaultTextFormat = _loc4_;
      }
      
      public static function hidePosMc(param1:DisplayObjectContainer) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:RegExp = /_pos$/;
         _loc4_ = 0;
         while(_loc4_ < param1.numChildren)
         {
            _loc2_ = param1.getChildAt(_loc4_);
            if(_loc3_.test(_loc2_.name))
            {
               _loc2_.visible = false;
            }
            _loc4_++;
         }
      }
      
      public static function registExtendMouseEvent(param1:InteractiveObject) : void
      {
         param1.addEventListener("mouseDown",__dobjDown);
      }
      
      private static function __dobjDown(param1:MouseEvent) : void
      {
         e = param1;
         var dobj:InteractiveObject = e.currentTarget as InteractiveObject;
         var fun_up:Function = function(param1:MouseEvent):void
         {
            dobj.dispatchEvent(new Event("STAGE_UP_EVENT"));
            dobj.stage.removeEventListener("mouseUp",fun_up);
            dobj.stage.removeEventListener("mouseMove",fun_move);
         };
         var fun_move:Function = function(param1:MouseEvent):void
         {
            dobj.dispatchEvent(new Event("MOUSE_DOWN_AND_DRAGING_EVENT"));
         };
         dobj.stage.addEventListener("mouseUp",fun_up);
         dobj.stage.addEventListener("mouseMove",fun_move);
      }
      
      public static function delayCall(param1:Function, param2:int = 1) : void
      {
         fun = param1;
         delay_frame = param2;
         var fun_new:Function = function(param1:Event):void
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
      
      public static function copyProperty(param1:Object, param2:Object, param3:Array = null) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = param3;
         for each(var _loc4_ in param3)
         {
            param2[_loc4_] = param1[_loc4_];
         }
      }
      
      public static function enCodeString(param1:String) : String
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < encode_arr.length)
         {
            param1 = param1.replace(new RegExp(encode_arr[_loc2_][0],"g"),encode_arr[_loc2_][1]);
            _loc2_++;
         }
         return param1;
      }
      
      public static function deCodeString(param1:String) : String
      {
         var _loc2_:int = 0;
         _loc2_ = decode_arr.length - 1;
         while(_loc2_ >= 0)
         {
            param1 = param1.replace(new RegExp(decode_arr[_loc2_][1],"g"),decode_arr[_loc2_][0]);
            _loc2_--;
         }
         return param1;
      }
      
      public static function setup(param1:Stage) : void
      {
         _stage = param1;
      }
      
      public static function randomPick(param1:Array) : *
      {
         var _loc3_:int = param1.length;
         var _loc2_:int = Math.floor(_loc3_ * Math.random());
         return param1[_loc2_];
      }
      
      public static function clone(param1:Object) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function grey(param1:DisplayObject) : void
      {
         var _loc2_:Array = [];
         _loc2_ = _loc2_.concat([0.3086,0.6094,0.082,0,0]);
         _loc2_ = _loc2_.concat([0.3086,0.6094,0.082,0,0]);
         _loc2_ = _loc2_.concat([0.3086,0.6094,0.082,0,0]);
         _loc2_ = _loc2_.concat([0,0,0,1,0]);
         var _loc4_:ColorMatrixFilter = new ColorMatrixFilter(_loc2_);
         var _loc3_:Array = [];
         _loc3_.push(_loc4_);
         param1.filters = _loc3_;
      }
      
      public static function colorful(param1:DisplayObject) : void
      {
         param1.filters = [];
      }
      
      public static function setHue(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:ColorMatrix = new ColorMatrix();
         var _loc4_:ColorMatrixFilter = new ColorMatrixFilter();
         _loc3_.adjustHue(param2);
         _loc4_.matrix = _loc3_;
         param1.filters = [_loc4_];
      }
      
      public static function resetHue(param1:DisplayObject) : void
      {
         param1.filters = [];
      }
      
      public static function getTimeString(param1:Number, param2:String = "") : String
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc10_:* = null;
         var _loc9_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = null;
         param1 = Math.max(0,param1);
         if(param2 == "cn")
         {
            _loc6_ = "天";
            _loc4_ = "小时";
            _loc10_ = "分";
            _loc9_ = "秒";
         }
         else if(param2 == "")
         {
            _loc6_ = " ";
            _loc4_ = ":";
            _loc10_ = ":";
            _loc9_ = "";
         }
         _loc7_ = String(Math.floor(param1 / 1000 % 60));
         _loc3_ = String(Math.floor(param1 / 60000 % 60));
         _loc8_ = String(Math.floor(param1 / 3600000 % 24));
         _loc5_ = String(Math.floor(param1 / 86400000));
         _loc7_ = fixZero(_loc7_) + _loc9_;
         _loc3_ = fixZero(_loc3_) + _loc10_;
         _loc8_ = fixZero(_loc8_) + _loc4_;
         _loc5_ = _loc5_ == "0"?"":fixZero(_loc5_) + _loc6_;
         return _loc5_ + _loc8_ + _loc3_ + _loc7_;
      }
      
      public static function fixZero(param1:String) : String
      {
         if(param1.length == 1)
         {
            param1 = "0" + param1;
         }
         return param1;
      }
      
      public static function scaleDisplayObject(param1:DisplayObject, param2:*, param3:*, param4:Number = 0) : void
      {
         if(param2 != null && param3 == null)
         {
            param1.width = param2;
            param1.height = param1.scaleX * param1.height;
         }
         else if(param2 == null && param3 != null)
         {
            param1.height = param3;
            param1.width = param1.scaleY * param1.width;
         }
         else if(param2 == null && param3 == null && param4 > 0)
         {
            if(param1.width < param1.height)
            {
               scaleDisplayObject(param1,param4,null);
            }
            else
            {
               scaleDisplayObject(param1,null,param4);
            }
         }
      }
      
      public static function spaceString(param1:Number, param2:Number = 8) : String
      {
         var _loc5_:int = 0;
         var _loc3_:String = "";
         var _loc4_:int = param1 / param2;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc3_ + " ";
            _loc5_++;
         }
         return _loc3_;
      }
   }
}
