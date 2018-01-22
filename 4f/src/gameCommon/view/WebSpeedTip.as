package gameCommon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import room.model.WebSpeedInfo;
   
   public class WebSpeedTip extends BaseTip
   {
       
      
      private var _tempData:Object;
      
      private var _bg:ScaleBitmapImage;
      
      private var _stateTxt:FilterFrameText;
      
      private var _delayTxt:FilterFrameText;
      
      private var _fpsTxt:FilterFrameText;
      
      private var _explain1:FilterFrameText;
      
      private var _explain2:FilterFrameText;
      
      private var _container:Sprite;
      
      public function WebSpeedTip(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      override public function get tipData() : Object{return null;}
      
      override public function set tipData(param1:Object) : void{}
      
      private function reset() : void{}
      
      private function drawBG(param1:int = 0) : void{}
      
      override public function dispose() : void{}
   }
}
