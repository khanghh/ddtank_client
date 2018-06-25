package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;      public class FineSuitTipsItem extends Sprite implements Disposeable   {                   private var _title:FilterFrameText;            private var _text:FilterFrameText;            private var _image:ScaleFrameImage;            private var _type:int;            public function FineSuitTipsItem() { super(); }
            public function set type(type:int) : void { }
            public function set complete(value:Boolean) : void { }
            public function set titleText(value:String) : void { }
            public function set text(value:String) : void { }
            public function dispose() : void { }
   }}