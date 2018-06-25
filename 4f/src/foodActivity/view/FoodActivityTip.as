package foodActivity.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.ITransformableTip;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class FoodActivityTip extends Sprite implements ITransformableTip, Disposeable   {                   protected var _data:Object;            protected var _tipWidth:int;            protected var _tipHeight:int;            protected var _bg:ScaleBitmapImage;            protected var _contentTxt:FilterFrameText;            protected var _awardsTxt:FilterFrameText;            public function FoodActivityTip() { super(); }
            protected function init() : void { }
            public function get tipWidth() : int { return 0; }
            public function set tipWidth(w:int) : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(data:Object) : void { }
            protected function updateTransform() : void { }
            public function get tipHeight() : int { return 0; }
            public function set tipHeight(h:int) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}