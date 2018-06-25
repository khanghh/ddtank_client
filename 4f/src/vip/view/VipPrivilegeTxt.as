package vip.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.text.TextArea;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;      public class VipPrivilegeTxt extends Sprite implements Disposeable   {                   private var _content:TextArea;            public function VipPrivilegeTxt() { super(); }
            private function initView() : void { }
            public function set AlertContent(_vipLev:int) : void { }
            private function getAlerTxt(lev:int) : MovieImage { return null; }
            public function dispose() : void { }
   }}