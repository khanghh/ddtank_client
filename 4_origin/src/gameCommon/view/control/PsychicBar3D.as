package gameCommon.view.control
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.LivingEvent;
   import ddt.utils.PositionUtils;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import gameStarling.objects.SimpleBox3D;
   
   public class PsychicBar3D extends Sprite implements Disposeable
   {
       
      
      private var _self:LocalPlayer;
      
      private var _back:DisplayObject;
      
      private var _localPsychic:int;
      
      private var _numField:PsychicShape;
      
      private var _movie:MovieClip;
      
      private var _ghostBoxCenter:Point;
      
      private var _ghostBitmapPool:Object;
      
      private var _mouseArea:MouseArea;
      
      private const endPos:Point = new Point(160,550);
      
      public function PsychicBar3D(param1:LocalPlayer)
      {
         _ghostBitmapPool = {};
         _self = param1;
         super();
         configUI();
         mouseEnabled = false;
      }
      
      private function configUI() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.game.PsychicBar.back");
         addChild(_back);
         _ghostBoxCenter = new Point((_back.width >> 1) - 20,(_back.height >> 1) - 20);
         _movie = ClassUtils.CreatInstance("asset.game.PsychicBar.movie");
         var _loc1_:Boolean = false;
         _movie.mouseEnabled = _loc1_;
         _movie.mouseChildren = _loc1_;
         PositionUtils.setPos(_movie,"PsychicBar.MoviePos");
         addChild(_movie);
         _numField = new PsychicShape();
         _numField.setNum(_self.psychic);
         _numField.x = _back.width - _numField.width >> 1;
         _numField.y = _back.height - _numField.height >> 1;
         addChild(_numField);
         _mouseArea = new MouseArea(48);
         addChild(_mouseArea);
      }
      
      private function addEvent() : void
      {
         _self.addEventListener("psychicChanged",__psychicChanged);
         _self.addEventListener("boxPick",__pickBox);
      }
      
      private function boxTweenComplete(param1:DisplayObject) : void
      {
         ObjectUtils.disposeObject(param1);
      }
      
      private function __pickBox(param1:LivingEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:SimpleBox3D = param1.paras[0] as SimpleBox3D;
         if(_loc3_.isGhost)
         {
            _loc2_ = getGhostShape(_loc3_.subType);
            addChild(_loc2_);
            _loc4_ = new Point();
            _loc4_.setTo(GameControl.Instance.gameView.map.x + _loc3_.x,GameControl.Instance.gameView.map.y + _loc3_.y);
            trace(_loc4_);
            trace("box x:" + _loc3_.x + " y:" + _loc3_.y);
            trace("map x:" + GameControl.Instance.gameView.map.x + " y:" + GameControl.Instance.gameView.map.y);
            _loc2_.x = _loc4_.x - endPos.x;
            _loc2_.y = _loc4_.y - endPos.y;
            TweenLite.to(_loc2_,0.3 + 0.3 * Math.random(),{
               "x":_ghostBoxCenter.x,
               "y":_ghostBoxCenter.y,
               "onComplete":boxTweenComplete,
               "onCompleteParams":[_loc2_]
            });
         }
      }
      
      private function __psychicChanged(param1:LivingEvent) : void
      {
         _numField.setNum(_self.psychic);
         _numField.x = _back.width - _numField.width >> 1;
         _mouseArea.setPsychic(_self.psychic);
      }
      
      private function removeEvent() : void
      {
         _self.removeEventListener("psychicChanged",__psychicChanged);
         _self.removeEventListener("boxPick",__pickBox);
      }
      
      public function enter() : void
      {
         addEvent();
      }
      
      public function leaving() : void
      {
         removeEvent();
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         removeEvent();
         TweenLite.killTweensOf(this);
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_numField);
         _numField = null;
         ObjectUtils.disposeObject(_mouseArea);
         _mouseArea = null;
         if(_movie)
         {
            _movie.stop();
            ObjectUtils.disposeObject(_movie);
            _movie = null;
         }
         _self = null;
         var _loc4_:int = 0;
         var _loc3_:* = _ghostBitmapPool;
         for(var _loc2_ in _ghostBitmapPool)
         {
            _loc1_ = _ghostBitmapPool[_loc2_] as BitmapData;
            if(_loc1_)
            {
               _loc1_.dispose();
            }
            delete _ghostBitmapPool[_loc2_];
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function getGhostShape(param1:int) : Shape
      {
         var _loc3_:* = null;
         var _loc5_:Shape = new Shape();
         var _loc4_:String = "ghost" + param1;
         if(_ghostBitmapPool.hasOwnProperty(_loc4_))
         {
            _loc3_ = _ghostBitmapPool[_loc4_];
         }
         else
         {
            _loc3_ = ComponentFactory.Instance.creatBitmapData("asset.game.GhostBoxImage" + (param1 - 1));
            _ghostBitmapPool[_loc4_] = _loc3_;
         }
         var _loc2_:Graphics = _loc5_.graphics;
         _loc2_.beginBitmapFill(_loc3_);
         _loc2_.drawRect(0,0,_loc3_.width,_loc3_.height);
         _loc2_.endFill();
         return _loc5_;
      }
   }
}

