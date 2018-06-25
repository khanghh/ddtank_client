package consortion.view.selfConsortia.consortiaTask{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;      public class ConsortiaReleaseTaskFrame extends BaseAlerFrame   {                   private var _arr:Array;            private var _releaseContentTextScale9BG:Scale9CornerImage;            private var _content:MovieImage;            private var _levelView:ConsortiaTaskLevelView;            private var _selectedLevelRecord:int;            public function ConsortiaReleaseTaskFrame() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function __response(e:FrameEvent) : void { }
            private function __okClick() : void { }
            private function _responseII(e:FrameEvent) : void { }
            private function __openRichesTip() : void { }
            private function __noEnoughHandler(event:FrameEvent) : void { }
            override public function dispose() : void { }
   }}