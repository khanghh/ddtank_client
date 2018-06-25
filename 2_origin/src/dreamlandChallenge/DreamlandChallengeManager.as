package dreamlandChallenge
{
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import dreamlandChallenge.analyzer.UnrealRankRewardAnalyzer;
   import dreamlandChallenge.data.DCSpeedMatchRankMode;
   import dreamlandChallenge.data.DCSpeedMatchRankVo;
   import dreamlandChallenge.data.DreamLandModel;
   import dreamlandChallenge.data.DreamLandSelfRankVo;
   import dreamlandChallenge.data.UnrealRankRewardInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class DreamlandChallengeManager extends EventDispatcher
   {
      
      public static var OPEN_VIEW:String = "openSupContendView";
      
      public static var ACTIVE_STATECHANGE:String = "activeStateChange";
      
      public static var BOGUID:int = 3000;
      
      public static var XIESHENID:int = 3002;
      
      private static var _instance:DreamlandChallengeManager;
       
      
      private var _isOpen:Boolean = false;
      
      private var _awardLists:Array;
      
      private var _mode:DreamLandModel;
      
      private var _curState:int;
      
      public function DreamlandChallengeManager()
      {
         super();
         _mode = new DreamLandModel();
      }
      
      public static function get instance() : DreamlandChallengeManager
      {
         if(_instance == null)
         {
            _instance = new DreamlandChallengeManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(610,1),__viewStateHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(610,6),__rankDataHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(610,20),_selfInfoHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(610,21),_selfRankInfoHandler);
      }
      
      private function __viewStateHandler(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var type:int = pkg.readByte();
         curState = type;
         isOpen = type >= 1 && type <= 3;
      }
      
      public function get curState() : int
      {
         return _curState;
      }
      
      public function set curState(value:int) : void
      {
         _curState = value;
         this.dispatchEvent(new Event(ACTIVE_STATECHANGE));
      }
      
      public function set isOpen(value:Boolean) : void
      {
         if(_isOpen == value)
         {
            return;
         }
         _isOpen = value;
         checkIcon();
      }
      
      public function initHall() : void
      {
         checkIcon();
      }
      
      private function checkIcon() : void
      {
         if(_isOpen && PlayerManager.Instance.Self.Grade >= 23)
         {
            HallIconManager.instance.updateSwitchHandler("dreamLandChallenge",_isOpen);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("dreamLandChallenge",true,23);
         }
      }
      
      private function __rankDataHandler(evt:PkgEvent) : void
      {
         var vo:* = null;
         var i:int = 0;
         var pkg:PackageIn = evt.pkg;
         var rankMode:DCSpeedMatchRankMode = new DCSpeedMatchRankMode();
         var type:int = pkg.readByte();
         rankMode.totalPage = pkg.readShort();
         rankMode.selfRanking = pkg.readInt();
         var len:int = pkg.readShort();
         if(len > 0)
         {
            rankMode.addItem(addSelfSpeedMatchRankItem(rankMode.selfRanking,type));
         }
         i = 0;
         while(i < len)
         {
            vo = new DCSpeedMatchRankVo();
            vo.id = pkg.readInt();
            vo.nick = pkg.readUTF();
            vo.area = pkg.readUTF();
            vo.point = pkg.readInt();
            vo.hurt = pkg.readInt();
            vo.rank = pkg.readInt();
            rankMode.addItem(vo);
            i++;
         }
         _mode.rankModel = rankMode;
      }
      
      private function addSelfSpeedMatchRankItem(ranking:int, type:int) : DCSpeedMatchRankVo
      {
         var selfInfo:SelfInfo = PlayerManager.Instance.Self;
         var vo:DCSpeedMatchRankVo = new DCSpeedMatchRankVo();
         vo.id = selfInfo.ID;
         vo.nick = selfInfo.NickName;
         vo.area = selfInfo.SubName;
         vo.point = _mode.selfTotalPoint;
         vo.round = _mode.getSelfRankItemByType(type).round;
         vo.hurt = _mode.getSelfRankItemByType(type).hurt;
         vo.rank = ranking;
         return vo;
      }
      
      private function _selfInfoHandler(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         _mode.surplusCount = pkg.readShort();
         _mode.selfPoint = pkg.readInt();
         _mode.selfTotalPoint = pkg.readInt();
      }
      
      private function _selfRankInfoHandler(evt:PkgEvent) : void
      {
         var selfVo:* = null;
         var i:int = 0;
         var pkg:PackageIn = evt.pkg;
         var len:int = pkg.readByte();
         for(i = 0; i < len; )
         {
            selfVo = new DreamLandSelfRankVo();
            selfVo.difficultyType = pkg.readByte();
            selfVo.round = pkg.readInt();
            selfVo.hurt = pkg.readInt();
            _mode.addSelfRandItem(selfVo);
            i++;
         }
      }
      
      public function preOpenView() : void
      {
         loadUiResource();
      }
      
      private function loadUiResource() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createUnrealRankRewardLoader());
         AssetModuleLoader.addModelLoader("dreamlandChallenge",7);
         AssetModuleLoader.addModelLoader("mark",7);
         AssetModuleLoader.startCodeLoader(openView);
      }
      
      private function openView() : void
      {
         dispatchEvent(new CEvent(OPEN_VIEW));
      }
      
      public function loadUnrealRankAwardComplete(value:UnrealRankRewardAnalyzer) : void
      {
         _awardLists = value.data;
      }
      
      public function getAwardsByDiffcultyType(type:int) : Array
      {
         var temArr:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _awardLists;
         for each(var item in _awardLists)
         {
            if(item.RankType == type)
            {
               temArr.push(item);
            }
         }
         return temArr;
      }
      
      public function get mode() : DreamLandModel
      {
         return _mode;
      }
   }
}
