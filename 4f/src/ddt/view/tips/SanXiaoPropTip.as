package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.ITransformableTip;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class SanXiaoPropTip extends Sprite implements ITransformableTip, Disposeable   {                   private var _width:Number = 251;            private var _height:Number = 82;            private var _isDiscount:Boolean;            private var _data:Object;            private var _bg:ScaleBitmapImage;            private var _detail:FilterFrameText;            private var _cost:FilterFrameText;            private var _discount:FilterFrameText;            private var _separator:Image;            public function SanXiaoPropTip() { super(); }
            public function get tipWidth() : int { return 0; }
            public function set tipWidth(w:int) : void { }
            public function get tipHeight() : int { return 0; }
            public function set tipHeight(h:int) : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(data:Object) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}