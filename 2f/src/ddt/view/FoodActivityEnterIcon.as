package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import foodActivity.FoodActivityManager;
   
   public class FoodActivityEnterIcon extends Sprite implements Disposeable
   {
       
      
      private var _foodActivityIcon:MovieImage;
      
      private var _foodActivityTxt:FilterFrameText;
      
      private var _timeBg:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timeSp:Sprite;
      
      private var _minutesArr:Array;
      
      public function FoodActivityEnterIcon(){super();}
      
      private function initView() : void{}
      
      public function showTxt() : void{}
      
      public function set text(param1:String) : void{}
      
      public function startTime(param1:Boolean = false) : void{}
      
      public function updateTime() : void{}
      
      public function endTime() : void{}
      
      protected function __showFoodActivityFrame(param1:MouseEvent) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
