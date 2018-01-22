package horse.horsePicCherish
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.SimpleItem;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class HorsePicCherishTip extends Sprite implements ITransformableTip
   {
       
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _typeItem:SimpleItem;
      
      protected var _title:FilterFrameText;
      
      protected var _valid:FilterFrameText;
      
      private var _rule:ScaleBitmapImage;
      
      private var _rule2:ScaleBitmapImage;
      
      protected var _data:Object;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      private var _vBox:VBox;
      
      private var _itemVec:Vector.<HorsePicCherishTipItem>;
      
      public function HorsePicCherishTip(){super();}
      
      protected function init() : void{}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      private function isActivate() : Boolean{return false;}
      
      private function update() : void{}
      
      public function get tipWidth() : int{return 0;}
      
      public function set tipWidth(param1:int) : void{}
      
      public function get tipHeight() : int{return 0;}
      
      public function set tipHeight(param1:int) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
