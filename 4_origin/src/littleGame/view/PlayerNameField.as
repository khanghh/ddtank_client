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
      
      public function PlayerNameField(param1:PlayerInfo)
      {
         _player = param1;
         super();
         configUI();
         cacheAsBitmap = true;
      }
      
      private function configUI() : void
      {
         if(_player.IsVIP)
         {
         }
         _nameField = ComponentFactory.Instance.creatComponentByStylename("littleGame.LivingNameField");
         addChild(_nameField);
         _nameField.text = _player.NickName;
         drawBackground();
      }
      
      private function drawBackground() : void
      {
         var _loc1_:Graphics = graphics;
         _loc1_.clear();
         _loc1_.beginFill(0,0.6);
         _loc1_.drawRoundRect(_nameField.width - _nameField.textWidth - _nameField.x >> 1,0,_nameField.textWidth + _nameField.x * 2,_nameField.textHeight + _nameField.y * 2,4);
         if(_player.IsVIP)
         {
         }
         _loc1_.endFill();
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         _player = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_vipNameField);
         _vipNameField = null;
         ObjectUtils.disposeObject(_nameField);
         _nameField = null;
      }
   }
}
