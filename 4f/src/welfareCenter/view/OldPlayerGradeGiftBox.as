package welfareCenter.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class OldPlayerGradeGiftBox extends BaseButton
   {
       
      
      private var _gainBg:Bitmap;
      
      private var _isGain:Boolean;
      
      private var _shine:MovieClip;
      
      private var _isShine:Boolean;
      
      public function OldPlayerGradeGiftBox(){super();}
      
      override protected function addChildren() : void{}
      
      public function set isGain(param1:Boolean) : void{}
      
      public function set isShine(param1:Boolean) : void{}
      
      public function get isShine() : Boolean{return false;}
      
      public function get isGain() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
