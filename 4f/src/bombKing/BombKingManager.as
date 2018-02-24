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
      
      public function BombKingManager(){super();}
      
      public static function get instance() : BombKingManager{return null;}
      
      public function addToHallStateView(param1:IHallStateView) : void{}
      
      public function removeFromeHallStateView(param1:IHallStateView) : void{}
      
      protected function onEnterClick(param1:MouseEvent) : void{}
      
      private function loadTop3Data(param1:Function) : void{}
      
      private function __personalResult(param1:TofflistListTwoAnalyzer) : void{}
      
      private function _loadXml(param1:String, param2:DataAnalyzer, param3:int, param4:String = "") : void{}
      
      public function onPlayerClicked(param1:int) : void{}
      
      public function setup(param1:HallPlayerView) : void{}
      
      private function updateStatus() : void{}
      
      private function initDefaultStatue() : void{}
      
      private function initEvent() : void{}
      
      protected function __showText(param1:PkgEvent) : void{}
      
      protected function __updateStatue(param1:PkgEvent) : void{}
      
      public function cutSuitStr(param1:String) : String{return null;}
      
      private function clearStatue() : void{}
      
      private function addToHall(param1:SceneKingStatue, param2:int) : void{}
      
      override protected function start() : void{}
      
      public function get defaultFlag() : Boolean{return false;}
   }
}
