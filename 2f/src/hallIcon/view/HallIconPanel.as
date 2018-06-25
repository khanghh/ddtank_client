package hallIcon.view{   import com.greensock.TweenLite;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import hallIcon.HallIconManager;      public class HallIconPanel extends Sprite implements Disposeable   {            public static const LEFT:String = "left";            public static const RIGHT:String = "right";            public static const BOTTOM:String = "bottom";                   private var _mainIcon:DisplayObject;            private var _mainIconString:String;            private var _hotNumBg:Bitmap;            private var _hotNum:FilterFrameText;            private var _iconArray:Array;            private var _iconBox:HallIconBox;            private var direction:String;            private var vNum:int;            private var hNum:int;            private var WHSize:Array;            private var tweenLiteMax:TweenLite;            private var tweenLiteSmall:TweenLite;            private var isExpand:Boolean;            public function HallIconPanel($mainIconString:String, $direction:String = "left", $hNum:int = -1, $vNum:int = -1, $WHSize:Array = null) { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            public function addIcon($icon:DisplayObject, $icontype:String, $orderId:int = 0, flag:Boolean = false) : DisplayObject { return null; }
            public function getIconByType($icontype:String) : DisplayObject { return null; }
            public function removeIconByType($icontype:String) : void { }
            public function arrange() : void { }
            private function updateIconsPos() : void { }
            private function updateDirectionPos() : void { }
            public function iconSortOn() : void { }
            private function sortFunctin(a:Object, b:Object) : Number { return 0; }
            public function expand($isBool:Boolean) : void { }
            private function tweenLiteSmallCloseComplete() : void { }
            private function tweenLiteMaxCloseComplete() : void { }
            private function getIconSpriteWidth() : Number { return 0; }
            private function getIconSpriteHeight() : Number { return 0; }
            public function removeChildrens() : void { }
            private function __mainIconHandler(evt:MouseEvent) : void { }
            private function updateHotNum() : void { }
            public function get mainIcon() : DisplayObject { return null; }
            public function get count() : int { return 0; }
            override public function get height() : Number { return 0; }
            override public function get width() : Number { return 0; }
            private function killTweenLiteMax() : void { }
            private function killTweenLiteSmall() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}