package vip.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;      public class RechargeAlertTxt extends Sprite implements Disposeable   {                   private var _bg:Scale9CornerImage;            private var _title:FilterFrameText;            private var _content:FilterFrameText;            public function RechargeAlertTxt() { super(); }
            private function initView() : void { }
            public function set AlertContent(vipLev:int) : void { }
            private function getAlertTxt(lev:int) : String { return null; }
            private function getAlertTitle(lev:int) : String { return null; }
            public function dispose() : void { }
   }}