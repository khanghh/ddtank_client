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
      
      public function PlayerFighterPower()
      {
         super();
         _selfInfo = PlayerManager.Instance.Self;
         initView();
      }
      
      private function initView() : void
      {
         _sp = new Component();
         _sp.graphics.beginFill(0,0);
         _sp.graphics.drawRect(0,0,242,15);
         _sp.graphics.endFill();
         _sp.width = _sp.displayWidth;
         _sp.height = _sp.displayHeight;
         _sp.tipStyle = "ddt.view.tips.OneLineTip";
         _sp.tipDirctions = "7,3,6";
         _sp.tipData = LanguageMgr.GetTranslation("hall.playerInfo.powerTipText",_selfInfo.FightPower);
         addChild(_sp);
         _container = new Sprite();
         addChild(_container);
         _fightPowerImg = ComponentFactory.Instance.creat("asset.hall.fightPowerImg");
         _container.addChild(_fightPowerImg);
         _powerNum = ImgNumConverter.instance.convertToImg(_selfInfo.FightPower,"asset.hall.playerInfo.num",8);
         PositionUtils.setPos(_powerNum,"hall.playerInfo.powNumPos");
         _container.addChild(_powerNum);
         _container.x = (this.width - _container.width) / 2;
      }
      
      public function update() : void
      {
         setPowerNum(_selfInfo.FightPower);
      }
      
      public function setPowerNum(value:int) : void
      {
         if(_powerNum)
         {
            ObjectUtils.disposeObject(_powerNum);
            _powerNum = null;
            _powerNum = ImgNumConverter.instance.convertToImg(value,"asset.hall.playerInfo.num",8);
            PositionUtils.setPos(_powerNum,"hall.playerInfo.powNumPos");
            _container.addChild(_powerNum);
         }
         if(_container)
         {
            _container.x = (this.width - _container.width) / 2;
         }
         _sp.tipData = LanguageMgr.GetTranslation("hall.playerInfo.powerTipText",_selfInfo.FightPower);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function get sp() : Component
      {
         return _sp;
      }
   }
}
