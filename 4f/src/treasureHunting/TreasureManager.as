package treasureHunting
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import treasureHunting.event.TreasureEvent;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class TreasureManager extends CoreManager
   {
      
      public static const TREASURE_SHOWFRAME:String = "treasureshowframe";
      
      private static var _instance:TreasureManager;
       
      
      private var _hall:HallStateView;
      
      private var _treasureIcon:BaseButton;
      
      public var needMoney:int = 0;
      
      public var isActivityOpen:Boolean = false;
      
      public var startDate:Date;
      
      public var endDate:Date;
      
      private var _needShowLimted:Boolean = false;
      
      private var _bindMoneyReachLimted:Boolean;
      
      private var _shownOpen:Boolean = false;
      
      private var _shownClose:Boolean = false;
      
      public function TreasureManager(){super();}
      
      public static function get instance() : TreasureManager{return null;}
      
      public function get needShowLimted() : Boolean{return false;}
      
      public function set needShowLimted(param1:Boolean) : void{}
      
      public function get bindMoneyReachLimted() : Boolean{return false;}
      
      public function setup() : void{}
      
      protected function __onShowTreasureIcon(param1:PkgEvent) : void{}
      
      private function showTreasureIcon() : void{}
      
      public function initTreasureIcon(param1:HallStateView) : void{}
      
      private function createTreasureIcon() : void{}
      
      protected function __onTreasureClick(param1:MouseEvent) : void{}
      
      override protected function start() : void{}
      
      public function deleteTreasureIcon() : void{}
      
      private function __onInitTreasure(param1:PkgEvent) : void{}
      
      public function showIcon() : void{}
      
      private function __getBindMoneyLimted(param1:PkgEvent) : void{}
      
      public function showFrame() : void{}
      
      private function onMaskClick(param1:MouseEvent) : void{}
      
      public function get treasureIcon() : BaseButton{return null;}
   }
}
