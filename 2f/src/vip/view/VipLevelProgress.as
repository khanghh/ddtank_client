package vip.view
{
   import bagAndInfo.info.LevelProgress;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Graphics;
   
   public class VipLevelProgress extends LevelProgress
   {
       
      
      private var _backBG:ScaleLeftRightImage;
      
      public function VipLevelProgress(){super();}
      
      public function set progressLabelTextFormatStyle(param1:String) : void{}
      
      public function set progressLabelFilterString(param1:String) : void{}
      
      override protected function initView() : void{}
      
      override protected function drawProgress() : void{}
      
      override public function dispose() : void{}
   }
}
