package littleGame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.view.common.VipLevelIcon;
   import flash.display.Graphics;
   import flash.display.Sprite;
   
   public final class PlayerNameField extends Sprite implements Disposeable
   {
       
      
      private var _player:PlayerInfo;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _vipNameField:GradientText;
      
      private var _nameField:FilterFrameText;
      
      public function PlayerNameField(param1:PlayerInfo){super();}
      
      private function configUI() : void{}
      
      private function drawBackground() : void{}
      
      public function dispose() : void{}
   }
}
