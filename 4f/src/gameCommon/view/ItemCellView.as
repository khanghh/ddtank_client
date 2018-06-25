package gameCommon.view{   import com.greensock.TweenMax;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.ItemEvent;   import ddt.view.PropItemView;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.filters.ColorMatrixFilter;   import gameCommon.GameControl;      [Event(name="itemClick",type="tank.view.items.ItemEvent")]   [Event(name="itemOver",type="tank.view.items.ItemEvent")]   [Event(name="itemOut",type="tank.view.items.ItemEvent")]   [Event(name="itemMove",type="tank.view.items.ItemEvent")]   public class ItemCellView extends Sprite implements Disposeable   {            public static const RIGHT_PROP:String = "rightPropView";            public static const PROP_SHORT:String = "propShortCutView";                   protected var _item:DisplayObject;            protected var _asset:Bitmap;            private var _index:uint;            private var _clickAble:Boolean;            private var _isDisable:Boolean;            private var _isGray:Boolean;            private var _container:Sprite;            private var _letterTip:Bitmap;            private var _effectType:String;            public function ItemCellView(index:uint = 0, item:DisplayObject = null, isCount:Boolean = false, EffectType:String = "") { super(); }
            public function setClick(clickAble:Boolean, isGray:Boolean, isExist:Boolean) : void { }
            protected function initItemBg() : void { }
            private function setEffectType(EffectType:String) : void { }
            override public function get height() : Number { return 0; }
            private function __click(event:MouseEvent) : void { }
            public function mouseClick() : void { }
            private function __over(event:Event) : void { }
            private function __out(event:Event) : void { }
            private function showEffect() : void { }
            private function hideEffect() : void { }
            private function __effectEnd() : void { }
            private function __move(event:MouseEvent) : void { }
            public function get item() : DisplayObject { return null; }
            public function setItem(value:DisplayObject, isGray:Boolean) : void { }
            protected function setItemWidthAndHeight() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            public function seleted(value:Boolean) : void { }
            public function disable() : void { }
            public function get index() : int { return 0; }
            public function setBackgroundVisible(value:Boolean) : void { }
            public function setGrayII(isGray:Boolean, isExist:Boolean) : void { }
            public function dispose() : void { }
   }}