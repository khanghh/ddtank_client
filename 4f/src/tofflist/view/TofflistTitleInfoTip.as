package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class TofflistTitleInfoTip extends Sprite implements ITransformableTip
   {
       
      
      private var _bg:MutipleImage;
      
      private var _leftView:TofflistTitleInfoItem;
      
      private var _rightView:TofflistTitleInfoItem;
      
      public function TofflistTitleInfoTip(){super();}
      
      private function initView() : void{}
      
      private function initData() : void{}
      
      public function dispose() : void{}
      
      public function get tipWidth() : int{return 0;}
      
      public function set tipWidth(param1:int) : void{}
      
      public function get tipHeight() : int{return 0;}
      
      public function set tipHeight(param1:int) : void{}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
