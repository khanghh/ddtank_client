package roomLoading.encounter
{
   import com.greensock.TweenMax;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BallInfo;
   import ddt.events.GameEvent;
   import ddt.loader.MapLoader;
   import ddt.loader.StartupResourceLoader;
   import ddt.loader.TrainerLoader;
   import ddt.manager.BallManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.MapManager;
   import ddt.manager.PathManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import gameCommon.LoadBombManager;
   import gameCommon.model.GameInfo;
   import gameCommon.model.GameNeedPetSkillInfo;
   import gameCommon.model.Player;
   import pet.data.PetInfo;
   import pet.data.PetSkillTemplateInfo;
   import room.RoomManager;
   import room.model.RoomPlayer;
   import roomLoading.view.RoomLoadingCharacterItem;
   import roomLoading.view.RoomLoadingView;
   import trainer.controller.LevelRewardManager;
   import trainer.controller.NewHandGuideManager;
   
   public class EncounterLoadingView extends RoomLoadingView
   {
       
      
      protected var _playerItems:Vector.<EncounterLoadingCharacterItem>;
      
      protected var _love:MovieClip;
      
      protected var _loveII:MovieClip;
      
      protected var _selfItem:EncounterLoadingCharacterItem;
      
      protected var _showArrowComplete:Boolean = false;
      
      protected var _pairingComplete:Boolean = false;
      
      protected var boyIdx:int = 1;
      
      protected var girlIdx:int = 1;
      
      public function EncounterLoadingView(param1:GameInfo){super(null);}
      
      override protected function init() : void{}
      
      protected function __pairingComplete(param1:GameEvent) : void{}
      
      protected function __showPairing(param1:TimerEvent) : void{}
      
      protected function pairingComplete() : void{}
      
      protected function hideArrow() : void{}
      
      protected function showArrow() : void{}
      
      protected function getTeammateID(param1:RoomLoadingCharacterItem) : int{return 0;}
      
      protected function getTeammateZoneID(param1:RoomLoadingCharacterItem) : int{return 0;}
      
      protected function getArrowType(param1:int, param2:int) : int{return 0;}
      
      protected function getPosition(param1:int, param2:int) : int{return 0;}
      
      protected function getItemByTeam(param1:int, param2:Boolean) : EncounterLoadingCharacterItem{return null;}
      
      protected function getItem(param1:int, param2:int) : EncounterLoadingCharacterItem{return null;}
      
      override protected function initLoadingItems() : void{}
      
      override protected function initRoomItem(param1:RoomLoadingCharacterItem) : void{}
      
      protected function __onSelectObject(param1:MouseEvent) : void{}
      
      override protected function initCharacter(param1:Player, param2:RoomLoadingCharacterItem) : void{}
      
      override protected function checkProgress() : Boolean{return false;}
      
      override protected function leave() : void{}
      
      override protected function checkAnimationIsFinished() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