import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.utils.ObjectUtils;
import ddt.display.BitmapShape;
import ddt.manager.BitmapManager;
import flash.display.Sprite;

class PsychicShape extends Sprite implements Disposeable
{
    
   
   private var _nums:Vector.<BitmapShape>;
   
   private var _num:int = 0;
   
   private var _bitmapMgr:BitmapManager;
   
   function PsychicShape()
   {
      _nums = new Vector.<BitmapShape>();
      super();
      _bitmapMgr = BitmapManager.getBitmapMgr("GameView");
      mouseEnabled = false;
      mouseChildren = false;
      draw();
   }
   
   private function draw() : void
   {
      var _loc1_:* = null;
      var _loc4_:int = 0;
      clear();
      var _loc2_:String = _num.toString();
      var _loc3_:int = _loc2_.length;
      _loc4_ = 0;
      while(_loc4_ < _loc3_)
      {
         _loc1_ = _bitmapMgr.creatBitmapShape("asset.game.PsychicBar.Num" + _loc2_.substr(_loc4_,1));
         if(_loc4_ > 0)
         {
            _loc1_.x = _nums[_loc4_ - 1].x + _nums[_loc4_ - 1].width;
         }
         addChild(_loc1_);
         _nums.push(_loc1_);
         _loc4_++;
      }
   }
   
   private function clear() : void
   {
      var _loc1_:BitmapShape = _nums.shift();
      while(_loc1_)
      {
         _loc1_.dispose();
         _loc1_ = _nums.shift();
      }
   }
   
   public function setNum(param1:int) : void
   {
      if(_num != param1)
      {
         _num = param1;
         draw();
      }
   }
   
   public function dispose() : void
   {
      clear();
      ObjectUtils.disposeObject(_bitmapMgr);
      _bitmapMgr = null;
      if(parent)
      {
         parent.removeChild(this);
      }
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.LayerManager;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.utils.ObjectUtils;
import ddt.manager.LanguageMgr;
import ddt.view.tips.ChangeNumToolTip;
import ddt.view.tips.ChangeNumToolTipInfo;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

class MouseArea extends Sprite implements Disposeable
{
    
   
   private var _tipData:String;
   
   private var _tipPanel:ChangeNumToolTip;
   
   private var _tipInfo:ChangeNumToolTipInfo;
   
   function MouseArea(param1:int)
   {
      super();
      var _loc2_:Graphics = graphics;
      _loc2_.beginFill(0,0);
      _loc2_.drawCircle(param1,param1,param1);
      _loc2_.endFill();
      addTip();
      addEvent();
   }
   
   public function setPsychic(param1:int) : void
   {
      _tipInfo.current = param1;
      _tipPanel.tipData = _tipInfo;
   }
   
   private function addEvent() : void
   {
      addEventListener("mouseOver",__mouseOver);
      addEventListener("mouseOut",__mouseOut);
   }
   
   private function removeEvent() : void
   {
      removeEventListener("mouseOver",__mouseOver);
      removeEventListener("mouseOut",__mouseOut);
   }
   
   public function dispose() : void
   {
      removeEvent();
      __mouseOut(null);
      ObjectUtils.disposeObject(_tipPanel);
      _tipPanel = null;
      if(parent)
      {
         parent.removeChild(this);
      }
   }
   
   private function addTip() : void
   {
      _tipPanel = new ChangeNumToolTip();
      _tipInfo = new ChangeNumToolTipInfo();
      _tipInfo.currentTxt = ComponentFactory.Instance.creatComponentByStylename("game.DanderStrip.currentTxt");
      _tipInfo.title = LanguageMgr.GetTranslation("tank.game.PsychicBar.Title");
      _tipInfo.current = 0;
      _tipInfo.total = 999;
      _tipInfo.content = LanguageMgr.GetTranslation("tank.game.PsychicBar.Content");
      _tipPanel.tipData = _tipInfo;
      _tipPanel.mouseChildren = false;
      _tipPanel.mouseEnabled = false;
   }
   
   private function __mouseOut(param1:MouseEvent) : void
   {
      if(_tipPanel && _tipPanel.parent)
      {
         _tipPanel.parent.removeChild(_tipPanel);
      }
   }
   
   private function __mouseOver(param1:MouseEvent) : void
   {
      var _loc2_:Rectangle = getBounds(LayerManager.Instance.getLayerByType(0));
      _tipPanel.x = _loc2_.right;
      _tipPanel.y = _loc2_.top - _tipPanel.height;
      LayerManager.Instance.addToLayer(_tipPanel,0,false);
   }
}
