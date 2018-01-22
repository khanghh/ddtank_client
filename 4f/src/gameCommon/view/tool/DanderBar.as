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
      
      public function DanderBar(param1:LocalPlayer, param2:DisplayObjectContainer){super();}
      
      private function addEvent() : void{}
      
      private function __attackingChanged(param1:LivingEvent) : void{}
      
      private function __keyDown(param1:KeyboardEvent) : void{}
      
      private function useSkill() : void{}
      
      private function addDanderStripTip() : void{}
      
      private function __mouseOut(param1:MouseEvent) : void{}
      
      private function __mouseOver(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __spellKillChanged(param1:LivingEvent) : void{}
      
      private function __click(param1:MouseEvent) : void{}
      
      private function __danderChanged(param1:LivingEvent) : void{}
      
      private function setDander() : void{}
      
      private function drawProgress(param1:Number) : void{}
      
      private function configUI() : void{}
      
      public function set localDander(param1:int) : void{}
      
      public function get localDander() : int{return 0;}
      
      public function setVisible(param1:Boolean) : void{}
      
      public function set specialEnabled(param1:Boolean) : void{}
      
      public function dispose() : void{}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function get tipDirctions() : String{return null;}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipGapH(param1:int) : void{}
      
      public function get tipGapV() : int{return 0;}
      
      public function set tipGapV(param1:int) : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function set tipStyle(param1:String) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
