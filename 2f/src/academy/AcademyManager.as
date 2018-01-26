package academy
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.analyze.AcademyMemberListAnalyze;
   import ddt.data.analyze.MyAcademyPlayersAnalyze;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.academyCommon.data.SimpleMessger;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import quest.TaskManager;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   
   public class AcademyManager extends EventDispatcher
   {
      
      public static const SELF_DESCRIBE:String = "selfDescribe";
      
      public static const LEVEL_GAP:int = 5;
      
      public static const TARGET_PLAYER_MIN_LEVEL:int = 8;
      
      public static const FARM_PLAYER_MIN_LEVEL:int = 25;
      
      public static const ACADEMY_LEVEL_MIN:int = 21;
      
      public static const ACADEMY_LEVEL_MAX:int = 8;
      
      public static const RECOMMEND_MAX_NUM:int = 3;
      
      public static const GRADUATE_NUM:Array = [1,5,10,50,99];
      
      public static const MASTER:Boolean = false;
      
      public static const APPSHIP:Boolean = true;
      
      public static const ACADEMY:Boolean = true;
      
      public static const RECOMMEND:Boolean = false;
      
      public static const NONE_STATE:int = 0;
      
      public static const APPRENTICE_STATE:int = 1;
      
      public static const MASTER_STATE:int = 2;
      
      public static const MASTER_FULL_STATE:int = 3;
      
      private static var _instance:AcademyManager;
       
      
      public var isShowRecommend:Boolean = true;
      
      public var freezesDate:Date;
      
      public var selfIsRegister:Boolean;
      
      public var isSelfPublishEquip:Boolean;
      
      private var _showMessage:Boolean = true;
      
      private var _recommendPlayers:Vector.<AcademyPlayerInfo>;
      
      private var _myAcademyPlayers:DictionaryData;
      
      private var _messgers:Vector.<SimpleMessger>;
      
      private var _selfDescribe:String;
      
      public function AcademyManager(){super();}
      
      public static function get Instance() : AcademyManager{return null;}
      
      public function setup() : void{}
      
      private function initEvent() : void{}
      
      private function __apprenticeSystemAnswer(param1:PkgEvent) : void{}
      
      private function academyAlert(param1:String, param2:Boolean) : void{}
      
      private function __onCancel(param1:FrameEvent) : void{}
      
      private function __frameEvent(param1:FrameEvent) : void{}
      
      public function loadAcademyMemberList(param1:Function, param2:Boolean = true, param3:Boolean = false, param4:int = 1, param5:String = "", param6:int = 0, param7:Boolean = true, param8:Boolean = false) : void{}
      
      public function recommend() : void{}
      
      public function recommends() : void{}
      
      private function __recommendPlayersComplete(param1:AcademyMemberListAnalyze) : void{}
      
      public function get recommendPlayers() : Vector.<AcademyPlayerInfo>{return null;}
      
      public function get myAcademyPlayers() : DictionaryData{return null;}
      
      public function myAcademy() : void{}
      
      private function __myAcademyPlayersComplete(param1:MyAcademyPlayersAnalyze) : void{}
      
      public function compareState(param1:BasePlayer, param2:PlayerInfo) : Boolean{return false;}
      
      public function gotoAcademyState() : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      public function getMasterHonorLevel(param1:int) : int{return 0;}
      
      public function isFreezes(param1:Boolean) : Boolean{return false;}
      
      public function set messgers(param1:Vector.<SimpleMessger>) : void{}
      
      public function get messgers() : Vector.<SimpleMessger>{return null;}
      
      public function showAlert() : void{}
      
      public function isFighting() : Boolean{return false;}
      
      public function isRecommend() : Boolean{return false;}
      
      public function isOpenSpace(param1:BasePlayer) : Boolean{return false;}
      
      public function get selfDescribe() : String{return null;}
      
      public function set selfDescribe(param1:String) : void{}
   }
}
