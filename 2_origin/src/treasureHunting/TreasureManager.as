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
      
      public function TreasureManager()
      {
         super();
      }
      
      public static function get instance() : TreasureManager
      {
         if(!_instance)
         {
            _instance = new TreasureManager();
         }
         return _instance;
      }
      
      public function get needShowLimted() : Boolean
      {
         return _needShowLimted;
      }
      
      public function set needShowLimted(param1:Boolean) : void
      {
         _needShowLimted = param1;
      }
      
      public function get bindMoneyReachLimted() : Boolean
      {
         return _bindMoneyReachLimted;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(110,0),__onShowTreasureIcon);
         SocketManager.Instance.addEventListener(PkgEvent.format(110,1),__onInitTreasure);
         SocketManager.Instance.addEventListener(PkgEvent.format(110,7),__getBindMoneyLimted);
         SocketManager.Instance.out.sendInitTreasueHunting();
      }
      
      protected function __onShowTreasureIcon(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
      }
      
      private function showTreasureIcon() : void
      {
         if(_hall != null)
         {
            createTreasureIcon();
         }
      }
      
      public function initTreasureIcon(param1:HallStateView) : void
      {
         if(isActivityOpen)
         {
            createTreasureIcon();
         }
      }
      
      private function createTreasureIcon() : void
      {
         if(_treasureIcon == null)
         {
            _treasureIcon = ComponentFactory.Instance.creatComponentByStylename("hall.treasure.showIcon");
            _treasureIcon.addEventListener("click",__onTreasureClick);
         }
      }
      
      protected function __onTreasureClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         show();
      }
      
      override protected function start() : void
      {
         dispatchEvent(new TreasureEvent("teasureOpenView"));
      }
      
      public function deleteTreasureIcon() : void
      {
         if(_treasureIcon)
         {
            _treasureIcon.removeEventListener("click",__onTreasureClick);
            ObjectUtils.disposeObject(_treasureIcon);
            _treasureIcon = null;
         }
      }
      
      private function __onInitTreasure(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc3_.readBoolean();
         isActivityOpen = _loc3_.readBoolean();
         if(isActivityOpen)
         {
            startDate = _loc3_.readDate();
            endDate = _loc3_.readDate();
            needMoney = _loc3_.readInt();
            showIcon();
            if(_loc2_)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("treasureHunting.start"));
            }
         }
         else
         {
            if(!WonderfulActivityManager.Instance.frameFlag)
            {
               HallIconManager.instance.updateSwitchHandler("treasureHunting",false);
            }
            if(_loc2_)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("treasureHunting.end"));
            }
         }
      }
      
      public function showIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("treasureHunting",true);
      }
      
      private function __getBindMoneyLimted(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _bindMoneyReachLimted = _loc2_.readBoolean();
         _needShowLimted = true;
      }
      
      public function showFrame() : void
      {
         dispatchEvent(new Event("treasureshowframe"));
      }
      
      private function onMaskClick(param1:MouseEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.huntingNow"));
      }
      
      public function get treasureIcon() : BaseButton
      {
         return _treasureIcon;
      }
   }
}
