package ddt.manager
{
   import BraveDoor.BraveDoorManager;
   import bombKing.BombKingManager;
   import campbattle.CampBattleManager;
   import catchbeast.CatchBeastManager;
   import church.ChurchManager;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import cryptBoss.CryptBossManager;
   import ddt.loader.StateLoader;
   import ddt.states.BaseStateView;
   import ddt.states.FadingBlock;
   import ddt.states.StateCreater;
   import ddt.utils.MenoryUtil;
   import ddt.view.chat.ChatBugleView;
   import email.MailManager;
   import farm.FarmModelController;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import ringStation.RingStationManager;
   import road7th.StarlingMain;
   import roomList.pveRoomList.DungeonListManager;
   import roomList.pvpRoomList.RoomListManager;
   import starling.scene.consortiaDomain.ConsortiaDomainScene;
   import starling.scene.demonChiYou.DemonChiYouScene;
   import starling.scene.hall.HallScene;
   
   public class StateManager
   {
      
      private static var dic:Dictionary;
      
      private static var root:Sprite;
      
      private static var current:BaseStateView;
      
      private static var next:BaseStateView;
      
      private static var _currentStateType:String;
      
      private static var _lastStateType:String;
      
      public static var getInGame_Step_1:Boolean = false;
      
      public static var getInGame_Step_2:Boolean = false;
      
      public static var getInGame_Step_3:Boolean = false;
      
      public static var getInGame_Step_4:Boolean = false;
      
      public static var getInGame_Step_5:Boolean = false;
      
      public static var getInGame_Step_6:Boolean = false;
      
      public static var getInGame_Step_7:Boolean = false;
      
      public static var getInGame_Step_8:Boolean = false;
      
      private static var _stage:Stage;
      
      public static var isShowFadingAnimation:Boolean = true;
      
      private static var fadingBlock:FadingBlock;
      
      private static var _creator:StateCreater;
      
      public static var RecordFlag:Boolean;
      
      private static var _data:Object;
      
      private static var _enterType:String;
      
      public static var isOpenRoomList:Boolean;
      
      public static var isOpenDungeonList:Boolean;
      
      public static var isOpenDemonChiYouRewardSelectFrame:Boolean;
       
      
      public function StateManager(){super();}
      
      public static function get currentStateType() : String{return null;}
      
      public static function set currentStateType(param1:String) : void{}
      
      public static function get lastStateType() : String{return null;}
      
      public static function set lastStateType(param1:String) : void{}
      
      public static function get nextState() : BaseStateView{return null;}
      
      public static function setup(param1:Sprite, param2:StateCreater, param3:Boolean = false) : void{}
      
      public static function setState(param1:String = "default", param2:Object = null, param3:int = 0) : void{}
      
      public static function stopImidily() : void{}
      
      private static function createCallbak(param1:BaseStateView) : void{}
      
      private static function setStateImp(param1:BaseStateView, param2:int = 0) : Boolean{return false;}
      
      private static function addNextToStage() : void{}
      
      public static function enterScene() : void{}
      
      private static function enterStarlingScene(param1:String) : void{}
      
      private static function showAlertRoomDungeon() : void{}
      
      private static function showLoading() : void{}
      
      public static function back() : void{}
      
      public static function getState(param1:String) : BaseStateView{return null;}
      
      public static function createStateAsync(param1:String, param2:Function = null) : void{}
      
      public static function isExitGame(param1:String) : Boolean{return false;}
      
      public static function isExitRoom(param1:String) : Boolean{return false;}
      
      public static function isInGame(param1:String) : Boolean{return false;}
      
      public static function leaving() : void{}
   }
}
