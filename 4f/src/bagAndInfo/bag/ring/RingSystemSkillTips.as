package bagAndInfo.bag.ring
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class RingSystemSkillTips extends Sprite implements ITransformableTip, Disposeable
   {
       
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _name:FilterFrameText;
      
      protected var _contentTxt:FilterFrameText;
      
      private var _line:Image;
      
      private var _nextLevel:FilterFrameText;
      
      private var _limitLevel:FilterFrameText;
      
      protected var _data:Object;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      public function RingSystemSkillTips(){super();}
      
      protected function init() : void{}
      
      public function set tipData(param1:Object) : void{}
      
      public function get tipData() : Object{return null;}
      
      public function get tipWidth() : int{return 0;}
      
      public function set tipWidth(param1:int) : void{}
      
      public function get tipHeight() : int{return 0;}
      
      public function set tipHeight(param1:int) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
