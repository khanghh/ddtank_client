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
      
      public function PowerStrip(){super();}
      
      private function addDanderStripTip() : void{}
      
      private function initEvents() : void{}
      
      private function __showTip(param1:MouseEvent) : void{}
      
      private function __hideTip(param1:MouseEvent) : void{}
      
      private function __update(param1:LivingEvent) : void{}
      
      private function removeEvents() : void{}
      
      private function _timerComplete(param1:TimerEvent) : void{}
      
      public function dispose() : void{}
   }
}
