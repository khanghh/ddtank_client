package gameCommon.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import fightLib.FightLibManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import game.view.map.MapView;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import org.aswing.KeyboardManager;
   import trainer.controller.NewHandGuideManager;
   
   public class EnergyView extends Sprite implements Disposeable
   {
      
      public static var canPower:Boolean = false;
      
      public static const STRIP_WIDTH:Number = 498;
      
      public static const FORCE_MAX:Number = 2000;
      
      public static const SHOOT_FORCE_STEP:Number = 20;
      
      public static const HIT_FORCE_STEP:Number = 40;
       
      
      private var _recordeWidth:Number;
      
      private var _self:LocalPlayer;
      
      private var _force:Number = 0;
      
      private var _hitArea:Sprite;
      
      private var _forceSpeed:Number = 20;
      
      private var _hitX:int;
      
      private var _bg:Bitmap;
      
      private var _grayStrip:Bitmap;
      
      private var _lightStrip:Bitmap;
      
      private var _ruling:Bitmap;
      
      private var _slider:Sprite;
      
      private var _maxForce:int = 2000;
      
      private var _shootMsgShape:DisplayObject;
      
      private var _firstShoot:Boolean = false;
      
      private var _dynamismImg:Bitmap;
      
      private var _onProcess:Boolean = false;
      
      private var _keyDown:Boolean;
      
      private var _dir:int = 1;
      
      public function EnergyView(param1:LocalPlayer, param2:MapView = null){super();}
      
      private function __visiableDynamismBar(param1:LivingEvent) : void{}
      
      private function __maxForceChanged(param1:LivingEvent) : void{}
      
      private function __over(param1:CrazyTankSocketEvent) : void{}
      
      private function __keyDownSpace(param1:KeyboardEvent) : void{}
      
      private function __attackingChanged(param1:LivingEvent) : void{}
      
      private function __enterFrame(param1:Event) : void{}
      
      private function __beginNewTurn(param1:LivingEvent) : void{}
      
      private function calcForce() : void{}
      
      public function get force() : Number{return 0;}
      
      private function __click(param1:MouseEvent) : void{}
      
      public function enter() : void{}
      
      private function removeEvent() : void{}
      
      public function leaving() : void{}
      
      public function dispose() : void{}
   }
}
