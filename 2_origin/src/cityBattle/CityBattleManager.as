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
      
      public function CityBattleManager(target:IEventDispatcher = null)
      {
         myExchangeInfo = new Vector.<WelfareInfo>();
         super(target);
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
      
      public function CityBattleSystemsHandler(analyzer:CityBattleAnalyze) : void
      {
         welfareList = analyzer.list;
      }
      
      private function _scoreAndRankHandler(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         blueTotalScore = pkg.readInt();
         redTotalScore = pkg.readInt();
         myRankScore = pkg.readInt();
         myRank = pkg.readInt();
         dispatchEvent(new CityBattleEvent("score_rank"));
      }
      
      private function _joinBattleHandler(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         mySide = pkg.readInt();
         dispatchEvent(new CityBattleEvent("joinBattle"));
      }
      
      private function _playerEnterHandler(e:PkgEvent) : void
      {
         var castellan:* = null;
         var i:int = 0;
         var citySide:int = 0;
         var zoneID:int = 0;
         var zoneName:* = null;
         var id:int = 0;
         var sp:* = null;
         var j:* = 0;
         var k:int = 0;
         var whoWin:int = 0;
         castellanList = new Vector.<CastellanInfo>();
         var pkg:PackageIn = e.pkg;
         now = pkg.readInt();
         var len:int = pkg.readInt();
         for(i = 0; i < len; )
         {
            castellan = new CastellanInfo();
            citySide = pkg.readInt();
            zoneID = pkg.readInt();
            zoneName = pkg.readUTF();
            id = pkg.readInt();
            sp = PlayerManager.Instance.findPlayer(id,zoneID);
            sp.zoneName = zoneName;
            sp.NickName = pkg.readUTF();
            sp.Sex = pkg.readBoolean();
            sp.Hide = pkg.readInt();
            sp.Style = pkg.readUTF();
            sp.Colors = pkg.readUTF();
            sp.Skin = pkg.readUTF();
            castellan.winner = sp;
            castellan.side = citySide;
            castellanList[i] = castellan;
            i++;
         }
         for(j = len; j < 7; )
         {
            castellan = new CastellanInfo();
            castellan.side = 0;
            castellanList[j] = castellan;
            j++;
         }
         winnerExchangeInfo = [];
         for(k = 0; k < 7; )
         {
            whoWin = pkg.readInt();
            winnerExchangeInfo.push(whoWin);
            k++;
         }
         show();
      }
      
      private function _activityOpenHandler(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         isOpen = pkg.readBoolean();
         mySide = pkg.readInt();
         updateIcon();
      }
      
      public function updateIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("cityBattle",isOpen);
      }
      
      private function _contentionHandler(e:PkgEvent) : void
      {
         var rankinfo:* = null;
         var i:int = 0;
         var j:int = 0;
         var pkg:PackageIn = e.pkg;
         contentionFirstData = true;
         blueList = new Vector.<ContentionInfo>();
         var lenBlue:int = pkg.readInt();
         for(i = 0; i < lenBlue; )
         {
            rankinfo = new ContentionInfo();
            rankinfo.rank = i + 1;
            rankinfo.name = pkg.readUTF();
            rankinfo.socre = pkg.readInt();
            rankinfo.server = pkg.readUTF();
            blueList.push(rankinfo);
            i++;
         }
         redList = new Vector.<ContentionInfo>();
         var lenRed:int = pkg.readInt();
         for(j = 0; j < lenRed; )
         {
            rankinfo = new ContentionInfo();
            rankinfo.rank = j + 1;
            rankinfo.name = pkg.readUTF();
            rankinfo.socre = pkg.readInt();
            rankinfo.server = pkg.readUTF();
            redList.push(rankinfo);
            j++;
         }
         _mainFrame.changeView(2);
      }
      
      private function _exchangeHandler(e:PkgEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var j:int = 0;
         var myInfo:* = null;
         var pkg:PackageIn = e.pkg;
         var len:int = pkg.readInt();
         for(i = 0; i < len; )
         {
            info = new WelfareInfo();
            info.ID = pkg.readInt();
            info.myExchangeCount = pkg.readInt();
            j = 0;
            while(true)
            {
               if(j >= myExchangeInfo.length)
               {
                  myExchangeInfo.push(info);
                  break;
               }
               myInfo = myExchangeInfo[j];
               if(info.ID == myInfo.ID)
               {
                  myExchangeInfo[j].myExchangeCount = info.myExchangeCount;
                  break;
               }
               j++;
            }
            i++;
         }
         myScore = pkg.readInt();
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
