package farm.viewx{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import farm.FarmEvent;   import farm.FarmModelController;   import flash.display.DisplayObject;      public class confirmStopHelperFrame extends BaseAlerFrame   {                   private var _addBtn:BaseButton;            private var _removeBtn:BaseButton;            private var _msgTxt:FilterFrameText;            private var _bgTitle:DisplayObject;            public function confirmStopHelperFrame() { super(); }
            private function intView() : void { }
            private function initEvent() : void { }
            protected function __framePesponse(event:FrameEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}