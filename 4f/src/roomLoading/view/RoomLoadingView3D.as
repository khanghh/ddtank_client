package roomLoading.view
{
   import bones.BoneMovieFactory;
   import bones.loader.BonesLoaderEvent;
   import bones.loader.BonesLoaderManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.loader.StartupResourceLoader;
   import ddt.loader.StateLoader;
   import ddt.manager.BallManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.PathManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.LoadBombManager;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Player;
   import pet.data.PetInfo;
   import road7th.DDTAssetManager;
   import room.RoomManager;
   import room.model.RoomPlayer;
   import room.model.WeaponInfo;
   import starling.loader.StarlingQueueLoader;
   import trainer.controller.NewHandGuideManager;
   import trainer.controller.WeakGuildManager;
   
   public class RoomLoadingView3D extends RoomLoadingView
   {
       
      
      private var _loadBonesList:Array;
      
      private var _starlingLoader:StarlingQueueLoader;
      
      private var _isStarlingAssetComplete:Boolean;
      
      public function RoomLoadingView3D(param1:GameInfo){super(null);}
      
      override protected function init() : void{}
      
      override protected function initLoadingItems() : void{}
      
      override protected function loadingBombAsset() : void{}
      
      private function __onLoaderBonesComplete(param1:BonesLoaderEvent) : void{}
      
      private function delayLoadingBombAsset() : void{}
      
      override protected function __countDownTick(param1:TimerEvent) : void{}
      
      override protected function checkProgress() : Boolean{return false;}
      
      private function loadingOutBombsComplete() : Boolean{return false;}
      
      override protected function loadingPetAsset(param1:PetInfo) : void{}
      
      override protected function initCharacter(param1:Player, param2:RoomLoadingCharacterItem) : void{}
      
      override protected function loadingHorseAsset(param1:Array) : void{}
      
      override protected function loadingPetSkillAsset() : void{}
      
      override protected function laodingTrainer() : void{}
      
      private function addBonesAsset() : void{}
      
      private function checkBonesAssetComplete() : Boolean{return false;}
      
      private function addStarlingAsset() : void{}
   }
}
