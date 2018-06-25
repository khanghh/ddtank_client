package cryptBoss.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.utils.ObjectUtils;   import cryptBoss.CryptBossManager;   import cryptBoss.data.CryptBossItemInfo;   import ddt.data.quest.QuestInfo;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.utils.HelpFrameUtils;   import flash.display.Bitmap;   import flash.events.Event;   import gameCommon.GameControl;   import quest.TaskManager;      public class CryptBossMainFrame extends Frame   {                   private var _bg:Bitmap;            private var _helpBtn:SimpleBitmapButton;            private var _itemVec:Vector.<CryptBossItem>;            public function CryptBossMainFrame() { super(); }
            private function initView() : void { }
            public function updateView() : void { }
            private function initEvent() : void { }
            private function checkTask() : void { }
            private function __startLoading(e:Event) : void { }
            protected function __responseHandler(evt:FrameEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}