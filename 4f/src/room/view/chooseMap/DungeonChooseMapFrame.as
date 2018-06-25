package room.view.chooseMap{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.manager.NoviceDataManager;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickBuyFrame;   import ddt.data.BagInfo;   import ddt.data.map.DungeonInfo;   import ddt.data.player.SelfInfo;   import ddt.events.CEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MapManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.CheckMoneyUtils;   import flash.display.Sprite;   import flash.events.Event;   import kingBless.KingBlessManager;   import room.RoomManager;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;   import trainer.view.NewHandContainer;      public class DungeonChooseMapFrame extends Sprite implements Disposeable   {                   private var _frame:BaseAlerFrame;            private var _view:DungeonChooseMapView;            private var _timeTimer:TimerJuggler;            private var _confirmFrame:BaseAlerFrame;            private var _alert:BaseAlerFrame;            private var _selfInfo:SelfInfo;            private var _voucherAlert:BaseAlerFrame;            public function DungeonChooseMapFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function __timeHandler(evt:Event) : void { }
            private function onUpdateActivePveInfo(event:CEvent) : void { }
            public function show() : void { }
            private function __responeHandler(evt:FrameEvent) : void { }
            private function openDesert() : void { }
            private function __confirmBuySpirit(evt:FrameEvent) : void { }
            protected function onCheckComplete() : void { }
            private function getPrice() : String { return null; }
            private function showAlert() : void { }
            private function getName() : String { return null; }
            private function disposeAlert() : void { }
            private function __alertResponse(evt:FrameEvent) : void { }
            private function doOpenBossRoom() : void { }
            private function showVoucherAlert() : void { }
            private function disposeVoucherAlert() : void { }
            private function __onNoMoneyResponse(e:FrameEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}