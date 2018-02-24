package oldPlayerRegress.view.itemView.task
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddtActivityIcon.ActivitStateEvent;
   import ddtActivityIcon.DdtActivityIconManager;
   import ddtBuried.BuriedManager;
   import fightLib.FightLibManager;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import labyrinth.LabyrinthControl;
   import oldPlayerRegress.view.RegressView;
   import petsBag.PetsBagManager;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   import trainer.controller.WeakGuildManager;
   
   public class RegressTaskView extends Frame
   {
       
      
      private var _taskInfo:QuestInfo;
      
      private var _taskIdArray:Array;
      
      private var _funcArray:Array;
      
      private var _gotoFunc:Function;
      
      private var _isBattleOpen:Boolean;
      
      private var _bottomBtnBg:ScaleBitmapImage;
      
      private var _getAwardBtn:BaseButton;
      
      private var _gotoBtn:BaseButton;
      
      private var _questBtnShine:IEffect;
      
      private var _lastCreatTime:int;
      
      private var _bossState:int = 0;
      
      public function RegressTaskView(){super();}
      
      private function _init() : void{}
      
      private function initData() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __onGetAwardBtnClick(param1:MouseEvent) : void{}
      
      protected function __onGotoBtnClick(param1:MouseEvent) : void{}
      
      private function finishQuest(param1:QuestInfo) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function show() : void{}
      
      private function setModuleInfo() : void{}
      
      private function getFuncID(param1:int) : int{return 0;}
      
      private function notGo() : void{}
      
      private function gotoHall() : void{}
      
      private function gotoDungeon() : void{}
      
      private function gotoBagAndInfo() : void{}
      
      private function gotoPetView() : void{}
      
      private function gotoLabyrinth() : void{}
      
      private function battleOpenHandler(param1:ActivitStateEvent) : void{}
      
      private function battleOverHandler(param1:PkgEvent) : void{}
      
      private function gotoBattle() : void{}
      
      private function gotoBuried() : void{}
      
      private function consortiaBossHandler(param1:PkgEvent) : void{}
      
      private function gotoConsortiria() : void{}
      
      private function gotoTrain() : void{}
      
      private function __gameStart(param1:CrazyTankSocketEvent) : void{}
      
      private function getSecondType(param1:int, param2:int) : int{return 0;}
      
      override public function dispose() : void{}
      
      public function get taskInfo() : QuestInfo{return null;}
      
      public function set taskInfo(param1:QuestInfo) : void{}
      
      public function get getAwardBtn() : BaseButton{return null;}
      
      public function set getAwardBtn(param1:BaseButton) : void{}
      
      public function get questBtnShine() : IEffect{return null;}
      
      public function set questBtnShine(param1:IEffect) : void{}
      
      public function get gotoBtn() : BaseButton{return null;}
      
      public function set gotoBtn(param1:BaseButton) : void{}
   }
}
