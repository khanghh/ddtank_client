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
      
      private function _updateCityWide(evt:CityWideEvent) : void
      {
         _canOpenCityWide = true;
         if(_canOpenCityWide)
         {
            _playerInfo = evt.playerInfo;
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
      
      public function showView(playerInfo:PlayerInfo) : void
      {
         if(PlayerManager.Instance.Self.Grade < 11)
         {
            return;
         }
         _cityWideView = ComponentFactory.Instance.creatComponentByStylename("CityWideFrame");
         _cityWideView.playerInfo = playerInfo;
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
      
      private function _submitExit(e:Event) : void
      {
         var _baseAlerFrame:* = null;
         _cityWideView = null;
         var len:int = 0;
         if(PlayerManager.Instance.Self.IsVIP)
         {
            len = PlayerManager.Instance.Self.VIPLevel + 2;
         }
         if(PlayerManager.Instance.friendList.length >= 200 + len * 50)
         {
            _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.im.IMController.addFriend",200 + len * 50),"","",false,false,false,2);
            _baseAlerFrame.addEventListener("response",_close);
            return;
         }
         SocketManager.Instance.out.sendAddFriend(_playerInfo.NickName,0,false,true);
         PlayerManager.Instance.addEventListener("addnewfriend",_addAlert);
      }
      
      private function _close(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var aler:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         if(aler)
         {
            aler.removeEventListener("response",_close);
            aler.dispose();
            aler = null;
         }
      }
      
      private function _addAlert(e:IMEvent) : void
      {
         PlayerManager.Instance.removeEventListener("addnewfriend",_addAlert);
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation(""),LanguageMgr.GetTranslation("tank.view.bagII.baglocked.complete"),LanguageMgr.GetTranslation("tank.view.scenechatII.PrivateChatIIView.privatename"),false,false,false,2);
         alert.info.enableHtml = true;
         var str:String = LanguageMgr.GetTranslation("cityWideFrame.ONSAlertInfo");
         str = str.replace(/r/g,_playerInfo.NickName);
         alert.info.data = str;
         alert.moveEnable = false;
         alert.addEventListener("response",_responseII);
      }
      
      private function _responseII(e:FrameEvent) : void
      {
         var num:int = e.responseCode;
         SoundManager.instance.play("008");
         e.currentTarget.removeEventListener("response",_responseII);
         ObjectUtils.disposeObject(e.currentTarget);
         if(!(int(num) - 4))
         {
            ChatManager.Instance.privateChatTo(_playerInfo.NickName,_playerInfo.ID);
            ChatManager.Instance.setFocus();
         }
      }
   }
}
