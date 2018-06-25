package trainer.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.events.MouseEvent;      public class GhostTipFrame extends Frame   {                   private var content:Bitmap;            private var _titleStr:String;            private var _okStr:String;            private var _okBtn:TextButton;            public function GhostTipFrame() { super(); }
            private function initView() : void { }
            private function __onClickOK(e:MouseEvent) : void { }
            override public function dispose() : void { }
            private function _frameEventHandler(event:FrameEvent) : void { }
   }}