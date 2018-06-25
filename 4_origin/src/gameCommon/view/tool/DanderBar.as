package gameCommon.view.tool
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.LivingEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.view.tips.ChangeNumToolTip;
   import ddt.view.tips.ChangeNumToolTipInfo;
   import ddt.view.tips.ToolPropInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import trainer.view.NewHandContainer;
   
   public class DanderBar extends Sprite implements Disposeable, ITipedDisplay
   {
      
      private static const Min:int = 90;
      
      private static const Max:int = -180;
       
      
      private var _back:DisplayObject;
      
      private var _animateBack:Bitmap;
      
      private var _self:LocalPlayer;
      
      private var _maskShape:Shape;
      
      private var _rate:Number;
      
      private var _animate:MovieClip;
      
      private var _btn:SimpleBitmapButton;
      
      private var _skillBtn:Sprite;
      
      private var _tipHitArea:Sprite;
      
      private var _localDander:int;
      
      private var _danderStripTip:ChangeNumToolTip;
      
      private var _danderStripTipInfo:ChangeNumToolTipInfo;
      
      private var _bg:DisplayObject;
      
      private var _localVisible:Boolean = true;
      
      private var _container:DisplayObjectContainer;
      
      private var _specialEnabled:Boolean = true;
      
      public function DanderBar(self:LocalPlayer, container:DisplayObjectContainer)
      {
         super();
         _self = self;
         _container = container;
         buttonMode = true;
         configUI();
         addEvent();
         setDander();
      }
      
      private function addEvent() : void
      {
         _self.addEventListener("danderChanged",__danderChanged);
         _self.addEventListener("spellkillChanged",__spellKillChanged);
         _self.addEventListener("attackingChanged",__attackingChanged);
         if(!(GameControl.Instance.Current.missionInfo && GameControl.Instance.Current.missionInfo.isWorldCupI) && !_self.autoOnHook)
         {
            _tipHitArea.addEventListener("mouseOver",__mouseOver);
            _tipHitArea.addEventListener("mouseOut",__mouseOut);
            addEventListener("click",__click);
         }
         if(!(GameControl.Instance.Current && GameControl.Instance.Current.missionInfo && GameControl.Instance.Current.missionInfo.isWorldCupI))
         {
            KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
         }
      }
      
      private function __attackingChanged(evt:LivingEvent) : void
      {
         buttonMode = _self.spellKillEnabled && _self.isAttacking;
      }
      
      private function __keyDown(evt:KeyboardEvent) : void
      {
         if(evt.keyCode == KeyStroke.VK_B.getCode())
         {
            useSkill();
         }
      }
      
      private function useSkill() : void
      {
         var result:* = null;
         if(_specialEnabled && _localVisible)
         {
            result = _self.useSpellKill();
            if(result == "-1")
            {
               if(NewHandContainer.Instance.hasArrow(21))
               {
                  NewHandContainer.Instance.clearArrowByID(21);
               }
               if(NewHandContainer.Instance.hasArrow(18))
               {
                  NewHandContainer.Instance.clearArrowByID(18);
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("game.view.propContainer.ItemContainer.energy"));
               }
            }
            else if(result != "0")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop." + result));
            }
         }
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
         _danderStripTip.x = 740;
         _danderStripTip.y = 430;
      }
      
      private function __mouseOut(evt:MouseEvent) : void
      {
         if(_danderStripTip.parent)
         {
            _danderStripTip.parent.removeChild(_danderStripTip);
         }
      }
      
      private function __mouseOver(evt:MouseEvent) : void
      {
         LayerManager.Instance.addToLayer(_danderStripTip,0,false);
      }
      
      private function removeEvent() : void
      {
         _self.removeEventListener("danderChanged",__danderChanged);
         _self.removeEventListener("spellkillChanged",__spellKillChanged);
         _self.removeEventListener("attackingChanged",__attackingChanged);
         _tipHitArea.removeEventListener("mouseOver",__mouseOver);
         _tipHitArea.removeEventListener("mouseOut",__mouseOut);
         removeEventListener("click",__click);
         KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
      }
      
      private function __spellKillChanged(evt:LivingEvent) : void
      {
         if(_self.spellKillEnabled)
         {
            _animate.visible = true;
            _animate.gotoAndPlay(1);
         }
         else
         {
            _animate.visible = false;
            _animate.gotoAndStop(1);
         }
      }
      
      private function __click(event:MouseEvent) : void
      {
         useSkill();
      }
      
      private function __danderChanged(event:LivingEvent) : void
      {
         setDander();
      }
      
      private function setDander() : void
      {
         _danderStripTipInfo.current = _self.dander / 2;
         _danderStripTip.tipData = _danderStripTipInfo;
         TweenLite.killTweensOf(this);
         TweenLite.to(this,0.3,{"localDander":_self.dander});
         if(_self.dander >= 200)
         {
            if(_self.spellKillEnabled)
            {
               _animate.visible = true;
               _animate.gotoAndPlay(1);
               buttonMode = true;
            }
         }
         else
         {
            _animate.visible = false;
            _animate.gotoAndStop(1);
            buttonMode = false;
         }
      }
      
      private function drawProgress(rate:Number) : void
      {
         var x:Number = NaN;
         var y:Number = NaN;
         var end:int = 90 - Math.abs(-180 - 90) * rate;
         var pen:Graphics = _maskShape.graphics;
         pen.clear();
         var rudis:int = 52;
         pen.beginFill(0,1);
         pen.moveTo(0,0);
         pen.lineTo(0,rudis);
         var angle:int = 90;
         while(angle >= end)
         {
            x = rudis * Math.cos(angle / 180 * 3.14159265358979);
            y = rudis * Math.sin(angle / 180 * 3.14159265358979);
            pen.lineTo(x,y);
            angle--;
         }
         pen.lineTo(0,0);
      }
      
      private function configUI() : void
      {
         var pen:* = null;
         var angle:int = 0;
         var _x:Number = NaN;
         var _y:Number = NaN;
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.dander.bg");
         addChild(_bg);
         _back = ComponentFactory.Instance.creat("asset.game.dander.back");
         var _loc8_:* = -1;
         _back.y = _loc8_;
         _back.x = _loc8_;
         addChild(_back);
         var rudis:int = 52;
         _tipHitArea = new Sprite();
         pen = _tipHitArea.graphics;
         pen.clear();
         pen.beginFill(0,0);
         pen.moveTo(0,0);
         pen.lineTo(0,rudis);
         angle = 90;
         while(angle >= -180)
         {
            _x = rudis * Math.cos(angle / 180 * 3.14159265358979);
            _y = rudis * Math.sin(angle / 180 * 3.14159265358979);
            pen.lineTo(_x,_y);
            angle--;
         }
         pen.lineTo(0,0);
         _tipHitArea.x = rudis;
         _tipHitArea.y = rudis;
         addChild(_tipHitArea);
         _maskShape = new Shape();
         pen = _maskShape.graphics;
         pen.clear();
         pen.beginFill(0,1);
         pen.moveTo(0,0);
         pen.lineTo(0,rudis);
         angle = 90;
         while(angle >= 90)
         {
            _x = rudis * Math.cos(angle / 180 * 3.14159265358979);
            _y = rudis * Math.sin(angle / 180 * 3.14159265358979);
            pen.lineTo(_x,_y);
            angle--;
         }
         pen.lineTo(0,0);
         _maskShape.x = rudis;
         _maskShape.y = rudis;
         addChild(_maskShape);
         _back.mask = _maskShape;
         _animateBack = ComponentFactory.Instance.creatBitmap("asset.game.dander.animate.back");
         addChild(_animateBack);
         _animate = ComponentFactory.Instance.creat("asset.game.dande.animate");
         _loc8_ = false;
         _animate.mouseEnabled = _loc8_;
         _animate.mouseChildren = _loc8_;
         _animate.visible = false;
         _animate.gotoAndStop(1);
         _animate.x = 34;
         _animate.y = 33;
         _loc8_ = 0.8;
         _animate.scaleY = _loc8_;
         _animate.scaleX = _loc8_;
         addChild(_animate);
         _btn = new SimpleBitmapButton();
         addChild(_btn);
         _btn.x = 39;
         _btn.y = 40;
         _btn.mouseChildren = true;
         _btn.buttonMode = false;
         _skillBtn = new Sprite();
         _skillBtn.graphics.beginFill(16777215,0);
         _skillBtn.graphics.drawCircle(0,0,22);
         _skillBtn.graphics.endFill();
         _btn.addChild(_skillBtn);
         _btn.tipStyle = "core.ToolPropTips";
         _btn.tipDirctions = "4";
         _btn.tipGapV = 30;
         _btn.tipGapH = 30;
         var temp:ItemTemplateInfo = new ItemTemplateInfo();
         temp.Name = LanguageMgr.GetTranslation("tank.game.ToolStripView.itemTemplateInfo.Name");
         temp.Description = LanguageMgr.GetTranslation("tank.game.ToolStripView.itemTemplateInfo.Description");
         var tipInfo:ToolPropInfo = new ToolPropInfo();
         tipInfo.info = temp;
         tipInfo.showTurn = false;
         tipInfo.showThew = false;
         tipInfo.showCount = false;
         _btn.tipData = tipInfo;
         addDanderStripTip();
      }
      
      public function set localDander(val:int) : void
      {
         _localDander = val;
         drawProgress(_localDander / 200);
      }
      
      public function get localDander() : int
      {
         return _localDander;
      }
      
      public function setVisible(val:Boolean) : void
      {
         if(_localVisible != val)
         {
            _localVisible = val;
            if(_localVisible)
            {
               _container.addChild(this);
            }
            else if(parent)
            {
               parent.removeChild(this);
            }
         }
      }
      
      public function set specialEnabled(val:Boolean) : void
      {
         if(_specialEnabled != val)
         {
            _specialEnabled = val;
            if(!_specialEnabled)
            {
            }
            mouseEnabled = _specialEnabled;
         }
      }
      
      public function dispose() : void
      {
         TweenLite.killTweensOf(this);
         removeEvent();
         _self = null;
         _danderStripTipInfo = null;
         _back = null;
         _maskShape = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
            _back = null;
         }
         if(_tipHitArea)
         {
            ObjectUtils.disposeObject(_tipHitArea);
            _tipHitArea = null;
         }
         if(_animate)
         {
            _animate.gotoAndStop(1);
            ObjectUtils.disposeObject(_animate);
            _animate = null;
         }
         _btn = null;
         _skillBtn = null;
         if(_danderStripTip)
         {
            ObjectUtils.disposeObject(_danderStripTip);
            _danderStripTip = null;
         }
         if(_animateBack)
         {
            ObjectUtils.disposeObject(_animateBack);
            _animateBack = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function get tipData() : Object
      {
         return null;
      }
      
      public function set tipData(value:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return null;
      }
      
      public function set tipDirctions(value:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 0;
      }
      
      public function set tipGapH(value:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 0;
      }
      
      public function set tipGapV(value:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         return null;
      }
      
      public function set tipStyle(value:String) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return null;
      }
   }
}
