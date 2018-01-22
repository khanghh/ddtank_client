package LanternFestival2015
{
   import LanternFestival2015.model.LanternFestivalModel;
   import LanternFestival2015.view.LanternFestivalInHallButton;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import hall.HallStateView;
   import road7th.comm.PackageIn;
   
   public class LanternFestivalManager extends CoreManager
   {
      
      public static const SHOW_HOME_BOARD:String = "lt15_show_home_board";
      
      public static const HIDE_HOME_BOARD:String = "lt15_hide_home_board";
      
      public static const SHOW_COOKING_BOARD:String = "lt15_show_cooking_board";
      
      public static const UPDATE:String = "lt15_update";
      
      public static const UPDATE_MAKE_BOARD:String = "lt15_update_make_board";
      
      private static var instance:LanternFestivalManager;
       
      
      private var _model:LanternFestivalModel;
      
      private var _hall:HallStateView;
      
      private var _iconLantern:LanternFestivalInHallButton;
      
      private var _showType:String = "";
      
      private var _playerBG:Sprite;
      
      private var _showTarget:DisplayObject;
      
      private var _firstRequestIsOpen:Boolean = true;
      
      public function LanternFestivalManager(param1:inner)
      {
         super();
         _model = new LanternFestivalModel();
      }
      
      public static function getInstance() : LanternFestivalManager
      {
         if(!instance)
         {
            instance = new LanternFestivalManager(new inner());
         }
         return instance;
      }
      
      public function get model() : LanternFestivalModel
      {
         return _model;
      }
      
      private function addHomeEvents() : void
      {
         var _loc1_:int = 300;
         var _loc2_:int = 4;
         SocketManager.Instance.addEventListener(PkgEvent.format(_loc1_,_loc2_),onGetData);
      }
      
      private function removeHomeEvents() : void
      {
         var _loc1_:int = 300;
         var _loc2_:int = 4;
         SocketManager.Instance.removeEventListener(PkgEvent.format(_loc1_,_loc2_),onGetData);
      }
      
      private function addCookEvents() : void
      {
         PlayerManager.Instance.addEventListener("propbag_update",onBagUpdate);
      }
      
      private function removeCookEvents() : void
      {
         PlayerManager.Instance.removeEventListener("propbag_update",onBagUpdate);
      }
      
      protected function onGetData(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _model.numSendRemain = _loc2_.readInt();
         _model.numReceiveRemain = _loc2_.readInt();
         dispatchEvent(new CEvent("lt15_update"));
      }
      
      protected function onIsOpen(param1:PkgEvent) : void
      {
         _firstRequestIsOpen = false;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc3_.readBoolean();
         isOpen(_loc2_);
      }
      
      public function isOpen(param1:Boolean) : void
      {
         if(param1)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("lantern2015.activity.open"));
         }
         else if(_model.isActivityOpen)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("lantern2015.activity.close"));
         }
         _model.isActivityOpen = param1;
         showHallIcon(_hall);
      }
      
      protected function onBagUpdate(param1:Event) : void
      {
         dispatchEvent(new CEvent("lt15_update_make_board"));
      }
      
      public function dispose() : void
      {
         removeCookEvents();
         removeHomeEvents();
         _hall = null;
         _iconLantern = null;
      }
      
      public function setup() : void
      {
         var _loc2_:int = 300;
         var _loc1_:int = 1;
         SocketManager.Instance.addEventListener(PkgEvent.format(_loc2_,_loc1_),onIsOpen);
      }
      
      override protected function start() : void
      {
         if(_showType != "")
         {
            dispatchEvent(new CEvent(_showType));
         }
      }
      
      public function get playerBG() : Sprite
      {
         return _playerBG;
      }
      
      public function get showTarget() : DisplayObject
      {
         return _showTarget;
      }
      
      public function showHomeBoard(param1:Object, param2:Sprite) : void
      {
         _showType = "lt15_show_home_board";
         _showTarget = param1 as DisplayObject;
         _playerBG = param2;
         show();
         requireData();
      }
      
      public function afterHideCookBoard() : void
      {
         removeCookEvents();
      }
      
      public function showCookingBoard() : void
      {
         addCookEvents();
         _showType = "lt15_show_cooking_board";
         show();
      }
      
      public function showHallIcon(param1:HallStateView) : void
      {
         _hall = param1;
         if(_hall == null)
         {
            return;
         }
         if(_model.isActivityOpen)
         {
            if(_iconLantern == null)
            {
               _iconLantern = ComponentFactory.Instance.creatComponentByStylename("lantern2015.showFrameBtn");
            }
            _iconLantern.show(_hall);
         }
         else if(_iconLantern != null)
         {
            ObjectUtils.disposeObject(_iconLantern);
            _iconLantern = null;
         }
      }
      
      private function requireActivityIsOpen() : void
      {
         GameInSocketOut.sendLanternIsOpen();
      }
      
      private function requireData() : void
      {
         GameInSocketOut.sendLanternRequireData();
      }
      
      private function requireMakeLantern(param1:int) : void
      {
         GameInSocketOut.sendLanternMakeLantern(param1);
      }
      
      private function requireCookLantern(param1:int) : void
      {
         GameInSocketOut.sendLanternCookLantern(param1);
      }
      
      private function requireGainWishGift() : void
      {
         GameInSocketOut.sendLanternGainWishGift();
      }
      
      public function onBtnCookClicked(param1:int) : void
      {
         var _loc2_:* = null;
         if(param1 > 0)
         {
            requireCookLantern(param1);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("lantern2015.cookFailed");
            MessageTipManager.getInstance().show(_loc2_,0,false,1);
         }
      }
      
      public function onBtnMakeClicked(param1:int) : void
      {
         var _loc2_:* = null;
         if(param1 > 0)
         {
            requireMakeLantern(param1);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("lantern2015.makeFailed");
            MessageTipManager.getInstance().show(_loc2_,0,false,1);
         }
      }
      
      public function onActivityButtonClick() : void
      {
         dispatchEvent(new CEvent("lt15_show_cooking_board"));
      }
      
      public function onBtnInHallClicked() : void
      {
         _model.initData();
         showCookingBoard();
      }
      
      public function onEnterHome() : void
      {
         _model.initData();
         addHomeEvents();
      }
      
      public function initHall(param1:HallStateView) : void
      {
         _hall = param1;
         if(_firstRequestIsOpen)
         {
            requireActivityIsOpen();
            _firstRequestIsOpen = false;
         }
         else
         {
            showHallIcon(_hall);
         }
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
