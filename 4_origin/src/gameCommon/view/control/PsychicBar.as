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
   import flash.geom.Rectangle;
   import game.objects.SimpleBox;
   import gameCommon.model.LocalPlayer;
   
   public class PsychicBar extends Sprite implements Disposeable
   {
       
      
      private var _self:LocalPlayer;
      
      private var _back:DisplayObject;
      
      private var _localPsychic:int;
      
      private var _numField:PsychicShape;
      
      private var _movie:MovieClip;
      
      private var _ghostBoxCenter:Point;
      
      private var _ghostBitmapPool:Object;
      
      private var _mouseArea:MouseArea;
      
      public function PsychicBar(self:LocalPlayer)
      {
         _ghostBitmapPool = {};
         _self = self;
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
      
      private function boxTweenComplete(box:DisplayObject) : void
      {
         ObjectUtils.disposeObject(box);
      }
      
      private function __pickBox(event:LivingEvent) : void
      {
         var ghostBox:* = null;
         var bounds:* = null;
         var box:SimpleBox = event.paras[0] as SimpleBox;
         if(box.isGhost)
         {
            ghostBox = getGhostShape(box.subType);
            addChild(ghostBox);
            bounds = box.getBounds(this);
            ghostBox.x = bounds.x;
            ghostBox.y = bounds.y;
            TweenLite.to(ghostBox,0.3 + 0.3 * Math.random(),{
               "x":_ghostBoxCenter.x,
               "y":_ghostBoxCenter.y,
               "onComplete":boxTweenComplete,
               "onCompleteParams":[ghostBox]
            });
         }
      }
      
      private function __psychicChanged(event:LivingEvent) : void
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
         var bitmapData:* = null;
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
         for(var key in _ghostBitmapPool)
         {
            bitmapData = _ghostBitmapPool[key] as BitmapData;
            if(bitmapData)
            {
               bitmapData.dispose();
            }
            delete _ghostBitmapPool[key];
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function getGhostShape(type:int) : Shape
      {
         var bitmapData:* = null;
         var ghastBox:* = null;
         var shape:Shape = new Shape();
         var name:String = "ghost" + type;
         if(_ghostBitmapPool.hasOwnProperty(name))
         {
            bitmapData = _ghostBitmapPool[name];
         }
         else
         {
            ghastBox = ClassUtils.CreatInstance("asset.game.GhostBox" + (type - 1)) as MovieClip;
            ghastBox.gotoAndStop("shot");
            bitmapData = new BitmapData(ghastBox.width,ghastBox.height,true,0);
            bitmapData.draw(ghastBox);
            _ghostBitmapPool[name] = bitmapData;
         }
         var pen:Graphics = shape.graphics;
         pen.beginBitmapFill(bitmapData);
         pen.drawRect(0,0,bitmapData.width,bitmapData.height);
         pen.endFill();
         return shape;
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
      var num:* = null;
      var i:int = 0;
      clear();
      var _numString:String = _num.toString();
      var len:int = _numString.length;
      for(i = 0; i < len; )
      {
         num = _bitmapMgr.creatBitmapShape("asset.game.PsychicBar.Num" + _numString.substr(i,1));
         if(i > 0)
         {
            num.x = _nums[i - 1].x + _nums[i - 1].width;
         }
         addChild(num);
         _nums.push(num);
         i++;
      }
   }
   
   private function clear() : void
   {
      var num:BitmapShape = _nums.shift();
      while(num)
      {
         num.dispose();
         num = _nums.shift();
      }
   }
   
   public function setNum(val:int) : void
   {
      if(_num != val)
      {
         _num = val;
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
   
   function MouseArea(radius:int)
   {
      super();
      var pen:Graphics = graphics;
      pen.beginFill(0,0);
      pen.drawCircle(radius,radius,radius);
      pen.endFill();
      addTip();
      addEvent();
   }
   
   public function setPsychic(val:int) : void
   {
      _tipInfo.current = val;
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
   
   private function __mouseOut(evt:MouseEvent) : void
   {
      if(_tipPanel && _tipPanel.parent)
      {
         _tipPanel.parent.removeChild(_tipPanel);
      }
   }
   
   private function __mouseOver(evt:MouseEvent) : void
   {
      var bounds:Rectangle = getBounds(LayerManager.Instance.getLayerByType(0));
      _tipPanel.x = bounds.right;
      _tipPanel.y = bounds.top - _tipPanel.height;
      LayerManager.Instance.addToLayer(_tipPanel,0,false);
   }
}
