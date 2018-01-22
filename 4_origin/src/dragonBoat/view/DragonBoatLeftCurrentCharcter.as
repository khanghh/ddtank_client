package dragonBoat.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import ddt.view.common.LevelIcon;
   import dragonBoat.DragonBoatManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import vip.VipController;
   
   public class DragonBoatLeftCurrentCharcter extends Sprite implements Disposeable
   {
       
      
      private var _playerBg:Bitmap;
      
      private var _headerBg:Bitmap;
      
      private var _playerHeaderShine:MovieClip;
      
      private var _playerHeaderNo1:Bitmap;
      
      private var _palyerSprite:Sprite;
      
      private var _player:ICharacter;
      
      private var _info:PlayerInfo;
      
      private var _name:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _levelIcon:LevelIcon;
      
      private var _playerBottomText:FilterFrameText;
      
      public function DragonBoatLeftCurrentCharcter()
      {
         super();
         if(DragonBoatManager.instance.activeInfo.ActiveID == 1)
         {
            _playerBg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.playerBg");
         }
         else
         {
            _playerBg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.playerBg2");
         }
         addChild(_playerBg);
         _palyerSprite = new Sprite();
         addChild(_palyerSprite);
         _playerHeaderShine = ComponentFactory.Instance.creat("asset.dragonBoat.mainFrame.playerHeaderShine");
         PositionUtils.setPos(_playerHeaderShine,"drgonBoat.playerHeaderShinePos");
         addChild(_playerHeaderShine);
         _headerBg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.playerHeaderBg");
         addChild(_headerBg);
         _playerHeaderNo1 = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.playerHeaderNo1");
         addChild(_playerHeaderNo1);
         _name = ComponentFactory.Instance.creat("asset.dragonboatLeftPlayer.Name");
         addChild(_name);
         _levelIcon = new LevelIcon();
         _levelIcon.setSize(1);
         PositionUtils.setPos(_levelIcon,"asset.dragonboatLeftPlayerLevelIconPos");
         addChild(_levelIcon);
         _playerBottomText = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.playerBottomTxt");
         addChild(_playerBottomText);
      }
      
      public function updateInfo(param1:PlayerInfo) : void
      {
         if(param1)
         {
            _info = param1;
            refreshCharater();
            ObjectUtils.disposeObject(_vipName);
            if(_info.IsVIP)
            {
               _vipName = VipController.instance.getVipNameTxt(120,_info.typeVIP);
               _vipName.text = _info.NickName;
               _vipName.x = _name.x + (_name.width - _vipName.textWidth) / 2;
               _vipName.y = _name.y;
               addChild(_vipName);
            }
            _name.text = _info.NickName;
            PositionUtils.adaptNameStyle(_info,_name,_vipName);
            _levelIcon.setInfo(_info.Grade,_info.ddtKingGrade,_info.Repute,_info.WinCount,_info.TotalCount,_info.FightPower,_info.Offer,true,false);
            _playerBottomText.text = LanguageMgr.GetTranslation("ddt.dragonBoat.playerBottomTxt",_info.NickName);
         }
      }
      
      private function refreshCharater() : void
      {
         if(_player)
         {
            _player.dispose();
            _player = null;
         }
         if(_info)
         {
            _player = CharactoryFactory.createCharacter(_info,"room");
            _player.show(false,-1);
            _player.showGun = false;
            _player.setShowLight(true);
            PositionUtils.setPos(_player,"drgonBoat.playerPos");
            _palyerSprite.addChild(_player as DisplayObject);
         }
      }
      
      public function dispose() : void
      {
         if(_player)
         {
            _player.dispose();
         }
         _player = null;
         if(_playerBg)
         {
            ObjectUtils.disposeObject(_playerBg);
            _playerBg = null;
         }
         if(_playerHeaderShine)
         {
            ObjectUtils.disposeObject(_playerHeaderShine);
            _playerHeaderShine = null;
         }
         if(_palyerSprite)
         {
            ObjectUtils.disposeObject(_palyerSprite);
            _palyerSprite = null;
         }
         if(_headerBg)
         {
            ObjectUtils.disposeObject(_headerBg);
            _headerBg = null;
         }
         if(_playerHeaderNo1)
         {
            ObjectUtils.disposeObject(_playerHeaderNo1);
            _playerHeaderNo1 = null;
         }
         if(_vipName)
         {
            _vipName.dispose();
         }
         _vipName = null;
         if(_name)
         {
            _name.dispose();
            _name = null;
         }
         if(_levelIcon)
         {
            _levelIcon.dispose();
            _levelIcon = null;
         }
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
