package guardCore.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import guardCore.data.GuardCoreInfo;      public class GuardCoreBuffTipsItem extends Sprite implements Disposeable   {                   private var _info:GuardCoreInfo;            private var _icon:Bitmap;            private var _name:FilterFrameText;            public function GuardCoreBuffTipsItem(info:GuardCoreInfo) { super(); }
            private function init() : void { }
            public function get info() : GuardCoreInfo { return null; }
            public function dispose() : void { }
   }}