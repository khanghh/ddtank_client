package gameCommon.view.prop
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import consortionBattle.player.ConsortiaBattlePlayerInfo;
   import consortionBattle.view.ConsBatLosingStreakBuff;
   import ddt.data.PropInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import org.aswing.KeyStroke;
   import room.RoomManager;
   import trainer.controller.NewHandGuideManager;
   import trainer.view.NewHandContainer;
   
   public class WeaponPropBar extends FightPropBar
   {
       
      
      private var _canEnable:Boolean = true;
      
      protected var _losingStreakIcon:ConsBatLosingStreakBuff;
      
      private var _localFlyVisible:Boolean = true;
      
      private var _localDeputyWeaponVisible:Boolean = true;
      
      private var _localVisible:Boolean = true;
      
      private var _localFlyEnabled:Boolean = true;
      
      public function WeaponPropBar(param1:LocalPlayer){super(null);}
      
      private function visibleFlyForWorldBoss() : void{}
      
      private function initLosingStreakInConsBat() : void{}
      
      private function weaponEnabled() : Boolean{return false;}
      
      override protected function updatePropByEnergy() : void{}
      
      override protected function __itemClicked(param1:MouseEvent) : void{}
      
      override protected function __keyDown(param1:KeyboardEvent) : void{}
      
      override protected function addEvent() : void{}
      
      override protected function __changeAttack(param1:LivingEvent) : void{}
      
      private function showGuidePlane() : void{}
      
      private function hideGuidePlane() : void{}
      
      private function __setDeputyWeaponNumber(param1:CrazyTankSocketEvent) : void{}
      
      private function __deputyWeaponChanged(param1:LivingEvent) : void{}
      
      private function __flyChanged(param1:LivingEvent) : void{}
      
      override protected function configUI() : void{}
      
      override public function dispose() : void{}
      
      override protected function drawCells() : void{}
      
      override protected function removeEvent() : void{}
      
      public function setFlyVisible(param1:Boolean) : void{}
      
      public function setFlyEnabled(param1:Boolean) : void{}
      
      public function setDeputyWeaponVisible(param1:Boolean) : void{}
      
      public function setVisible(param1:Boolean) : void{}
   }
}
