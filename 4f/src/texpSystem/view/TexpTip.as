package texpSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import texpSystem.controller.TexpManager;
   import texpSystem.data.TexpInfo;
   
   public class TexpTip extends Sprite implements ITransformableTip
   {
      
      public static const NAME_COLOR:Array = [2417048,15938098,3586815,6938624,16756224];
       
      
      private var _tipData:TexpInfo;
      
      private var _tipWidth:int;
      
      private var _tipHeight:int;
      
      private var _bg:ScaleBitmapImage;
      
      private var _name:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      public function TexpTip(){super();}
      
      private function init() : void{}
      
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
