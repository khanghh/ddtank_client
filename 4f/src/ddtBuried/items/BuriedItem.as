package ddtBuried.items{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;      public class BuriedItem extends Sprite implements Disposeable   {                   private var _txt:FilterFrameText;            private var _back:Bitmap;            private var _icon:Bitmap;            public function BuriedItem(txtstr:String, icon:String) { super(); }
            private function initView(txtstr:String, icon:String) : void { }
            public function upDateTxt(str:String) : void { }
            public function dispose() : void { }
   }}