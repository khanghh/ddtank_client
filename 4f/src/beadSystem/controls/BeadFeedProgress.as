package beadSystem.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class BeadFeedProgress extends Component
   {
       
      
      protected var _background:Bitmap;
      
      protected var _thuck:Component;
      
      protected var _graphics_thuck:Bitmap;
      
      protected var _progressLabel:FilterFrameText;
      
      protected var _star:MovieClip;
      
      private var _progressBarMask:Sprite;
      
      private var _scaleValue:Number;
      
      private var _total:int = 50;
      
      private var _taskFrames:Dictionary;
      
      private var _currentExp:int;
      
      private var _upLevelExp:int;
      
      private var _currentLevel:int;
      
      private var _currentFrame:int;
      
      public function BeadFeedProgress(){super();}
      
      private function intView() : void{}
      
      public function set currentExp(param1:int) : void{}
      
      public function set upLevelExp(param1:int) : void{}
      
      public function resetProgress() : void{}
      
      public function intProgress(param1:InventoryItemInfo) : void{}
      
      public function setProgress(param1:InventoryItemInfo) : void{}
      
      private function startProgress() : void{}
      
      private function __startFrame(param1:Event) : void{}
      
      private function setExpPercent() : void{}
      
      private function setStarVisible(param1:Boolean) : void{}
      
      private function setMask(param1:Number) : void{}
      
      private function initMask() : void{}
      
      override public function dispose() : void{}
   }
}
