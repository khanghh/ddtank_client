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
      
      public function LanternFestivalManager(single:inner)
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
         var lv1:int = 300;
         var lv2:int = 4;
         SocketManager.Instance.addEventListener(PkgEvent.format(lv1,lv2),onGetData);
      }
      
      private function removeHomeEvents() : void
      {
         var lv1:int = 300;
         var lv2:int = 4;
         SocketManager.Instance.removeEventListener(PkgEvent.format(lv1,lv2),onGetData);
      }
      
      private function addCookEvents() : void
      {
         PlayerManager.Instance.addEventListener("propbag_update",onBagUpdate);
      }
      
      private function removeCookEvents() : void
      {
         PlayerManager.Instance.removeEventListener("propbag_update",onBagUpdate);
      }
      
      protected function onGetData(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _model.numSendRemain = pkg.readInt();
         _model.numReceiveRemain = pkg.readInt();
         dispatchEvent(new CEvent("lt15_update"));
      }
      
      protected function onIsOpen(e:PkgEvent) : void
      {
         _firstRequestIsOpen = false;
         var pkg:PackageIn = e.pkg;
         var __isOpen:Boolean = pkg.readBoolean();
         isOpen(__isOpen);
      }
      
      public function isOpen(isOpen:Boolean) : void
      {
         if(isOpen)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("lantern2015.activity.open"));
         }
         else if(_model.isActivityOpen)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("lantern2015.activity.close"));
         }
         _model.isActivityOpen = isOpen;
         showHallIcon(_hall);
      }
      
      protected function onBagUpdate(e:Event) : void
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
         var lv1:int = 300;
         var lv21:int = 1;
         SocketManager.Instance.addEventListener(PkgEvent.format(lv1,lv21),onIsOpen);
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
      
      public function showHomeBoard(target:Object, playerBG:Sprite) : void
      {
         _showType = "lt15_show_home_board";
         _showTarget = target as DisplayObject;
         _playerBG = playerBG;
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
      
      public function showHallIcon($hall:HallStateView) : void
      {
         _hall = $hall;
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
      
      private function requireMakeLantern(num:int) : void
      {
         GameInSocketOut.sendLanternMakeLantern(num);
      }
      
      private function requireCookLantern(num:int) : void
      {
         GameInSocketOut.sendLanternCookLantern(num);
      }
      
      private function requireGainWishGift() : void
      {
         GameInSocketOut.sendLanternGainWishGift();
      }
      
      public function onBtnCookClicked(count:int) : void
      {
         var msgString:* = null;
         if(count > 0)
         {
            requireCookLantern(count);
         }
         else
         {
            msgString = LanguageMgr.GetTranslation("lantern2015.cookFailed");
            MessageTipManager.getInstance().show(msgString,0,false,1);
         }
      }
      
      public function onBtnMakeClicked(count:int) : void
      {
         var msgString:* = null;
         if(count > 0)
         {
            requireMakeLantern(count);
         }
         else
         {
            msgString = LanguageMgr.GetTranslation("lantern2015.makeFailed");
            MessageTipManager.getInstance().show(msgString,0,false,1);
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
      
      public function initHall($hall:HallStateView) : void
      {
         _hall = $hall;
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
