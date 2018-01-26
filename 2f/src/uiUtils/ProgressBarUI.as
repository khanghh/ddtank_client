package uiUtils
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ProgressBarUI extends Component
   {
      
      public static const P_BACK:String = "back";
      
      public static const P_PROGRESS:String = "progress";
      
      public static const P_TEXT:String = "text";
      
      public static const NO_VIEW:String = "noView";
      
      public static const NORMAL_VIEW:String = "normalView";
      
      public static const MAX_VIEW:String = "maxView";
      
      public static const REAL_VIEW:String = "realView";
      
      public static const RATIO_VIEW:String = "ratioView";
      
      public static const NO_ACTION:String = "noAction";
      
      public static const FADE_OUT_ACTION:String = "fadeOutAction";
      
      public static const SLOW_ACTION:String = "slowAction";
       
      
      private var _actionType:String = "noAction";
      
      private var _tipViewType:String = "realView";
      
      private var _textViewType:String = "ratioView";
      
      private var _backStyleName:String;
      
      private var _progressStyleName:String;
      
      private var _textStyleName:String;
      
      private var _ratio:int = 100;
      
      private var _offsetX:int = 0;
      
      private var _offsetY:int = 0;
      
      private var _progress:Number = 0;
      
      private var _maxProgress:Number = 0;
      
      private var _lastProgress:Number = 0;
      
      private var _time:Number = 2;
      
      private var _mark:Shape;
      
      private var _backDisplay:DisplayObject;
      
      private var _progressDisplay:DisplayObject;
      
      private var _acitonSprite:Sprite;
      
      private var _textLabel:FilterFrameText;
      
      public function ProgressBarUI(){super();}
      
      public function set progress(param1:Number) : void{}
      
      public function set maxProgress(param1:Number) : void{}
      
      public function set actionType(param1:String) : void{}
      
      public function set tipViewType(param1:String) : void{}
      
      public function set textViewType(param1:String) : void{}
      
      public function set ratio(param1:int) : void{}
      
      public function set offsetX(param1:int) : void{}
      
      public function set offsetY(param1:int) : void{}
      
      override protected function addChildren() : void{}
      
      protected function updateProgressBarOffset() : void{}
      
      protected function updateProgressBarMark() : void{}
      
      protected function updateTextTips() : void{}
      
      protected function updateAction() : void{}
      
      protected function createFadeOutAciton() : void{}
      
      public function set backStyleName(param1:String) : void{}
      
      public function set progressStyleName(param1:String) : void{}
      
      public function set textStyleName(param1:String) : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      override public function dispose() : void{}
   }
}
