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
      
      public function PvePowerBuffPerson(param1:int){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvemt() : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      public function updatePlayer(param1:PlayerInfo) : void{}
      
      public function get playerInfo() : PlayerInfo{return null;}
      
      public function get index() : int{return 0;}
      
      public function setLightMcVisible(param1:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
