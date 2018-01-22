package ringStation.view
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import ringStation.model.BattleFieldListItemInfo;
   import vip.VipController;
   
   public class BattleFieldsItem extends Sprite implements Disposeable
   {
       
      
      private var _fightIconBg:Bitmap;
      
      private var _fightIcon:Bitmap;
      
      private var _infoText:FilterFrameText;
      
      private var _index:int;
      
      private var _nickNameText:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _battleInfo:BattleFieldListItemInfo;
      
      private var _playerInfo:PlayerInfo;
      
      private var msgID:String = "1";
      
      public function BattleFieldsItem(param1:int)
      {
         super();
         _index = param1;
         init();
      }
      
      private function init() : void
      {
         _infoText = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.battleField.itemInfo");
         addChild(_infoText);
         _nickNameText = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.battleItem.nickNameText");
         _nickNameText.mouseEnabled = true;
         _nickNameText.addEventListener("link",__nickNameLinkHandler);
         addChild(_nickNameText);
      }
      
      public function update(param1:BattleFieldListItemInfo) : void
      {
         _battleInfo = param1;
         if(_fightIconBg)
         {
            ObjectUtils.disposeObject(_fightIconBg);
         }
         _fightIconBg = null;
         if(_fightIcon)
         {
            ObjectUtils.disposeObject(_fightIcon);
         }
         _fightIcon = null;
         if(_battleInfo.DareFlag)
         {
            _fightIcon = ComponentFactory.Instance.creatBitmap("ringStation.view.swordIcon");
         }
         else
         {
            _fightIcon = ComponentFactory.Instance.creatBitmap("ringStation.view.shieldIcon");
         }
         _fightIconBg = ComponentFactory.Instance.creat("ringStation.view.fightIconBg");
         addChild(_fightIconBg);
         addChild(_fightIcon);
         var _loc2_:String = "";
         _loc2_ = _index == 0?LanguageMgr.GetTranslation("ringStation.view.battleFieldsView.itemInfoNew") + " ":"";
         _infoText.htmlText = _loc2_ + updateText(_battleInfo);
         _nickNameText.htmlText = "<u><a href=\'event:battleTxt\'>" + setUerNameLength(_battleInfo.UserName) + "</a></u>";
         if(msgID == "1" || msgID == "2" || msgID == "5")
         {
            _nickNameText.x = 203;
         }
         else
         {
            _nickNameText.x = 96;
         }
         if(_index == 0)
         {
            _nickNameText.x = _nickNameText.x + 27;
         }
         findPlayer(param1.UserName);
      }
      
      private function findPlayer(param1:String) : void
      {
         _playerInfo = new PlayerInfo();
         if(param1 == PlayerManager.Instance.Self.NickName)
         {
            _playerInfo = PlayerManager.Instance.Self;
         }
         else
         {
            _playerInfo = PlayerManager.Instance.findPlayerByNickName(_playerInfo,param1);
         }
         if(_playerInfo.ID && _playerInfo.Style)
         {
            updateTxt();
         }
         else
         {
            SocketManager.Instance.out.sendItemEquip(param1,true);
            _playerInfo.addEventListener("propertychange",__playerInfoChange);
         }
      }
      
      private function __playerInfoChange(param1:PlayerPropertyEvent) : void
      {
         _playerInfo.removeEventListener("propertychange",__playerInfoChange);
         updateTxt();
      }
      
      private function updateTxt() : void
      {
         var _loc1_:String = setUerNameLength(_playerInfo.NickName);
         if(_playerInfo.IsVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(104,_playerInfo.typeVIP);
            _vipName.addEventListener("click",__nickNameLinkHandler);
            _vipName.textField.autoSize = "none";
            _vipName.textField.setTextFormat(_nickNameText.getTextFormat());
            _vipName.textField.defaultTextFormat = _nickNameText.getTextFormat();
            _vipName.buttonMode = true;
            _vipName.textSize = 14;
            _vipName.x = _nickNameText.x;
            _vipName.y = _nickNameText.y;
            _vipName.text = _loc1_;
            addChild(_vipName);
            PositionUtils.adaptNameStyle(_playerInfo,_nickNameText,_vipName);
         }
      }
      
      private function updateText(param1:BattleFieldListItemInfo) : String
      {
         if(param1.DareFlag)
         {
            msgID = !!param1.SuccessFlag?"1":"2";
            if(param1.SuccessFlag && param1.Level == 0)
            {
               msgID = "5";
            }
         }
         else
         {
            msgID = !!param1.SuccessFlag?"3":"4";
            if(!param1.SuccessFlag && param1.Level == 0)
            {
               msgID = "6";
            }
         }
         return LanguageMgr.GetTranslation("ringStation.view.battleFieldsView.itemInfo" + msgID,"                   ",param1.Level);
      }
      
      private function setUerNameLength(param1:String) : String
      {
         if(param1.length > 7)
         {
            param1 = param1.substring(0,5) + "..";
         }
         return param1;
      }
      
      private function __nickNameLinkHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         if(_playerInfo)
         {
            PlayerInfoViewControl.view(_playerInfo);
         }
      }
      
      public function dispose() : void
      {
         if(_fightIconBg)
         {
            ObjectUtils.disposeObject(_fightIconBg);
            _fightIconBg = null;
         }
         if(_fightIcon)
         {
            ObjectUtils.disposeObject(_fightIcon);
            _fightIcon = null;
         }
         if(_infoText)
         {
            ObjectUtils.disposeObject(_infoText);
            _infoText = null;
         }
         if(_nickNameText)
         {
            _nickNameText.removeEventListener("link",__nickNameLinkHandler);
            ObjectUtils.disposeObject(_nickNameText);
         }
         if(_vipName)
         {
            _vipName.removeEventListener("click",__nickNameLinkHandler);
            ObjectUtils.disposeObject(_vipName);
            _vipName = null;
         }
      }
   }
}
