package cityBattle
{
   import cityBattle.analyze.CityBattleAnalyze;
   import cityBattle.data.CastellanInfo;
   import cityBattle.data.ContentionInfo;
   import cityBattle.data.WelfareInfo;
   import cityBattle.event.CityBattleEvent;
   import cityBattle.view.CityBattleMainFrame;
   import cityBattle.view.JoinCityBattleView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class CityBattleManager extends EventDispatcher
   {
      
      private static var _instance:CityBattleManager;
       
      
      public var redTotalScore:int;
      
      public var blueTotalScore:int;
      
      public var winnerExchangeInfo:Array;
      
      public var myExchangeInfo:Vector.<WelfareInfo>;
      
      public var contentionFirstData:Boolean;
      
      public var now:int;
      
      public var myScore:int;
      
      public var myRankScore:int;
      
      public var mySide:int;
      
      public var myRank:int;
      
      public var isOpen:Boolean;
      
      public var blueList:Vector.<ContentionInfo>;
      
      public var redList:Vector.<ContentionInfo>;
      
      public var welfareList:Vector.<WelfareInfo>;
      
      public var castellanList:Vector.<CastellanInfo>;
      
      public var _mainFrame:CityBattleMainFrame;
      
      private var _joinView:JoinCityBattleView;
      
      public function CityBattleManager(param1:IEventDispatcher = null)
      {
         myExchangeInfo = new Vector.<WelfareInfo>();
         super(param1);
      }
      
      public static function get instance() : CityBattleManager
      {
         if(!_instance)
         {
            _instance = new CityBattleManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(368,0),_activityOpenHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(368,1),_playerEnterHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(368,2),_joinBattleHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(368,3),_contentionHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(368,4),_exchangeHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(368,8),_scoreAndRankHandler);
      }
      
      public function CityBattleSystemsHandler(param1:CityBattleAnalyze) : void
      {
         welfareList = param1.list;
      }
      
      private function _scoreAndRankHandler(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         blueTotalScore = _loc2_.readInt();
         redTotalScore = _loc2_.readInt();
         myRankScore = _loc2_.readInt();
         myRank = _loc2_.readInt();
         dispatchEvent(new CityBattleEvent("score_rank"));
      }
      
      private function _joinBattleHandler(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         mySide = _loc2_.readInt();
         dispatchEvent(new CityBattleEvent("joinBattle"));
      }
      
      private function _playerEnterHandler(param1:PkgEvent) : void
      {
         var _loc12_:* = null;
         var _loc10_:int = 0;
         var _loc13_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:* = null;
         var _loc11_:int = 0;
         var _loc2_:* = null;
         var _loc6_:* = 0;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         castellanList = new Vector.<CastellanInfo>();
         var _loc4_:PackageIn = param1.pkg;
         now = _loc4_.readInt();
         var _loc5_:int = _loc4_.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc5_)
         {
            _loc12_ = new CastellanInfo();
            _loc13_ = _loc4_.readInt();
            _loc7_ = _loc4_.readInt();
            _loc9_ = _loc4_.readUTF();
            _loc11_ = _loc4_.readInt();
            _loc2_ = PlayerManager.Instance.findPlayer(_loc11_,_loc7_);
            _loc2_.zoneName = _loc9_;
            _loc2_.NickName = _loc4_.readUTF();
            _loc2_.Sex = _loc4_.readBoolean();
            _loc2_.Hide = _loc4_.readInt();
            _loc2_.Style = _loc4_.readUTF();
            _loc2_.Colors = _loc4_.readUTF();
            _loc2_.Skin = _loc4_.readUTF();
            _loc12_.winner = _loc2_;
            _loc12_.side = _loc13_;
            castellanList[_loc10_] = _loc12_;
            _loc10_++;
         }
         _loc6_ = _loc5_;
         while(_loc6_ < 7)
         {
            _loc12_ = new CastellanInfo();
            _loc12_.side = 0;
            castellanList[_loc6_] = _loc12_;
            _loc6_++;
         }
         winnerExchangeInfo = [];
         _loc8_ = 0;
         while(_loc8_ < 7)
         {
            _loc3_ = _loc4_.readInt();
            winnerExchangeInfo.push(_loc3_);
            _loc8_++;
         }
         show();
      }
      
      private function _activityOpenHandler(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         isOpen = _loc2_.readBoolean();
         mySide = _loc2_.readInt();
         updateIcon();
      }
      
      public function updateIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("cityBattle",isOpen);
      }
      
      private function _contentionHandler(param1:PkgEvent) : void
      {
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         contentionFirstData = true;
         blueList = new Vector.<ContentionInfo>();
         var _loc3_:int = _loc5_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc4_ = new ContentionInfo();
            _loc4_.rank = _loc7_ + 1;
            _loc4_.name = _loc5_.readUTF();
            _loc4_.socre = _loc5_.readInt();
            _loc4_.server = _loc5_.readUTF();
            blueList.push(_loc4_);
            _loc7_++;
         }
         redList = new Vector.<ContentionInfo>();
         var _loc2_:int = _loc5_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc4_ = new ContentionInfo();
            _loc4_.rank = _loc6_ + 1;
            _loc4_.name = _loc5_.readUTF();
            _loc4_.socre = _loc5_.readInt();
            _loc4_.server = _loc5_.readUTF();
            redList.push(_loc4_);
            _loc6_++;
         }
         _mainFrame.changeView(2);
      }
      
      private function _exchangeHandler(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:int = _loc2_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc6_ = new WelfareInfo();
            _loc6_.ID = _loc2_.readInt();
            _loc6_.myExchangeCount = _loc2_.readInt();
            _loc4_ = 0;
            while(true)
            {
               if(_loc4_ >= myExchangeInfo.length)
               {
                  myExchangeInfo.push(_loc6_);
                  break;
               }
               _loc5_ = myExchangeInfo[_loc4_];
               if(_loc6_.ID == _loc5_.ID)
               {
                  myExchangeInfo[_loc4_].myExchangeCount = _loc6_.myExchangeCount;
                  break;
               }
               _loc4_++;
            }
            _loc7_++;
         }
         myScore = _loc2_.readInt();
         dispatchEvent(new CityBattleEvent("scoreChange"));
         if(_mainFrame.changeBtn)
         {
            _mainFrame.changeBtn = false;
            _mainFrame.changeView(3);
         }
      }
      
      public function show() : void
      {
         AssetModuleLoader.addModelLoader("cityBattle",6);
         AssetModuleLoader.startCodeLoader(onLoaded);
      }
      
      private function onLoaded() : void
      {
         if(mySide == 0)
         {
            _joinView = new JoinCityBattleView();
            LayerManager.Instance.addToLayer(_joinView,3,false,1);
            _joinView.x = 141;
            _joinView.y = 30;
         }
         else
         {
            _mainFrame = ComponentFactory.Instance.creatComponentByStylename("cityBattle.mainFrame");
            LayerManager.Instance.addToLayer(_mainFrame,3,true,1);
         }
      }
   }
}
