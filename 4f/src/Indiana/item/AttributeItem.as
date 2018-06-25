package Indiana.item{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.text.TextFormat;      public class AttributeItem extends Sprite implements Disposeable   {                   private var _bg:ScaleBitmapImage;            private var _txt:FilterFrameText;            public function AttributeItem(fontstyle:String = "indiana.attribute.Txt") { super(); }
            public function setWidth(value:int) : void { }
            public function setView(_view:DisplayObject) : void { }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
            public function set fontColor(color:int) : void { }
            public function set Filter(_filter:Array) : void { }
            public function get textField() : FilterFrameText { return null; }
            public function setDis(str:String) : void { }
            public function dispose() : void { }
   }}