package cityWide
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import vip.VipController;
   
   public class CityWideFrame extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _vipName:GradientText;
      
      private var _nickNameText:FilterFrameText;
      
      private var _vipNamePoint:Point;
      
      private var _playerView:RoomCharacter;
      
      private var _cityWideText1:FilterFrameText;
      
      private var _cityWideText2:FilterFrameText;
      
      private var _cityWideText3:FilterFrameText;
      
      private var _addFriend:BaseButton;
      
      private var _addFriendBg2:ScaleBitmapImage;
      
      private var _addFriendSpeed:int;
      
      private var _playerViewPoint:Point;
      
      private var _cityWideBg:MovieClip;
      
      private var _playerInfo:PlayerInfo;
      
      public function CityWideFrame()
      {
         super();
      }
      
      public function set playerInfo(info:PlayerInfo) : void
      {
         _playerInfo = info;
      }
      
      private function setView() : void
      {
         _addFriendSpeed = -1;
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("cityWideFrame.ONSTitle"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false);
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _vipNamePoint = ComponentFactory.Instance.creatCustomObject("VipNamePoint");
         if(_playerInfo.IsVIP)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(138,_playerInfo.typeVIP);
            _vipName.textSize = 18;
            _vipName.x = _vipNamePoint.x;
            _vipName.y = _vipNamePoint.y;
            _vipName.text = _playerInfo.NickName as String;
            addToContent(_vipName);
            DisplayUtils.removeDisplay(_nickNameText);
         }
         else
         {
            _nickNameText = ComponentFactory.Instance.creatComponentByStylename("cityWide.CityWideFrame.nickNameText");
            _nickNameText.text = _playerInfo.NickName as String;
            addChild(_nickNameText);
            DisplayUtils.removeDisplay(_vipName);
         }
         _cityWideBg = ClassUtils.CreatInstance("asset.ddtcivil.newcityPlayerBg1");
         PositionUtils.setPos(_cityWideBg,"cityWideBgPos");
         addToContent(_cityWideBg);
         _playerView = CharactoryFactory.createCharacter(_playerInfo,"room") as RoomCharacter;
         _playerView.showGun = false;
         _playerView.show();
         _playerView.setShowLight(true);
         _playerViewPoint = ComponentFactory.Instance.creatCustomObject("playerViewPoint");
         _playerView.x = _playerViewPoint.x;
         _playerView.y = _playerViewPoint.y;
         _playerView.scaleX = -1;
         addToContent(_playerView);
         _addFriendBg2 = ComponentFactory.Instance.creatComponentByStylename("cityWide.rightBg");
         addToContent(_addFriendBg2);
         _cityWideText1 = ComponentFactory.Instance.creat("asset.core.cityWideHi1");
         _cityWideText1.htmlText = LanguageMgr.GetTranslation("civil.cityWide.text1");
         addToContent(_cityWideText1);
         _cityWideText2 = ComponentFactory.Instance.creat("asset.core.cityWideHi2");
         _cityWideText2.htmlText = LanguageMgr.GetTranslation("civil.cityWide.text2");
         addToContent(_cityWideText2);
         _cityWideText3 = ComponentFactory.Instance.creat("asset.core.cityWideHi3");
         _cityWideText3.htmlText = LanguageMgr.GetTranslation("civil.cityWide.text3");
         addToContent(_cityWideText3);
         _addFriend = ComponentFactory.Instance.creatComponentByStylename("cityWide.CityWideFrame.addFriendBt");
         addToContent(_addFriend);
      }
      
      public function show() : void
      {
         setView();
         setEvent();
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      public function setList(arr:Array) : void
      {
      }
      
      private function _thisInFrame(e:Event) : void
      {
      }
      
      private function _clickaddFriend(e:MouseEvent) : void
      {
         dispose();
         SoundManager.instance.play("008");
         dispatchEvent(new Event("submit"));
      }
      
      private function removeView() : void
      {
         _alertInfo = null;
         _vipNamePoint = null;
         _playerInfo = null;
         if(_nickNameText)
         {
            ObjectUtils.disposeObject(_nickNameText);
         }
         _nickNameText = null;
         if(_playerView)
         {
            ObjectUtils.disposeObject(_playerView);
         }
         _playerView = null;
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         if(_cityWideBg)
         {
            ObjectUtils.disposeObject(_cityWideBg);
         }
         _cityWideBg = null;
         if(_cityWideText1)
         {
            ObjectUtils.disposeObject(_cityWideText1);
         }
         _cityWideText1 = null;
         if(_cityWideText2)
         {
            ObjectUtils.disposeObject(_cityWideText2);
         }
         _cityWideText2 = null;
         if(_cityWideText3)
         {
            ObjectUtils.disposeObject(_cityWideText3);
         }
         _cityWideText3 = null;
         if(_addFriend)
         {
            ObjectUtils.disposeObject(_addFriend);
         }
         _addFriend = null;
         if(_addFriendBg2)
         {
            ObjectUtils.disposeObject(_addFriendBg2);
         }
         _addFriendBg2 = null;
      }
      
      private function setEvent() : void
      {
         addEventListener("response",onFrameResponse);
         addEventListener("enterFrame",_thisInFrame);
         _addFriend.addEventListener("click",_clickaddFriend);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",onFrameResponse);
         removeEventListener("enterFrame",_thisInFrame);
      }
      
      private function onFrameResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               dispose();
               dispatchEvent(new Event("close"));
               break;
            case 2:
            case 3:
            case 4:
               dispose();
               dispatchEvent(new Event("submit"));
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         removeView();
         super.dispose();
      }
   }
}
