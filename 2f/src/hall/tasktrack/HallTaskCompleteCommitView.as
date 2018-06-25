package hall.tasktrack{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.quest.QuestInfo;   import ddt.data.quest.QuestItemReward;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.TextEvent;   import flash.utils.clearTimeout;   import flash.utils.setTimeout;   import quest.TaskManager;   import tryonSystem.TryonSystemController;      public class HallTaskCompleteCommitView extends Sprite implements Disposeable   {                   private var _commitBtnTxt:FilterFrameText;            private var _questInfo:QuestInfo;            private var _questId:int;            private var _timeOutId:int;            public function HallTaskCompleteCommitView(questId:int) { super(); }
            protected function onATS(e:Event) : void { }
            private function initView() : void { }
            private function textClickHandler(event:TextEvent) : void { }
            private function __onResponse(pEvent:FrameEvent) : void { }
            private function finishQuest() : void { }
            private function showSelectedAwardFrame(items:Array) : void { }
            private function chooseReward(item:ItemTemplateInfo) : void { }
            private function getSexByInt(Sex:Boolean) : int { return 0; }
            private function getTypeStr(questInfo:QuestInfo) : String { return null; }
            public function dispose() : void { }
   }}