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
      
      public function DanderBar(param1:LocalPlayer, param2:DisplayObjectContainer)
      {
         super();
         _self = param1;
         _container = param2;
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
      
      private function __attackingChanged(param1:LivingEvent) : void
      {
         buttonMode = _self.spellKillEnabled && _self.isAttacking;
      }
      
      private function __keyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == KeyStroke.VK_B.getCode())
         {
            useSkill();
         }
      }
      
      private function useSkill() : void
      {
         var _loc1_:* = null;
         if(_specialEnabled && _localVisible)
         {
            _loc1_ = _self.useSpellKill();
            if(_loc1_ == "-1")
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
            else if(_loc1_ != "0")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop." + _loc1_));
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
      
      private function __mouseOut(param1:MouseEvent) : void
      {
         if(_danderStripTip.parent)
         {
            _danderStripTip.parent.removeChild(_danderStripTip);
         }
      }
      
      private function __mouseOver(param1:MouseEvent) : void
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
      
      private function __spellKillChanged(param1:LivingEvent) : void
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
      
      private function __click(param1:MouseEvent) : void
      {
         useSkill();
      }
      
      private function __danderChanged(param1:LivingEvent) : void
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
      
      private function drawProgress(param1:Number) : void
      {
         var _loc7_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:int = 90 - Math.abs(-180 - 90) * param1;
         var _loc2_:Graphics = _maskShape.graphics;
         _loc2_.clear();
         var _loc3_:int = 52;
         _loc2_.beginFill(0,1);
         _loc2_.moveTo(0,0);
         _loc2_.lineTo(0,_loc3_);
         var _loc5_:int = 90;
         while(_loc5_ >= _loc6_)
         {
            _loc7_ = _loc3_ * Math.cos(_loc5_ / 180 * 3.14159265358979);
            _loc4_ = _loc3_ * Math.sin(_loc5_ / 180 * 3.14159265358979);
            _loc2_.lineTo(_loc7_,_loc4_);
            _loc5_--;
         }
         _loc2_.lineTo(0,0);
      }
      
      private function configUI() : void
      {
         var _loc1_:* = null;
         var _loc7_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.dander.bg");
         addChild(_bg);
         _back = ComponentFactory.Instance.creat("asset.game.dander.back");
         var _loc8_:* = -1;
         _back.y = _loc8_;
         _back.x = _loc8_;
         addChild(_back);
         var _loc6_:int = 52;
         _tipHitArea = new Sprite();
         _loc1_ = _tipHitArea.graphics;
         _loc1_.clear();
         _loc1_.beginFill(0,0);
         _loc1_.moveTo(0,0);
         _loc1_.lineTo(0,_loc6_);
         _loc7_ = 90;
         while(_loc7_ >= -180)
         {
            _loc2_ = _loc6_ * Math.cos(_loc7_ / 180 * 3.14159265358979);
            _loc3_ = _loc6_ * Math.sin(_loc7_ / 180 * 3.14159265358979);
            _loc1_.lineTo(_loc2_,_loc3_);
            _loc7_--;
         }
         _loc1_.lineTo(0,0);
         _tipHitArea.x = _loc6_;
         _tipHitArea.y = _loc6_;
         addChild(_tipHitArea);
         _maskShape = new Shape();
         _loc1_ = _maskShape.graphics;
         _loc1_.clear();
         _loc1_.beginFill(0,1);
         _loc1_.moveTo(0,0);
         _loc1_.lineTo(0,_loc6_);
         _loc7_ = 90;
         while(_loc7_ >= 90)
         {
            _loc2_ = _loc6_ * Math.cos(_loc7_ / 180 * 3.14159265358979);
            _loc3_ = _loc6_ * Math.sin(_loc7_ / 180 * 3.14159265358979);
            _loc1_.lineTo(_loc2_,_loc3_);
            _loc7_--;
         }
         _loc1_.lineTo(0,0);
         _maskShape.x = _loc6_;
         _maskShape.y = _loc6_;
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
         var _loc5_:ItemTemplateInfo = new ItemTemplateInfo();
         _loc5_.Name = LanguageMgr.GetTranslation("tank.game.ToolStripView.itemTemplateInfo.Name");
         _loc5_.Description = LanguageMgr.GetTranslation("tank.game.ToolStripView.itemTemplateInfo.Description");
         var _loc4_:ToolPropInfo = new ToolPropInfo();
         _loc4_.info = _loc5_;
         _loc4_.showTurn = false;
         _loc4_.showThew = false;
         _loc4_.showCount = false;
         _btn.tipData = _loc4_;
         addDanderStripTip();
      }
      
      public function set localDander(param1:int) : void
      {
         _localDander = param1;
         drawProgress(_localDander / 200);
      }
      
      public function get localDander() : int
      {
         return _localDander;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(_localVisible != param1)
         {
            _localVisible = param1;
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
      
      public function set specialEnabled(param1:Boolean) : void
      {
         if(_specialEnabled != param1)
         {
            _specialEnabled = param1;
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
      
      public function set tipData(param1:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return null;
      }
      
      public function set tipDirctions(param1:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 0;
      }
      
      public function set tipGapH(param1:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 0;
      }
      
      public function set tipGapV(param1:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         return null;
      }
      
      public function set tipStyle(param1:String) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return null;
      }
   }
}
