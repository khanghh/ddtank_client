package gameCommon.view.tool
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.LivingEvent;
   import ddt.manager.LanguageMgr;
   import ddt.view.tips.ChangeNumToolTipInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import gameCommon.GameControl;
   
   public class BloodStrip extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      private var _HPStripBg:Bitmap;
      
      private var _HPStrip:Bitmap;
      
      private var _hpShadow:Bitmap;
      
      private var _HPTxt:FilterFrameText;
      
      private var _mask:Shape;
      
      private var _hurtedMask:MovieClip;
      
      private var _tipStyle:String;
      
      private var _tipDirctions:String;
      
      private var _tipData:Object;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _maskH:Number;
      
      private var _info:ChangeNumToolTipInfo;
      
      public function BloodStrip()
      {
         super();
         _HPStrip = ComponentFactory.Instance.creatBitmap("asset.game.blood.SelfBack");
         addChild(_HPStrip);
         _HPTxt = ComponentFactory.Instance.creatComponentByStylename("asset.toolHPStripTxt");
         addChild(_HPTxt);
         _mask = new Shape();
         _mask.graphics.beginFill(0,1);
         _mask.graphics.drawRect(0,0,10,_HPStrip.height);
         _mask.graphics.endFill();
         addChild(_mask);
         _HPStrip.mask = _mask;
         _maskH = _mask.height;
         _hurtedMask = ComponentFactory.Instance.creatCustomObject("asset.game.OnHurtedFrame");
         LayerManager.Instance.addToLayer(_hurtedMask,2);
         _hurtedMask.gotoAndStop(1);
         initTip();
         __update(null);
         GameControl.Instance.Current.selfGamePlayer.addEventListener("bloodChanged",__update);
         GameControl.Instance.Current.selfGamePlayer.addEventListener("maxHpChanged",__update);
         GameControl.Instance.Current.selfGamePlayer.addEventListener("die",__update);
      }
      
      private function initTip() : void
      {
         tipStyle = "ddt.view.tips.ChangeNumToolTip";
         tipDirctions = "4";
         tipGapV = 5;
         tipGapH = 5;
         _info = new ChangeNumToolTipInfo();
         _info.currentTxt = ComponentFactory.Instance.creatComponentByStylename("game.BloodString.currentTxt");
         _info.title = LanguageMgr.GetTranslation("tank.game.BloodStrip.HP") + ":";
         _info.current = GameControl.Instance.Current.selfGamePlayer.maxBlood;
         _info.total = GameControl.Instance.Current.selfGamePlayer.maxBlood;
         _info.content = LanguageMgr.GetTranslation("tank.game.BloodStrip.tip");
         tipData = _info;
         ShowTipManager.Instance.addTip(this);
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         if(GameControl.Instance.Current != null)
         {
            GameControl.Instance.Current.selfGamePlayer.removeEventListener("bloodChanged",__update);
            GameControl.Instance.Current.selfGamePlayer.removeEventListener("maxHpChanged",__update);
            GameControl.Instance.Current.selfGamePlayer.removeEventListener("die",__update);
         }
         ObjectUtils.disposeObject(_HPStripBg);
         _HPStripBg = null;
         ObjectUtils.disposeObject(_HPStrip);
         _HPStrip = null;
         ObjectUtils.disposeObject(_HPTxt);
         _HPTxt = null;
         ChangeNumToolTipInfo(_tipData).currentTxt.dispose();
         if(_hurtedMask.parent)
         {
            _hurtedMask.parent.removeChild(_hurtedMask);
         }
         _hurtedMask = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __update(param1:LivingEvent) : void
      {
         if(GameControl.Instance.Current.selfGamePlayer.isLiving)
         {
            update(GameControl.Instance.Current.selfGamePlayer.blood,GameControl.Instance.Current.selfGamePlayer.maxBlood);
            if(param1 && param1.paras[0] == 2)
            {
               _hurtedMask.gotoAndPlay(2);
            }
         }
         else
         {
            update(0,GameControl.Instance.Current.selfGamePlayer.maxBlood);
         }
      }
      
      private function update(param1:int, param2:int) : void
      {
         if(_info)
         {
            if(_info.current > param1)
            {
            }
            _info.current = param1 < 0?0:param1;
            _info.total = param2;
            tipData = _info;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > param2)
         {
            param1 = param2;
         }
         _mask.width = _HPStrip.width * (param1 / param2);
         _mask.x = _HPStrip.width - _mask.width;
         _HPTxt.text = String(param1);
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirctions = param1;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
