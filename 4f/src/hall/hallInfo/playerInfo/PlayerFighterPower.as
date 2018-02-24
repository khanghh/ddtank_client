package hall.hallInfo.playerInfo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.ImgNumConverter;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class PlayerFighterPower extends Sprite
   {
       
      
      private var _sp:Component;
      
      private var _selfInfo:SelfInfo;
      
      private var _container:Sprite;
      
      private var _fightPowerImg:Bitmap;
      
      private var _powerNum:Sprite;
      
      public function PlayerFighterPower(){super();}
      
      private function initView() : void{}
      
      public function update() : void{}
      
      public function setPowerNum(param1:int) : void{}
      
      public function dispose() : void{}
      
      public function get sp() : Component{return null;}
   }
}
