package fightLib.command{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;      public class PopupHFrameCommand extends BaseFightLibCommand   {                   private var _infoString:String;            private var _okLabel:String;            private var _cancelLabel:String;            private var _okCallBack:Function;            private var _cancellCallBack:Function;            private var _showOkBtn:Boolean;            private var _showCancelBtn:Boolean;            private var _alert:BaseAlerFrame;            public function PopupHFrameCommand(infoString:String, okLabel:String = "", okCallBack:Function = null, cancelLabel:String = "", cancelCallBack:Function = null, showOkBtn:Boolean = true, showCancelBtn:Boolean = false) { super(); }
            protected function __response(evt:FrameEvent) : void { }
            override public function excute() : void { }
            override public function finish() : void { }
            override public function undo() : void { }
            override public function dispose() : void { }
            private function closeFrame() : void { }
            private function closeAlert() : void { }
   }}