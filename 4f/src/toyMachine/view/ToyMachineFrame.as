package toyMachine.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.geom.Point;   import road7th.comm.PackageIn;   import toyMachine.ToyMachineManager;   import trainer.view.NewHandContainer;      public class ToyMachineFrame extends Frame implements Disposeable   {                   private var _bg:Bitmap;            private var _silverItem:ToyMachineItem;            private var _goldItem:ToyMachineItem;            public function ToyMachineFrame() { super(); }
            private function sendPkg() : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function __onGetReward(event:PkgEvent) : void { }
            protected function __onUpdateView(event:PkgEvent) : void { }
            protected function __onResponse(event:FrameEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}