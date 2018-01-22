package hallIcon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import hallIcon.info.HallIconInfo;
   
   public class HallIcon extends Sprite implements Disposeable, ITipedDisplay
   {
      
      public static const WONDERFULPLAY:int = 1;
      
      public static const ACTIVITY:int = 2;
       
      
      private var _timeTxt:FilterFrameText;
      
      private var _glowMovie:MovieClip;
      
      private var _icon:DisplayObject;
      
      private var _iconString:String;
      
      private var _iconNumBg:Bitmap;
      
      private var _iconTxt:FilterFrameText;
      
      private var _tipStyle:String;
      
      private var _tipDirctions:String;
      
      private var _tipData:Object;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      public var iconInfo:HallIconInfo;
      
      public function HallIcon(param1:String, param2:HallIconInfo){super();}
      
      public function initView() : void{}
      
      public function updateIcon(param1:HallIconInfo) : void{}
      
      private function setTimeTxt(param1:String) : void{}
      
      private function setGlow(param1:Boolean) : void{}
      
      private function setFightState(param1:Boolean) : void{}
      
      private function setNumShow(param1:int) : void{}
      
      private function buttonCursorMode(param1:Boolean) : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function get tipData() : Object{return null;}
      
      public function get tipDirctions() : String{return null;}
      
      public function get tipGapV() : int{return 0;}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipStyle(param1:String) : void{}
      
      public function set tipData(param1:Object) : void{}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function set tipGapV(param1:int) : void{}
      
      public function set tipGapH(param1:int) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
