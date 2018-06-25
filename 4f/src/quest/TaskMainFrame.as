package quest{   import academy.AcademyManager;   import bagAndInfo.BagAndInfoManager;   import baglocked.BaglockedManager;   import collectionTask.CollectionTaskManager;   import com.pickgliss.effect.EffectManager;   import com.pickgliss.effect.IEffect;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.manager.NoviceDataManager;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ComponentSetting;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.MD5;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickBuyFrame;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.data.quest.QuestInfo;   import ddt.data.quest.QuestItemReward;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.TaskEvent;   import ddt.manager.CheckWeaponManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import ddt.view.MainToolBar;   import fightLib.FightLibManager;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.net.URLLoader;   import flash.net.URLRequest;   import flash.net.URLVariables;   import flash.net.navigateToURL;   import flash.utils.Timer;   import flash.utils.setTimeout;   import hall.tasktrack.HallTaskGuideManager;   import hall.tasktrack.HallTaskTrackManager;   import petsBag.PetsBagManager;   import petsBag.event.UpdatePetFarmGuildeEvent;   import quest.cmd.CmdThreeAndPowerPickUpAndEnable;   import room.RoomManager;   import roomList.RoomListEnumerate;   import trainer.controller.NewHandGuideManager;   import trainer.controller.WeakGuildManager;   import trainer.view.NewHandContainer;   import tryonSystem.TryonSystemController;      public class TaskMainFrame extends Frame   {            private static const SPINEL:int = 11555;            private static const TYPE_NUMBER:int = 9;                   private const CATEVIEW_X:int = 0;            private const CATEVIEW_Y:int = 0;            private const CATEVIEW_H:int = 50;            private var cateViewArr:Array;            private var infoView:QuestInfoPanelView;            private var _questBtn:BaseButton;            private var _goDungeonBtnShine:IEffect;            private var _downClientShine:IEffect;            private var _questBtnShine:IEffect;            private var _buySpinelBtn:TextButton;            private var _currentCateView:QuestCateView;            public var currentNewCateView:QuestCateView;            private var leftPanel:ScrollPanel;            private var leftPanelContent:VBox;            private var _trusteeshipView:TrusteeshipView;            private var _leftBGStyleNormal:MovieClip;            private var _rightBGStyleNormal:MovieClip;            private var _rightBottomBg:ScaleBitmapImage;            private var _goDungeonBtn:BaseButton;            private var _downloadClientBtn:TextButton;            private var _gotoAcademy:BaseButton;            private var _gotoGameBtn:BaseButton;            private var _gotoTrainBtn:BaseButton;            private var _gotoSceneBtn:SimpleBitmapButton;            private var _mcTaskTarget:MovieClip;            private var _timer:Timer;            private var _style:int;            private var _quick:QuickBuyFrame;            public function TaskMainFrame() { super(); }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
            private function initView() : void { }
            private function initStyleNormalBG() : void { }
            private function clearVBox() : void { }
            private function initStyleGuideBG() : void { }
            private function switchBG(style:int) : void { }
            private function addQuestList() : void { }
            private function __onEnbleChange(evt:Event) : void { }
            private function addEvent() : void { }
            protected function __onTaskFinished(event:TaskEvent) : void { }
            private function removeEvent() : void { }
            private function __updatePetFarmGuilde(e:UpdatePetFarmGuildeEvent) : void { }
            private function __onDataChanged(e:TaskEvent) : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            public function jumpToQuest(info:QuestInfo) : void { }
            private function showTrusteeshipView(info:QuestInfo) : void { }
            private function showQuestOverBtn(value:Boolean) : void { }
            private function showOtherBtn(info:QuestInfo) : void { }
            private function existRewardId(info:QuestInfo, itemID:int) : Boolean { return false; }
            private function showGuide() : void { }
            private function __timer(evt:TimerEvent) : void { }
            private function resetTimer() : void { }
            private function hideGuide() : void { }
            private function showStyle(style:int) : void { }
            private function __onCateViewChange(e:Event) : void { }
            private function __onTitleClicked(e:Event) : void { }
            public function switchVisible() : void { }
            private function _show() : void { }
            public function open() : void { }
            private function __onQuestBtnClicked(e:MouseEvent) : void { }
            private function finishQuest(pQuestInfo:QuestInfo) : void { }
            private function checkThreeAndPower() : void { }
            private function __onResponse(pEvent:FrameEvent) : void { }
            private function getSexByInt(Sex:Boolean) : int { return 0; }
            private function chooseReward(item:ItemTemplateInfo) : void { }
            private function cancelChoose() : void { }
            private function __onGoDungeonClicked(event:MouseEvent) : void { }
            private function __gotoGame(e:MouseEvent) : void { }
            private function __gotoScene(event:MouseEvent) : void { }
            private function __gotoTrain(e:MouseEvent) : void { }
            private function __createUserGude() : void { }
            private function __gameStart(e:CrazyTankSocketEvent) : void { }
            private function updateAllDataHandler(event:Event) : void { }
            private function checkGotoSceneCondition(info:QuestInfo) : Boolean { return false; }
            private function updateSpiritValueHandler(event:Event) : void { }
            private function getSecondType(infoId:int, difficulty:int) : int { return 0; }
            private function __gotoAcademy(event:MouseEvent) : void { }
            private function __downloadClient(event:MouseEvent) : void { }
            private function __buySpinelClick(evt:MouseEvent) : void { }
            public function gotoQuest(info:QuestInfo) : void { }
            override protected function __onAddToStage(e:Event) : void { }
            override public function dispose() : void { }
   }}