package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class HallBuildTip extends Sprite implements ITransformableTip
   {
       
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _contentTxt:FilterFrameText;
      
      protected var _title:FilterFrameText;
      
      private var _rule:ScaleBitmapImage;
      
      protected var _data:Object;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      public function HallBuildTip(){super();}
      
      protected function init() : void{}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      private function update() : void{}
      
      public function get tipWidth() : int{return 0;}
      
      public function set tipWidth(param1:int) : void{}
      
      public function get tipHeight() : int{return 0;}
      
      public function set tipHeight(param1:int) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
