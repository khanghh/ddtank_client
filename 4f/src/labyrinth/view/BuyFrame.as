package labyrinth.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddtBuried.BuriedManager;   import flash.events.MouseEvent;   import labyrinth.LabyrinthControl;      public class BuyFrame extends BaseAlerFrame   {                   private var _selectedCheckButton:SelectedCheckButton;            private var _content:FilterFrameText;            private var _value:int;            public function BuyFrame() { super(); }
            override protected function init() : void { }
            protected function __onselectedCheckButtoClick(event:MouseEvent) : void { }
            public function show() : void { }
            public function set value($value:int) : void { }
            override public function dispose() : void { }
   }}