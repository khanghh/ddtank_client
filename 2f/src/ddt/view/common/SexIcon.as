package ddt.view.common{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import flash.display.Sprite;      public class SexIcon extends Sprite implements Disposeable   {                   private var _sexIcon:ScaleFrameImage;            private var _sex:Boolean;            public function SexIcon(sex:Boolean = true) { super(); }
            public function setSex(sex:Boolean) : void { }
            public function set size(value:Number) : void { }
            public function dispose() : void { }
   }}