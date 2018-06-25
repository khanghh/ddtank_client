package oldPlayerComeBack.view.task{   import bagAndInfo.BagAndInfoManager;   import collectionTask.CollectionTaskManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.quest.QuestCondition;   import ddt.data.quest.QuestInfo;   import ddt.data.quest.QuestItemReward;   import ddt.manager.BattleGroudManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.StateManager;   import ddt.utils.HelperUIModuleLoad;   import ddtBuried.BuriedManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.utils.Dictionary;   import giftSystem.GiftManager;   import hall.tasktrack.HallTaskTrackManager;   import horse.HorseManager;   import petsBag.PetsBagManager;   import quest.TaskManager;      public class OldPlayerTaskItem extends Sprite   {                   private var _complateBg:Bitmap;            private var _notComplateBg:Bitmap;            private var _awardTxt:FilterFrameText;            private var _completeCount:FilterFrameText;            private var _progress:FilterFrameText;            private var _awardValue:FilterFrameText;            private var _getBtn:SimpleBitmapButton;            private var _goToBtn:SimpleBitmapButton;            private var _receivedBtn:Bitmap;            private var _questInfo:QuestInfo;            public function OldPlayerTaskItem() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __gotoBtnClickHandler(evt:MouseEvent) : void { }
            private function __getBtnClickHandler(evt:MouseEvent) : void { }
            public function get completeType() : int { return 0; }
            public function set info(data:QuestInfo) : void { }
            public function getInfo() : QuestInfo { return null; }
            private function updateGuideState() : void { }
            private function jumpTo() : void { }
            private function initCompleteCount() : String { return null; }
            private function initProgress() : String { return null; }
            public function dispose() : void { }
   }}