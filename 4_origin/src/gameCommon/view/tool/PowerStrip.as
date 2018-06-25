package gameCommon.view.tool
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.LivingEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.tips.ChangeNumToolTip;
   import ddt.view.tips.ChangeNumToolTipInfo;
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import trainer.view.NewHandContainer;
   
   public class PowerStrip extends Sprite implements Disposeable
   {
       
      
      private var _self:LocalPlayer;
      
      private var _timer:Timer;
      
      private var _bg:Sprite;
      
      private var _glint:MovieClip;
      
      private var _smallLight:MovieClip;
      
      private var _visibleRect:Rectangle;
      
      private var _maxWidth:int;
      
      private var _mask:Shape;
      
      private var _powerStripTip:ChangeNumToolTip;
      
      private var _powerStripTipInfo:ChangeNumToolTipInfo;
      
      private var _tipSprite:Sprite;
      
      private var _powerField:FilterFrameText;
      
      private var canCount:Boolean = false;
      
      private var flashLight:MovieClip;
      
      public function PowerStrip()
      {
         super();
         _self = GameControl.Instance.Current.selfGamePlayer;
         _timer = new Timer(400,1);
         _timer.stop();
         _bg = new Sprite();
         _bg.addChild(ComponentFactory.Instance.creatBitmap("asset.game.energy.back"));
         addChild(_bg);
         _glint = ClassUtils.CreatInstance("asset.game.powerStripLightAsset") as MovieClip;
         _glint.y = 4;
         _smallLight = ClassUtils.CreatInstance("asset.game.powerStripLightAssetII") as MovieClip;
         _smallLight.y = 2;
         _smallLight.x = 2;
         _mask = new Shape();
         var g:Graphics = _mask.graphics;
         g.beginFill(0);
         g.drawRect(0,0,_bg.width,_bg.height);
         g.endFill();
         _mask.x = _bg.x;
         _mask.y = _bg.y;
         addChild(_mask);
         _bg.mask = _mask;
         _tipSprite = new Sprite();
         var tipBitm:Bitmap = ComponentFactory.Instance.creatBitmap("asset.game.powerStripAsset");
         _tipSprite.addChild(tipBitm);
         tipBitm.alpha = 0;
         addChild(_tipSprite);
         addDanderStripTip();
         _powerField = ComponentFactory.Instance.creatComponentByStylename("game.PowerStrip.PowerTxt");
         addChild(_powerField);
         _powerField.text = String(_self.energy);
         initEvents();
      }
      
      private function addDanderStripTip() : void
      {
         _powerStripTip = new ChangeNumToolTip();
         _powerStripTipInfo = new ChangeNumToolTipInfo();
         _powerStripTipInfo.currentTxt = ComponentFactory.Instance.creatComponentByStylename("game.PowerStrip.currentTxt");
         _powerStripTipInfo.title = LanguageMgr.GetTranslation("tank.game.PowerStrip.energy");
         _powerStripTipInfo.current = 0;
         _powerStripTipInfo.total = _self.maxEnergy;
         _powerStripTipInfo.content = LanguageMgr.GetTranslation("tank.game.PowerStrip.tip");
         _powerStripTip.tipData = _powerStripTipInfo;
         _powerStripTip.mouseChildren = false;
         _powerStripTip.mouseEnabled = false;
         _powerStripTip.x = 710;
         _powerStripTip.y = 440;
      }
      
      private function initEvents() : void
      {
         _tipSprite.addEventListener("mouseOver",__showTip);
         _tipSprite.addEventListener("mouseOut",__hideTip);
         _self.addEventListener("energyChanged",__update);
         _timer.addEventListener("timerComplete",_timerComplete);
      }
      
      private function __showTip(evt:MouseEvent) : void
      {
         LayerManager.Instance.addToLayer(_powerStripTip,0,false);
      }
      
      private function __hideTip(evt:MouseEvent) : void
      {
         if(_powerStripTip.parent)
         {
            _powerStripTip.parent.removeChild(_powerStripTip);
         }
      }
      
      private function __update(evt:LivingEvent) : void
      {
         if(_self.maxEnergy == _self.energy && _self.maxEnergy != 0 && _self.selfInfo.Grade <= 15)
         {
            canCount = true;
            NewHandContainer.Instance.clearArrowByID(5);
            if(flashLight)
            {
               ObjectUtils.disposeObject(flashLight);
               flashLight = null;
            }
         }
         var energy:Number = int(_self.energy);
         _powerStripTipInfo.current = energy;
         _powerStripTipInfo.total = _self.maxEnergy;
         _powerStripTip.tipData = _powerStripTipInfo;
         _powerField.text = String(energy);
         _mask.width = _self.energy / _self.maxEnergy * _bg.width;
         _mask.x = _bg.x + _bg.width - _mask.width;
         if(_self.energy == _self.maxEnergy)
         {
            if(_smallLight.parent)
            {
               _smallLight.parent.removeChild(_smallLight);
            }
            _bg.addChild(_glint);
            _timer.reset();
            _timer.start();
         }
         else
         {
            _bg.addChild(_smallLight);
         }
         if(canCount && _self.energy <= 85 && !PlayerManager.Instance.Self.IsWeakGuildFinish(45))
         {
            canCount = false;
            NewHandContainer.Instance.showArrow(5,-30,"trainer.powerStripArrowPos","asset.trainer.txtPowerStrip1","trainer.powerStripTipPos",null,6000);
            flashLight = ComponentFactory.Instance.creat("asset.game.powerStrip.flashLight");
            addChild(flashLight);
            SocketManager.Instance.out.syncWeakStep(45);
            if(flashLight)
            {
               ObjectUtils.disposeObject(flashLight);
               flashLight = null;
            }
         }
      }
      
      private function removeEvents() : void
      {
         _tipSprite.removeEventListener("mouseOver",__showTip);
         _tipSprite.removeEventListener("mouseOut",__hideTip);
         _self.removeEventListener("energyChanged",__update);
         _timer.removeEventListener("timerComplete",_timerComplete);
      }
      
      private function _timerComplete(evt:TimerEvent) : void
      {
         if(_glint.parent)
         {
            _glint.parent.removeChild(_glint);
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_timer)
         {
            _timer.stop();
            _timer = null;
         }
         if(flashLight)
         {
            ObjectUtils.disposeObject(flashLight);
            flashLight = null;
         }
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _glint = null;
         _smallLight = null;
         _powerStripTip.dispose();
         _powerStripTip = null;
         _powerStripTipInfo = null;
         _tipSprite = null;
         _powerField = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
