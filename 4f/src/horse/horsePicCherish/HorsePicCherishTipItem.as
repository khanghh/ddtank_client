package horse.horsePicCherish{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;      public class HorsePicCherishTipItem extends Sprite implements Disposeable   {                   private var _nameTxt:FilterFrameText;            private var _valueTxt:FilterFrameText;            private var _type:int;            private var _isActive:Boolean;            public function HorsePicCherishTipItem(type:int) { super(); }
            private function initView() : void { }
            public function set isActive(value:Boolean) : void { }
            public function set value(txt:String) : void { }
            public function dispose() : void { }
   }}