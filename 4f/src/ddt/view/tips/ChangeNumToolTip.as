package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class ChangeNumToolTip extends BaseTip implements ITransformableTip
   {
       
      
      private var _title:FilterFrameText;
      
      private var _currentTxt:FilterFrameText;
      
      private var _totalTxt:FilterFrameText;
      
      private var _contentTxt:FilterFrameText;
      
      private var _container:Sprite;
      
      private var _tempData:Object;
      
      private var _bg:ScaleBitmapImage;
      
      public function ChangeNumToolTip(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      override public function get tipData() : Object{return null;}
      
      override public function set tipData(param1:Object) : void{}
      
      private function update(param1:FilterFrameText, param2:String, param3:int, param4:int, param5:String) : void{}
      
      private function reset() : void{}
      
      private function drawBG(param1:int = 0) : void{}
      
      public function get tipWidth() : int{return 0;}
      
      public function set tipWidth(param1:int) : void{}
      
      public function get tipHeight() : int{return 0;}
      
      public function set tipHeight(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
