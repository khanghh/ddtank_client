package consortion.view.boss{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import consortion.data.ConsortiaBossDataVo;   import consortion.guard.ConsortiaGuardControl;   import consortion.guard.ConsortiaGuardEvent;   import ddt.manager.ConsortiaDutyManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import flash.display.Sprite;   import flash.events.MouseEvent;   import road7th.data.DictionaryData;      public class ConsortiaGuardBossView extends Sprite implements Disposeable   {                   private var _frame:ConsortiaBossFrame;            private var _enterGuardSceneBtn:SimpleBitmapButton;            private var _openGuardBossBtn:SimpleBitmapButton;            private var _helpBtn:SimpleBitmapButton;            public function ConsortiaGuardBossView(frame:ConsortiaBossFrame) { super(); }
            private function init() : void { }
            private function update() : void { }
            private function updateRank() : void { }
            private function __onClickEnterGuard(e:MouseEvent) : void { }
            private function __onOpenGurad(e:MouseEvent) : void { }
            private function __confirmOpenGuard(evt:FrameEvent) : void { }
            public function show() : void { }
            public function hied() : void { }
            private function __onUpdateActivity(e:ConsortiaGuardEvent) : void { }
            private function __onUpdateRank(e:ConsortiaGuardEvent) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}