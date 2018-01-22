package roulette
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class LeftGunRouletteManager extends CoreManager
   {
      
      private static var _instance:LeftGunRouletteManager = null;
      
      private static const TYPE_ROULETTE:int = 1;
      
      private static const TYPEI_ISOPEN:int = 1;
      
      private static const MAX_LENGTH:int = 20;
       
      
      public var reward:String;
      
      public var gCount:int;
      
      private var _alertAward:BaseAlerFrame;
      
      public var IsOpen:Boolean;
      
      public var ArrNum:Array;
      
      public var beginTime:Date;
      
      public var endTime:Date;
      
      public var isFrist:Boolean = false;
      
      public var isvisible:Boolean = true;
      
      private var isShow:Boolean;
      
      private var _content:Sprite;
      
      public function LeftGunRouletteManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : LeftGunRouletteManager{return null;}
      
      public function init() : void{}
      
      private function __openRoulett(param1:PkgEvent) : void{}
      
      public function showGunButton() : void{}
      
      public function hideGunButton() : void{}
      
      private function removeGunBtn() : void{}
      
      public function showTurnplate() : void{}
      
      public function showTipFrame(param1:String) : void{}
      
      private function getReward(param1:String) : String{return null;}
      
      public function createFrame(param1:Sprite = null) : void{}
      
      private function __goRenewal(param1:FrameEvent) : void{}
   }
}
