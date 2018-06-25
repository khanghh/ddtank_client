package bombKing
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import bombKing.data.BKingStatueInfo;
   import bombKing.event.BombKingEvent;
   import bones.display.BoneMovieFastStarling;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.RequestVairableCreater;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import hall.IHallStateView;
   import road7th.comm.PackageIn;
   import starling.scene.hall.HallPlayerView;
   import starling.scene.hall.statue.SceneKingStatue;
   import tofflist.analyze.TofflistListTwoAnalyzer;
   import tofflist.data.TofflistListData;
   
   public class BombKingManager extends CoreManager
   {
      
      private static var _instance:BombKingManager;
       
      
      public var Recording:Boolean;
      
      public var ShowFlag:Boolean;
      
      private var _playerView:HallPlayerView;
      
      private var _defaultFlag:Boolean = true;
      
      private var _btnEnter:BaseButton;
      
      private var defaultStyleArr:Array;
      
      private var _type:int;
      
      private var _colorList:Array;
      
      private var _data:TofflistListData;
      
      public function BombKingManager()
      {
         defaultStyleArr = ["1860|head360,2201|default,3428|hair128,4429|eff129,5827|cloth327,6402|face102,70102|brick3,13201|default,15001|default,16000|default,","1730|head330,2101|default,3337|hair137,4351|eff151,5549|cloth249,6198|face98,702414|boomerang6,13101|default,15001|default,16008|chatBall8,17005|offhand5","1101|default,2101|default,3331|hair131,4151|eff51,5190|cloth90,6178|face78,70094|electricbar6,13101|default,15001|default,16000|default,"];
         _colorList = ["","",""];
         super();
      }
      
      public static function get instance() : BombKingManager
      {
         if(!_instance)
         {
            _instance = new BombKingManager();
         }
         return _instance;
      }
      
      public function addToHallStateView($hall:IHallStateView) : void
      {
         if(_btnEnter == null)
         {
            _btnEnter = ComponentFactory.Instance.creat("hall.bombKingButton");
         }
         $hall.leftTopGbox.addChild(_btnEnter);
         $hall.arrangeLeftGrid();
         _btnEnter.addEventListener("click",onEnterClick);
      }
      
      public function removeFromeHallStateView($hall:IHallStateView) : void
      {
         if(_btnEnter && _btnEnter.parent)
         {
            $hall.leftTopGbox.removeChild(_btnEnter);
         }
         _btnEnter.removeEventListener("click",onEnterClick);
         ObjectUtils.disposeObject(_btnEnter);
         _btnEnter = null;
      }
      
      protected function onEnterClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         show();
      }
      
      private function loadTop3Data(callBack:Function) : void
      {
         var tofflistListTwoAnalyzer:* = null;
         tofflistListTwoAnalyzer = new TofflistListTwoAnalyzer(callBack);
         _loadXml("CelebByDayFightPowerList.xml",tofflistListTwoAnalyzer,5);
      }
      
      private function __personalResult(analyzer:TofflistListTwoAnalyzer) : void
      {
         _data = analyzer.data;
         var id:int = (_data.list[_type] as PlayerInfo).ID;
         PlayerInfoViewControl.viewByID(id,-1,true,false);
         PlayerInfoViewControl.isOpenFromBag = false;
      }
      
      private function _loadXml($url:String, $dataAnalyzer:DataAnalyzer, $requestType:int, $loadErrorMessage:String = "") : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var loadSelfConsortiaMemberList:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath($url),$requestType,args);
         loadSelfConsortiaMemberList.loadErrorMessage = $loadErrorMessage;
         loadSelfConsortiaMemberList.analyzer = $dataAnalyzer;
         LoadResourceManager.Instance.startLoad(loadSelfConsortiaMemberList);
      }
      
      public function onPlayerClicked(type:int) : void
      {
         _type = type;
         loadTop3Data(__personalResult);
      }
      
      public function setup(view:HallPlayerView) : void
      {
         view = view;
         initSetup = function(analyzer:TofflistListTwoAnalyzer):void
         {
            _data = analyzer.data;
            _playerView = view;
            initDefaultStatue();
            updateStatus();
         };
         initEvent();
         SocketManager.Instance.out.requestBKingShowTip();
         loadTop3Data(initSetup);
      }
      
      private function updateStatus() : void
      {
         var i:int = 0;
         var isExist:* = false;
         var info:* = null;
         var _playerInfo:* = null;
         var style:* = null;
         var item:* = null;
         if(!_playerView)
         {
            return;
         }
         clearStatue();
         _defaultFlag = true;
         for(i = 0; i < 3; )
         {
            isExist = _data.list.length > i;
            if(isExist)
            {
               _defaultFlag = false;
               info = new BKingStatueInfo();
               _playerInfo = _data.list[i];
               info.name = _playerInfo.NickName;
               info.vipType = _playerInfo.typeVIP;
               info.vipLevel = _playerInfo.VIPLevel;
               style = _playerInfo.Style;
               info.style = style;
               info.color = _playerInfo.Colors;
               info.sex = _playerInfo.Sex;
               info.isAttest = _playerInfo.isAttest;
               info.rank = i;
               item = new SceneKingStatue(i);
               item.info = info;
               addToHall(item,i);
            }
            i++;
         }
         if(_defaultFlag)
         {
            initDefaultStatue();
         }
      }
      
      private function initDefaultStatue() : void
      {
         var i:int = 0;
         var info:* = null;
         var item:* = null;
         for(i = 0; i < 3; )
         {
            info = new BKingStatueInfo();
            info.style = defaultStyleArr[i];
            info.color = ",,,,,,,,,,";
            info.sex = false;
            info.isAttest = false;
            item = new SceneKingStatue(i);
            item.info = info;
            addToHall(item,i);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(263,8),__showText);
      }
      
      protected function __showText(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var str:String = pkg.readUTF();
         ChatManager.Instance.sysChatAmaranth(str);
      }
      
      protected function __updateStatue(event:PkgEvent) : void
      {
         var i:int = 0;
         var isExist:Boolean = false;
         var info:* = null;
         var style:* = null;
         var item:* = null;
         if(!_playerView)
         {
            return;
         }
         var pkg:PackageIn = event.pkg;
         clearStatue();
         _defaultFlag = true;
         for(i = 0; i < 3; )
         {
            isExist = pkg.readBoolean();
            if(isExist)
            {
               _defaultFlag = false;
               info = new BKingStatueInfo();
               info.name = pkg.readUTF();
               info.vipType = pkg.readInt();
               info.vipLevel = pkg.readInt();
               style = pkg.readUTF();
               info.style = style;
               info.color = pkg.readUTF();
               info.sex = pkg.readBoolean();
               info.isAttest = pkg.readBoolean();
               info.rank = i;
               item = new SceneKingStatue(i);
               item.info = info;
               addToHall(item,i);
            }
            i++;
         }
         if(_defaultFlag)
         {
            initDefaultStatue();
         }
      }
      
      public function cutSuitStr(style:String) : String
      {
         var arr:Array = style.split(",");
         arr[7] = "";
         return arr.join(",");
      }
      
      private function clearStatue() : void
      {
         var i:int = 0;
         var mc:* = null;
         if(_playerView == null || _playerView.staticLayer == null)
         {
            return;
         }
         var mcArr:Array = [];
         mcArr.push(_playerView.staticLayer.getBuildNpcBtnByName("bluePlatform"));
         mcArr.push(_playerView.staticLayer.getBuildNpcBtnByName("goldPlatform"));
         mcArr.push(_playerView.staticLayer.getBuildNpcBtnByName("redPlatform"));
         for(i = 0; i <= mcArr.length - 1; )
         {
            mc = mcArr[i];
            mc.removeChildAt(mc.numChildren - 1,true);
            i++;
         }
      }
      
      private function addToHall(item:SceneKingStatue, type:int) : void
      {
         if(_playerView == null || _playerView.staticLayer == null)
         {
            return;
         }
         switch(int(type))
         {
            case 0:
               item.x = -65;
               item.y = -302;
               _playerView.staticLayer.getBuildNpcBtnByName("bluePlatform").addChild(item);
               break;
            case 1:
               item.x = -60;
               item.y = -298;
               _playerView.staticLayer.getBuildNpcBtnByName("goldPlatform").addChild(item);
               break;
            case 2:
               item.x = -58;
               item.y = -283;
               _playerView.staticLayer.getBuildNpcBtnByName("redPlatform").addChild(item);
         }
      }
      
      override protected function start() : void
      {
         dispatchEvent(new BombKingEvent("bombkingOpenView"));
      }
      
      public function get defaultFlag() : Boolean
      {
         return _defaultFlag;
      }
   }
}
