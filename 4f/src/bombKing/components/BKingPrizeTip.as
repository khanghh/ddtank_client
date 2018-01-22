package bombKing.components
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class BKingPrizeTip extends Sprite implements ITransformableTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _label:FilterFrameText;
      
      private var _title:FilterFrameText;
      
      private var _request:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _type:int;
      
      public function BKingPrizeTip(){super();}
      
      private function initView() : void{}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function dispose() : void{}
      
      public function get tipWidth() : int{return 0;}
      
      public function set tipWidth(param1:int) : void{}
      
      public function get tipHeight() : int{return 0;}
      
      public function set tipHeight(param1:int) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
