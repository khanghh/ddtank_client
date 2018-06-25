package store.view.embed{   import com.pickgliss.geom.InnerRectangle;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.view.tips.GoodTip;   import ddt.view.tips.GoodTipInfo;   import flash.display.DisplayObject;   import flash.geom.Rectangle;   import flash.text.TextField;      public class EmbedStoneTip extends GoodTip   {            public static const P_backgoundInnerRect:String = "backOutterRect";            public static const P_tipTextField:String = "tipTextField";                   protected var _backInnerRect:InnerRectangle;            protected var _backgoundInnerRectString:String;            protected var _tipTextField:TextField;            protected var _tipTextStyle:String;            private var _currentData:Object;            public function EmbedStoneTip() { super(); }
            public function set backgoundInnerRectString(value:String) : void { }
            override public function dispose() : void { }
            public function set tipTextField(field:TextField) : void { }
            public function set tipTextStyle(stylename:String) : void { }
            override protected function addChildren() : void { }
            override public function get tipData() : Object { return null; }
            override public function set tipData(data:Object) : void { }
   }}