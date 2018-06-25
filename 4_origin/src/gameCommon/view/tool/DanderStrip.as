package gameCommon.view.tool
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.LivingEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.view.tips.ChangeNumToolTip;
   import ddt.view.tips.ChangeNumToolTipInfo;
   import ddt.view.tips.ToolPropInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   
   public class DanderStrip extends Sprite implements Disposeable
   {
       
      
      private var _specialEnabled:Boolean = true;
      
      private var _movie:MovieClip;
      
      private var _danderStrip:Bitmap;
      
      private var _mask:Shape;
      
      private var _skillBtn:Sprite;
      
      private var _info:LocalPlayer;
      
      private var _danderStripTip:ChangeNumToolTip;
      
      private var _danderStripTipInfo:ChangeNumToolTipInfo;
      
      private var _danderStripCopy:Sprite;
      
      private var _btn:SimpleBitmapButton;
      
      private var _btn2:SimpleBitmapButton;
      
      private var _danderField:FilterFrameText;
      
      private var _isDisable:Boolean;
      
      private var _enable:Boolean = true;
      
      public function DanderStrip()
      {
         super();
         mouseEnabled = false;
         _info = GameControl.Instance.Current.selfGamePlayer;
         _danderStrip = ComponentFactory.Instance.creatBitmap("asset.game.danderStripAsset");
         addChild(_danderStrip);
         _mask = new Shape();
         _mask.graphics.beginFill(16711680,1);
         _mask.graphics.drawRect(0,0,-96,41);
         _mask.graphics.endFill();
         _mask.x = 124;
         _mask.y = 4;
         0;
         addChild(_mask);
         _mask.width = 0;
         _danderStrip.mask = _mask;
         _danderStripCopy = new Sprite();
         var _copy:Bitmap = ComponentFactory.Instance.creatBitmap("asset.game.danderStripAsset");
         addChild(_danderStripCopy);
         _danderStripCopy.addChild(_copy);
         _danderStripCopy.alpha = 0;
         addDanderStripTip();
         _movie = ClassUtils.CreatInstance("asset.game.danderCartoonAsset") as MovieClip;
         addChild(_movie);
         _movie.gotoAndStop(1);
         var _loc4_:Boolean = false;
         _movie.mouseEnabled = _loc4_;
         _movie.mouseChildren = _loc4_;
         _btn = new SimpleBitmapButton();
         addChild(_btn);
         _btn.mouseChildren = true;
         _btn.buttonMode = false;
         _skillBtn = new Sprite();
         _skillBtn.graphics.beginFill(16777215,1);
         _skillBtn.graphics.drawCircle(0,0,22);
         _skillBtn.graphics.endFill();
         _skillBtn.x = 22;
         _skillBtn.y = 17;
         _skillBtn.alpha = 0;
         _btn.addChild(_skillBtn);
         _btn2 = new SimpleBitmapButton();
         addChild(_btn2);
         _btn2.mouseChildren = true;
         _btn2.buttonMode = false;
         _btn.tipStyle = "core.ToolPropTips";
         _btn.tipDirctions = "0";
         _btn.tipGapV = 5;
         var temp:ItemTemplateInfo = new ItemTemplateInfo();
         temp.Name = LanguageMgr.GetTranslation("tank.game.ToolStripView.itemTemplateInfo.Name");
         temp.Description = LanguageMgr.GetTranslation("tank.game.ToolStripView.itemTemplateInfo.Description");
         var tipInfo:ToolPropInfo = new ToolPropInfo();
         tipInfo.info = temp;
         tipInfo.showTurn = false;
         tipInfo.showThew = false;
         tipInfo.showCount = false;
         _btn.tipData = tipInfo;
         _btn2.tipStyle = "core.ToolPropTips";
         _btn2.tipDirctions = "0";
         _btn2.tipGapV = 5;
         temp = new ItemTemplateInfo();
         temp.Name = LanguageMgr.GetTranslation("tank.game.ToolStripView.itemTemplateInfo.Name2");
         temp.Description = LanguageMgr.GetTranslation("tank.game.ToolStripView.itemTemplateInfo.Description2");
         tipInfo = new ToolPropInfo();
         tipInfo.info = temp;
         tipInfo.showTurn = false;
         tipInfo.showThew = false;
         tipInfo.showCount = false;
         _btn2.tipData = tipInfo;
         setDander();
         initEvents();
      }
      
      private function addDanderStripTip() : void
      {
         _danderStripTip = new ChangeNumToolTip();
         _danderStripTipInfo = new ChangeNumToolTipInfo();
         _danderStripTipInfo.currentTxt = ComponentFactory.Instance.creatComponentByStylename("game.DanderStrip.currentTxt");
         _danderStripTipInfo.title = LanguageMgr.GetTranslation("tank.game.danderStripTip.pow") + ":";
         _danderStripTipInfo.current = 0;
         _danderStripTipInfo.total = 200 / 2;
         _danderStripTipInfo.content = LanguageMgr.GetTranslation("tank.game.DanderStrip.tip");
         _danderStripTip.tipData = _danderStripTipInfo;
         _danderStripTip.mouseChildren = false;
         _danderStripTip.mouseEnabled = false;
         _danderStripTip.x = 640;
         _danderStripTip.y = 430;
         addChild(_danderStripTip);
         _danderStripTip.visible = false;
      }
      
      public function setInfo(info:LocalPlayer) : void
      {
         _info = info;
      }
      
      private function initEvents() : void
      {
         _danderStripCopy.addEventListener("mouseOver",__showDanderStripTip);
         _danderStripCopy.addEventListener("mouseOut",__hideDanderStripTip);
         KeyboardManager.getInstance().addEventListener("keyDown",__keydown);
         _info.addEventListener("danderChanged",__update);
         _info.addEventListener("attackingChanged",__updateBtn);
      }
      
      private function removeEvents() : void
      {
         _danderStripCopy.removeEventListener("mouseOver",__showDanderStripTip);
         _danderStripCopy.removeEventListener("mouseOut",__hideDanderStripTip);
         KeyboardManager.getInstance().removeEventListener("keyDown",__keydown);
         _info.removeEventListener("danderChanged",__update);
         _info.removeEventListener("attackingChanged",__updateBtn);
         _skillBtn.removeEventListener("click",__useSkill);
      }
      
      private function __showDanderStripTip(evt:MouseEvent) : void
      {
         _danderStripTip.visible = true;
         LayerManager.Instance.addToLayer(_danderStripTip,0,false);
      }
      
      private function __hideDanderStripTip(evt:MouseEvent) : void
      {
         _danderStripTip.visible = false;
      }
      
      private function __update(evt:LivingEvent) : void
      {
         setDander();
      }
      
      private function setDander() : void
      {
         _danderStripTipInfo.current = _info.dander / 2;
         _danderStripTip.tipData = _danderStripTipInfo;
         var s:Number = _info.dander / 200;
         TweenLite.killTweensOf(_mask,true);
         if(s > 0)
         {
            TweenLite.to(_mask,1,{"scaleX":s});
         }
         else
         {
            _mask.scaleX = 0;
         }
         __updateBtn(null);
      }
      
      private function __updateBtn(evt:LivingEvent) : void
      {
         _movie.gotoAndStop(_info.dander >= 200?2:1);
         if(_info.isAttacking && _info.dander >= 200 && !_isDisable)
         {
            _skillBtn.buttonMode = true;
            _skillBtn.addEventListener("click",__useSkill);
            KeyboardManager.getInstance().addEventListener("keyDown",__keydown);
         }
         else
         {
            _skillBtn.buttonMode = false;
            _skillBtn.removeEventListener("click",__useSkill);
            KeyboardManager.getInstance().removeEventListener("keyDown",__keydown);
         }
         if(_isDisable)
         {
            _movie.gotoAndStop(1);
         }
         _isDisable = false;
      }
      
      private function __useSkill(evt:MouseEvent) : void
      {
         if(_specialEnabled && GameControl.Instance.Current.selfGamePlayer.dander >= 200 && GameControl.Instance.Current.selfGamePlayer.isAttacking)
         {
            GameControl.Instance.Current.selfGamePlayer.skill = 0;
            GameControl.Instance.Current.selfGamePlayer.isSpecialSkill = true;
            GameInSocketOut.sendGameCMDStunt();
            GameControl.Instance.Current.selfGamePlayer.dander = 0;
            SoundManager.instance.play("008");
         }
      }
      
      private function __useSkill2(event:MouseEvent) : void
      {
         GameControl.Instance.Current.selfGamePlayer.isSpecialSkill = true;
         GameControl.Instance.Current.selfGamePlayer.skill = 1;
         GameInSocketOut.sendGameCMDStunt(1);
         GameControl.Instance.Current.selfGamePlayer.dander = 0;
         SoundManager.instance.play("008");
      }
      
      public function disable() : void
      {
         if(GameControl.Instance.Current.selfGamePlayer.isAttacking)
         {
            _isDisable = true;
            __updateBtn(null);
         }
      }
      
      private function __keydown(event:KeyboardEvent) : void
      {
         if(event.keyCode == KeyStroke.VK_B.getCode())
         {
            __useSkill(null);
         }
         else if(event.keyCode == KeyStroke.VK_N.getCode())
         {
            __useSkill2(null);
         }
      }
      
      public function set specialEnabled(value:Boolean) : void
      {
         _specialEnabled = value;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(value:Boolean) : void
      {
         _enable = value;
      }
      
      public function dispose() : void
      {
         removeEvents();
         _movie.stop();
         removeChild(_movie);
         removeChild(_danderStrip);
         _danderStrip.bitmapData.dispose();
         _danderStrip = null;
         removeChild(_mask);
         _mask = null;
         _btn.removeChild(_skillBtn);
         _skillBtn = null;
         _btn.dispose();
         _btn = null;
         _info = null;
         _danderStripTip.dispose();
         _danderStrip = null;
         _danderStripTipInfo = null;
         ObjectUtils.disposeAllChildren(_danderStripCopy);
         removeChild(_danderStripCopy);
         _danderStripCopy = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
