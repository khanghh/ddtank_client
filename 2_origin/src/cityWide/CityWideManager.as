package cityWide
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.action.FrameShowAction;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.utils.setInterval;
   import im.IMEvent;
   
   public class CityWideManager
   {
      
      private static var _instance:CityWideManager;
       
      
      private var _cityWideView:CityWideFrame;
      
      private var _playerInfo:PlayerInfo;
      
      private var _canOpenCityWide:Boolean = true;
      
      private const TIMES:int = 300000;
      
      public function CityWideManager()
      {
         super();
      }
      
      public static function get Instance() : CityWideManager
      {
         if(_instance == null)
         {
            _instance = new CityWideManager();
         }
         return _instance;
      }
      
      public function init() : void
      {
         PlayerManager.Instance.addEventListener("ons_playerInfo",_updateCityWide);
      }
      
      private function _updateCityWide(param1:CityWideEvent) : void
      {
         _canOpenCityWide = true;
         if(_canOpenCityWide)
         {
            _playerInfo = param1.playerInfo;
            showView(_playerInfo);
            _canOpenCityWide = false;
            setInterval(changeBoolean,300000);
         }
      }
      
      public function toSendOpenCityWide() : void
      {
         SocketManager.Instance.out.sendOns();
      }
      
      private function changeBoolean() : void
      {
         _canOpenCityWide = true;
      }
      
      public function showView(param1:PlayerInfo) : void
      {
         if(PlayerManager.Instance.Self.Grade < 11)
         {
            return;
         }
         _cityWideView = ComponentFactory.Instance.creatComponentByStylename("CityWideFrame");
         _cityWideView.playerInfo = param1;
         _cityWideView.addEventListener("submit",_submitExit);
         if(CacheSysManager.isLock("alertInFight"))
         {
            CacheSysManager.getInstance().cache("alertInFight",new FrameShowAction(_cityWideView));
         }
         else if(CacheSysManager.isLock("church_guide"))
         {
            CacheSysManager.getInstance().cache("church_guide",new FrameShowAction(_cityWideView));
         }
         else if(CacheSysManager.isLock("consortia_guide"))
         {
            CacheSysManager.getInstance().cache("consortia_guide",new FrameShowAction(_cityWideView));
         }
         else if(CacheSysManager.isLock("sales_room_guide"))
         {
            CacheSysManager.getInstance().cache("sales_room_guide",new FrameShowAction(_cityWideView));
         }
         else if(CacheSysManager.isLock("farm_guide"))
         {
            CacheSysManager.getInstance().cache("farm_guide",new FrameShowAction(_cityWideView));
         }
         else if(CacheSysManager.isLock("arena_guide"))
         {
            CacheSysManager.getInstance().cache("arena_guide",new FrameShowAction(_cityWideView));
         }
         else if(CacheSysManager.isLock("secret_area_guide"))
         {
            CacheSysManager.getInstance().cache("secret_area_guide",new FrameShowAction(_cityWideView));
         }
         else if(CacheSysManager.isLock("crypt_guide"))
         {
            CacheSysManager.getInstance().cache("crypt_guide",new FrameShowAction(_cityWideView));
         }
         else
         {
            _cityWideView.show();
         }
      }
      
      public function hideView() : void
      {
      }
      
      private function _submitExit(param1:Event) : void
      {
         var _loc2_:* = null;
         _cityWideView = null;
         var _loc3_:int = 0;
         if(PlayerManager.Instance.Self.IsVIP)
         {
            _loc3_ = PlayerManager.Instance.Self.VIPLevel + 2;
         }
         if(PlayerManager.Instance.friendList.length >= 200 + _loc3_ * 50)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.im.IMController.addFriend",200 + _loc3_ * 50),"","",false,false,false,2);
            _loc2_.addEventListener("response",_close);
            return;
         }
         SocketManager.Instance.out.sendAddFriend(_playerInfo.NickName,0,false,true);
         PlayerManager.Instance.addEventListener("addnewfriend",_addAlert);
      }
      
      private function _close(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(_loc2_)
         {
            _loc2_.removeEventListener("response",_close);
            _loc2_.dispose();
            _loc2_ = null;
         }
      }
      
      private function _addAlert(param1:IMEvent) : void
      {
         PlayerManager.Instance.removeEventListener("addnewfriend",_addAlert);
         var _loc3_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation(""),LanguageMgr.GetTranslation("tank.view.bagII.baglocked.complete"),LanguageMgr.GetTranslation("tank.view.scenechatII.PrivateChatIIView.privatename"),false,false,false,2);
         _loc3_.info.enableHtml = true;
         var _loc2_:String = LanguageMgr.GetTranslation("cityWideFrame.ONSAlertInfo");
         _loc2_ = _loc2_.replace(/r/g,_playerInfo.NickName);
         _loc3_.info.data = _loc2_;
         _loc3_.moveEnable = false;
         _loc3_.addEventListener("response",_responseII);
      }
      
      private function _responseII(param1:FrameEvent) : void
      {
         var _loc2_:int = param1.responseCode;
         SoundManager.instance.play("008");
         param1.currentTarget.removeEventListener("response",_responseII);
         ObjectUtils.disposeObject(param1.currentTarget);
         if(!(int(_loc2_) - 4))
         {
            ChatManager.Instance.privateChatTo(_playerInfo.NickName,_playerInfo.ID);
            ChatManager.Instance.setFocus();
         }
      }
   }
}
