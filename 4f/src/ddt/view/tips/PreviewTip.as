package ddt.view.tips
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class PreviewTip extends Sprite implements Disposeable, ITransformableTip
   {
       
      
      private var _tipData:Object;
      
      public function PreviewTip(){super();}
      
      public function get tipWidth() : int{return 0;}
      
      public function set tipWidth(param1:int) : void{}
      
      public function get tipHeight() : int{return 0;}
      
      public function set tipHeight(param1:int) : void{}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
