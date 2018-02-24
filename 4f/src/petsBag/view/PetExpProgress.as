package petsBag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PetExperience;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   
   public class PetExpProgress extends Component
   {
       
      
      private var _backGround:Bitmap;
      
      private var _gpItem:ScaleLeftRightImage;
      
      private var _maxGpItem:ScaleLeftRightImage;
      
      private var _gpMask:Shape;
      
      private var _maxGpMask:Shape;
      
      private var _gp:Number = 0;
      
      private var _maxGp:Number = 100;
      
      private var _progressLabel:FilterFrameText;
      
      public function PetExpProgress(){super();}
      
      override public function get tipData() : Object{return null;}
      
      private function initView() : void{}
      
      private function creatMask(param1:DisplayObject) : Shape{return null;}
      
      public function setProgress(param1:Number, param2:Number) : void{}
      
      public function noPet() : void{}
      
      private function drawProgress() : void{}
      
      override public function dispose() : void{}
   }
}
