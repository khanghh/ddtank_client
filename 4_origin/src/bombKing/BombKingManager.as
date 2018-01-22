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
      
      public function addToHallStateView(param1:IHallStateView) : void
      {
         if(_btnEnter == null)
         {
            _btnEnter = ComponentFactory.Instance.creat("hall.bombKingButton");
         }
         param1.leftTopGbox.addChild(_btnEnter);
         param1.arrangeLeftGrid();
         _btnEnter.addEventListener("click",onEnterClick);
      }
      
      public function removeFromeHallStateView(param1:IHallStateView) : void
      {
         if(_btnEnter && _btnEnter.parent)
         {
            param1.leftTopGbox.removeChild(_btnEnter);
         }
         _btnEnter.removeEventListener("click",onEnterClick);
         ObjectUtils.disposeObject(_btnEnter);
         _btnEnter = null;
      }
      
      protected function onEnterClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         show();
      }
      
      private function loadTop3Data(param1:Function) : void
      {
         var _loc2_:* = null;
         _loc2_ = new TofflistListTwoAnalyzer(param1);
         _loadXml("CelebByDayFightPowerList.xml",_loc2_,5);
      }
      
      private function __personalResult(param1:TofflistListTwoAnalyzer) : void
      {
         _data = param1.data;
         var _loc2_:int = (_data.list[_type] as PlayerInfo).ID;
         PlayerInfoViewControl.viewByID(_loc2_,-1,true,false);
         PlayerInfoViewControl.isOpenFromBag = false;
      }
      
      private function _loadXml(param1:String, param2:DataAnalyzer, param3:int, param4:String = "") : void
      {
         var _loc5_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var _loc6_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath(param1),param3,_loc5_);
         _loc6_.loadErrorMessage = param4;
         _loc6_.analyzer = param2;
         LoadResourceManager.Instance.startLoad(_loc6_);
      }
      
      public function onPlayerClicked(param1:int) : void
      {
         _type = param1;
         loadTop3Data(__personalResult);
      }
      
      public function setup(param1:HallPlayerView) : void
      {
         view = param1;
         initSetup = function(param1:TofflistListTwoAnalyzer):void
         {
            _data = param1.data;
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
         var _loc6_:int = 0;
         var _loc2_:* = false;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         if(!_playerView)
         {
            return;
         }
         clearStatue();
         _defaultFlag = true;
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc2_ = _data.list.length > _loc6_;
            if(_loc2_)
            {
               _defaultFlag = false;
               _loc5_ = new BKingStatueInfo();
               _loc4_ = _data.list[_loc6_];
               _loc5_.name = _loc4_.NickName;
               _loc5_.vipType = _loc4_.typeVIP;
               _loc5_.vipLevel = _loc4_.VIPLevel;
               _loc1_ = _loc4_.Style;
               _loc5_.style = _loc1_;
               _loc5_.color = _loc4_.Colors;
               _loc5_.sex = _loc4_.Sex;
               _loc5_.isAttest = _loc4_.isAttest;
               _loc5_.rank = _loc6_;
               _loc3_ = new SceneKingStatue(_loc6_);
               _loc3_.info = _loc5_;
               addToHall(_loc3_,_loc6_);
            }
            _loc6_++;
         }
         if(_defaultFlag)
         {
            initDefaultStatue();
         }
      }
      
      private function initDefaultStatue() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc2_ = new BKingStatueInfo();
            _loc2_.style = defaultStyleArr[_loc3_];
            _loc2_.color = ",,,,,,,,,,";
            _loc2_.sex = false;
            _loc2_.isAttest = false;
            _loc1_ = new SceneKingStatue(_loc3_);
            _loc1_.info = _loc2_;
            addToHall(_loc1_,_loc3_);
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(263,8),__showText);
      }
      
      protected function __showText(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:String = _loc3_.readUTF();
         ChatManager.Instance.sysChatAmaranth(_loc2_);
      }
      
      protected function __updateStatue(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc3_:Boolean = false;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(!_playerView)
         {
            return;
         }
         var _loc5_:PackageIn = param1.pkg;
         clearStatue();
         _defaultFlag = true;
         _loc7_ = 0;
         while(_loc7_ < 3)
         {
            _loc3_ = _loc5_.readBoolean();
            if(_loc3_)
            {
               _defaultFlag = false;
               _loc6_ = new BKingStatueInfo();
               _loc6_.name = _loc5_.readUTF();
               _loc6_.vipType = _loc5_.readInt();
               _loc6_.vipLevel = _loc5_.readInt();
               _loc2_ = _loc5_.readUTF();
               _loc6_.style = _loc2_;
               _loc6_.color = _loc5_.readUTF();
               _loc6_.sex = _loc5_.readBoolean();
               _loc6_.isAttest = _loc5_.readBoolean();
               _loc6_.rank = _loc7_;
               _loc4_ = new SceneKingStatue(_loc7_);
               _loc4_.info = _loc6_;
               addToHall(_loc4_,_loc7_);
            }
            _loc7_++;
         }
         if(_defaultFlag)
         {
            initDefaultStatue();
         }
      }
      
      public function cutSuitStr(param1:String) : String
      {
         var _loc2_:Array = param1.split(",");
         _loc2_[7] = "";
         return _loc2_.join(",");
      }
      
      private function clearStatue() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(_playerView == null || _playerView.staticLayer == null)
         {
            return;
         }
         var _loc1_:Array = [];
         _loc1_.push(_playerView.staticLayer.getBuildNpcBtnByName("bluePlatform"));
         _loc1_.push(_playerView.staticLayer.getBuildNpcBtnByName("goldPlatform"));
         _loc1_.push(_playerView.staticLayer.getBuildNpcBtnByName("redPlatform"));
         _loc3_ = 0;
         while(_loc3_ <= _loc1_.length - 1)
         {
            _loc2_ = _loc1_[_loc3_];
            _loc2_.removeChildAt(_loc2_.numChildren - 1,true);
            _loc3_++;
         }
      }
      
      private function addToHall(param1:SceneKingStatue, param2:int) : void
      {
         if(_playerView == null || _playerView.staticLayer == null)
         {
            return;
         }
         switch(int(param2))
         {
            case 0:
               param1.x = -65;
               param1.y = -302;
               _playerView.staticLayer.getBuildNpcBtnByName("bluePlatform").addChild(param1);
               break;
            case 1:
               param1.x = -60;
               param1.y = -298;
               _playerView.staticLayer.getBuildNpcBtnByName("goldPlatform").addChild(param1);
               break;
            case 2:
               param1.x = -58;
               param1.y = -283;
               _playerView.staticLayer.getBuildNpcBtnByName("redPlatform").addChild(param1);
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
