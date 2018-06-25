package treasureHunting.views{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.view.DoubleSelectedItem;   import ddtBuried.items.BuriedCardItem;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class TransactionsDiceFrame extends BaseAlerFrame   {                   private var _selecedItem:DoubleSelectedItem;            private var _selectedCheckButton:SelectedCheckButton;            public var buyFunction:Function;            public var clickFunction:Function;            private var _txt:FilterFrameText;            private var _target:Sprite;            public var autoClose:Boolean = true;            public function TransactionsDiceFrame() { super(); }
            public function set target($target:Sprite) : void { }
            private function initView() : void { }
            private function initEvents() : void { }
            private function mouseClickHander(e:MouseEvent) : void { }
            private function removeEvnets() : void { }
            private function responseHander(e:FrameEvent) : void { }
            public function get isBind() : Boolean { return false; }
            public function setTxt(str:String) : void { }
            override public function dispose() : void { }
   }}