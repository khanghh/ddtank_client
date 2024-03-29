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
      
      public function DragonBoatLeftCurrentCharcter(){super();}
      
      public function updateInfo(param1:PlayerInfo) : void{}
      
      private function refreshCharater() : void{}
      
      public function dispose() : void{}
   }
}
