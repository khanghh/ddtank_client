package pvePowerBuff
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PvePowerBuffPerson extends Sprite
   {
       
      
      private var _bg:Bitmap;
      
      private var _player:ICharacter;
      
      private var _levelIcon:LevelIcon;
      
      private var _nickNameText:FilterFrameText;
      
      private var _lightMC:MovieClip;
      
      private var _index:int;
      
      private var _playerInfo:PlayerInfo;
      
      public function PvePowerBuffPerson(param1:int)
      {
         super();
         _index = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.pvepowerbuff.lianhua");
         addChild(_bg);
         _levelIcon = new LevelIcon();
         PositionUtils.setPos(_levelIcon,"pvePowerBuff.character.level.icom.pos");
         _nickNameText = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.character.nickNameText");
         _lightMC = ClassUtils.CreatInstance("asset.pvepowerbuff.selected.mc");
         PositionUtils.setPos(_lightMC,"pvePowerBuff.character.light.mc.pos");
         _lightMC.visible = false;
         addChild(_lightMC);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvemt() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:PvePowerBuffEvent = new PvePowerBuffEvent("select_player");
         _loc2_.info = this;
         PvePowerBuffControl.instance.dispatchEvent(_loc2_);
      }
      
      public function updatePlayer(param1:PlayerInfo) : void
      {
         _playerInfo = param1;
         _levelIcon.setInfo(param1.Grade,param1.ddtKingGrade,param1.Repute,param1.WinCount,param1.TotalCount,param1.FightPower,param1.Offer,true,false);
         _nickNameText.text = param1.NickName;
         _player = CharactoryFactory.createCharacter(param1,"room");
         _player.showGun = true;
         _player.show();
         _player.setShowLight(true);
         PositionUtils.setPos(_player,"pvePowerBuff.character.player.pos");
         addChild(_player as DisplayObject);
         addChild(_levelIcon);
         addChild(_nickNameText);
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return _playerInfo;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function setLightMcVisible(param1:Boolean) : void
      {
         _lightMC.visible = param1;
      }
      
      public function dispose() : void
      {
         removeEvemt();
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         if(_levelIcon)
         {
            _levelIcon.dispose();
            _levelIcon = null;
         }
         if(_nickNameText)
         {
            _nickNameText.dispose();
            _nickNameText = null;
         }
         if(_player)
         {
            _player.dispose();
            _player = null;
         }
      }
   }
}
