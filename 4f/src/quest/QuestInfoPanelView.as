package quest{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.container.VBox;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.quest.QuestCondition;   import ddt.data.quest.QuestInfo;   import ddt.data.quest.QuestItemReward;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class QuestInfoPanelView extends Sprite   {                   private const CONDITION_HEIGHT:int = 32;            private const CONDITION_Y:int = 0;            private const PADDING_Y:int = 8;            private var _info:QuestInfo;            private var gotoCMoive:TextButton;            private var container:VBox;            private var panel:ScrollPanel;            private var _extraFrame:Sprite;            private var _items:Vector.<QuestInfoItemView>;            private var _starLevel:int;            private var _complete:Boolean;            private var _isImprove:Boolean;            private var _lastId:int;            private var _regressFlag:Boolean = false;            public function QuestInfoPanelView() { super(); }
            private function initView() : void { }
            public function clearItems() : void { }
            public function set info(value:QuestInfo) : void { }
            private function __onGoToConsortia(e:MouseEvent) : void { }
            private function getSexByInt(Sex:Boolean) : int { return 0; }
            public function canGotoConsortia(value:Boolean) : void { }
            public function get info() : QuestInfo { return null; }
            public function dispose() : void { }
            public function get regressFlag() : Boolean { return false; }
            public function set regressFlag(value:Boolean) : void { }
   }}