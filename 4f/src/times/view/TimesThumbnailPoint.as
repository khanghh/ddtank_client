package times.view
{
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import com.greensock.easing.Circ;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import times.TimesController;
   import times.data.TimesEvent;
   import times.data.TimesPicInfo;
   
   public class TimesThumbnailPoint extends Sprite implements ISelectable, ITipedDisplay, Disposeable
   {
      
      public static const THUMBNAIL_POINT_MAIN:int = 0;
      
      public static const THUMBNAIL_POINT_CATEGORY:int = 1;
      
      public static const THUMBNAIL_POINT_NORMAL:int = 2;
       
      
      private var _controller:TimesController;
      
      private var _point:MovieClip;
      
      private var _info:TimesPicInfo;
      
      private var _type:int;
      
      private var _selected:Boolean;
      
      private var _tipData:Object;
      
      private var _tipDirections:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String;
      
      private var _lineLite:TimelineLite;
      
      public function TimesThumbnailPoint(param1:TimesPicInfo){super();}
      
      private function init() : void{}
      
      public function pointPlay(param1:Object) : void{}
      
      public function pointStop(param1:Object) : void{}
      
      private function __overEffect(param1:MouseEvent) : void{}
      
      private function __outEffect(param1:MouseEvent) : void{}
      
      private function __pointClick(param1:MouseEvent) : void{}
      
      public function set autoSelect(param1:Boolean) : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function get tipDirctions() : String{return null;}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipGapH(param1:int) : void{}
      
      public function get tipGapV() : int{return 0;}
      
      public function set tipGapV(param1:int) : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function set tipStyle(param1:String) : void{}
      
      public function dispose() : void{}
   }
}
