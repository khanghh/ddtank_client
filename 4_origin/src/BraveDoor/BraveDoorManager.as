package BraveDoor
{
   import BraveDoor.data.BraveDoorDuplicateInfo;
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.data.analyze.BraveDoorDuplicateAnalyzer;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class BraveDoorManager extends EventDispatcher
   {
      
      private static var _instance:BraveDoorManager = null;
       
      
      private var _showFlag:Boolean = false;
      
      private var _endDate:Date;
      
      private var _hall:HallStateView = null;
      
      private var _iconBtn:BaseButton = null;
      
      private var _currentPage:int = 0;
      
      private var _isShow:Boolean = false;
      
      private var _duplicates:Vector.<BraveDoorDuplicateInfo>;
      
      private var _clickNum:Number = 0;
      
      public function BraveDoorManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : BraveDoorManager
      {
         if(_instance == null)
         {
            _instance = new BraveDoorManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(315),_isOpen);
      }
      
      public function initHall(param1:HallStateView) : void
      {
         _hall = param1;
         checkIcon();
      }
      
      protected function _isOpen(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _showFlag = _loc2_.readBoolean();
         if(_showFlag && PlayerManager.Instance.Self.Grade >= 20)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("game.braveDoor.openMsg"));
         }
         checkIcon();
      }
      
      public function checkIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("bravedoor",_showFlag);
      }
      
      public function openView_Handler() : void
      {
         SoundManager.instance.playButtonSound();
         var _loc1_:Number = new Date().time;
         if(_loc1_ - _clickNum < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return;
         }
         _clickNum = _loc1_;
         show();
      }
      
      public function show() : void
      {
         AssetModuleLoader.addModelLoader("braveDoor",6);
         AssetModuleLoader.startCodeLoader(__complainShow);
      }
      
      private function __complainShow() : void
      {
         if(_duplicates != null)
         {
            openView();
            return;
         }
      }
      
      public function setupDuplicateTemplate(param1:BraveDoorDuplicateAnalyzer) : void
      {
         _duplicates = param1.list;
      }
      
      public function openView() : void
      {
         if(!_isShow)
         {
            _isShow = true;
            dispatchEvent(new CEvent("openBraveDoorView"));
         }
      }
      
      public function getDuplicateTemInfo() : Vector.<BraveDoorDuplicateInfo>
      {
         return _duplicates;
      }
      
      protected function get duplicateTemplatePath() : String
      {
         return PathManager.getBraveDoorDuplicateTemplete("braveDoor");
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         _currentPage = param1;
      }
      
      public function get moduleIsShow() : Boolean
      {
         return _isShow;
      }
      
      public function set moduleIsShow(param1:Boolean) : void
      {
         _isShow = param1;
      }
   }
}
