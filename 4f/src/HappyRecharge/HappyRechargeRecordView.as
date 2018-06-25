package HappyRecharge{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;      public class HappyRechargeRecordView extends Sprite implements Disposeable   {                   private var _conText:FilterFrameText;            private var _type:int;            public function HappyRechargeRecordView(type:int = 10) { super(); }
            private function initText() : void { }
            public function setText(nickName:String, itemName:String, count:int) : void { }
            public function dispose() : void { }
   }}