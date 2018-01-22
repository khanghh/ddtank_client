package enchant.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class EnchantExpBar extends Component
   {
       
      
      private var _progressBg:Bitmap;
      
      private var _progressColorBg:Bitmap;
      
      private var _progressBarMask:Sprite;
      
      private var _scaleValue:Number;
      
      private var _total:int = 50;
      
      private var _currentFrame:int;
      
      private var _destFrame:int;
      
      private var _isUpGrade:Boolean;
      
      private var _curExp:int;
      
      private var _sumExp:int;
      
      private var _starMc:MovieClip;
      
      private var _progressCompleteMc:MovieClip;
      
      private var _progressTxt:FilterFrameText;
      
      public var upGradeFunc:Function;
      
      public function EnchantExpBar(){super();}
      
      private function initView() : void{}
      
      public function initPercentAndTip() : void{}
      
      public function initProgress(param1:Number, param2:Number) : void{}
      
      public function setExpPercent(param1:Number, param2:Number) : void{}
      
      public function setMask(param1:Number) : void{}
      
      public function updateProgress(param1:int, param2:int, param3:Boolean = false) : void{}
      
      protected function __frameHandler(param1:Event) : void{}
      
      protected function __completeFrameHandler(param1:Event) : void{}
      
      private function removeProgressCompleteMc() : void{}
      
      private function showProgressCompleteMc() : void{}
      
      override public function dispose() : void{}
   }
}
