package gameCommon.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.ItemEvent;
   import ddt.view.PropItemView;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import gameCommon.GameControl;
   
   [Event(name="itemClick",type="tank.view.items.ItemEvent")]
   [Event(name="itemOver",type="tank.view.items.ItemEvent")]
   [Event(name="itemOut",type="tank.view.items.ItemEvent")]
   [Event(name="itemMove",type="tank.view.items.ItemEvent")]
   public class ItemCellView extends Sprite implements Disposeable
   {
      
      public static const RIGHT_PROP:String = "rightPropView";
      
      public static const PROP_SHORT:String = "propShortCutView";
       
      
      protected var _item:DisplayObject;
      
      protected var _asset:Bitmap;
      
      private var _index:uint;
      
      private var _clickAble:Boolean;
      
      private var _isDisable:Boolean;
      
      private var _isGray:Boolean;
      
      private var _container:Sprite;
      
      private var _letterTip:Bitmap;
      
      private var _effectType:String;
      
      public function ItemCellView(param1:uint = 0, param2:DisplayObject = null, param3:Boolean = false, param4:String = ""){super();}
      
      public function setClick(param1:Boolean, param2:Boolean, param3:Boolean) : void{}
      
      protected function initItemBg() : void{}
      
      private function setEffectType(param1:String) : void{}
      
      override public function get height() : Number{return 0;}
      
      private function __click(param1:MouseEvent) : void{}
      
      public function mouseClick() : void{}
      
      private function __over(param1:Event) : void{}
      
      private function __out(param1:Event) : void{}
      
      private function showEffect() : void{}
      
      private function hideEffect() : void{}
      
      private function __effectEnd() : void{}
      
      private function __move(param1:MouseEvent) : void{}
      
      public function get item() : DisplayObject{return null;}
      
      public function setItem(param1:DisplayObject, param2:Boolean) : void{}
      
      protected function setItemWidthAndHeight() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function seleted(param1:Boolean) : void{}
      
      public function disable() : void{}
      
      public function get index() : int{return 0;}
      
      public function setBackgroundVisible(param1:Boolean) : void{}
      
      public function setGrayII(param1:Boolean, param2:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
