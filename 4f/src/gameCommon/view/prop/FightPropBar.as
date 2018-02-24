package gameCommon.view.prop
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PropInfo;
   import ddt.events.LivingEvent;
   import ddt.manager.SharedManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import gameCommon.model.LocalPlayer;
   import org.aswing.KeyboardManager;
   
   public class FightPropBar extends Sprite implements Disposeable
   {
       
      
      protected var _mode:int;
      
      protected var _cells:Vector.<PropCell>;
      
      protected var _props:Vector.<PropInfo>;
      
      protected var _percentPropsList:Vector.<PropCell>;
      
      protected var _self:LocalPlayer;
      
      protected var _background:DisplayObject;
      
      protected var _enabled:Boolean = true;
      
      protected var _inited:Boolean = false;
      
      public function FightPropBar(param1:LocalPlayer){super();}
      
      public function enter() : void{}
      
      public function leaving() : void{}
      
      protected function configUI() : void{}
      
      protected function addEvent() : void{}
      
      protected function __enabledChanged(param1:LivingEvent) : void{}
      
      protected function __keyDown(param1:KeyboardEvent) : void{}
      
      protected function __die(param1:LivingEvent) : void{}
      
      protected function __changeAttack(param1:LivingEvent) : void{}
      
      protected function __energyChange(param1:LivingEvent) : void{}
      
      protected function updatePropByEnergy() : void{}
      
      protected function removeEvent() : void{}
      
      protected function drawLayer() : void{}
      
      protected function clearCells() : void{}
      
      protected function drawCells() : void{}
      
      protected function __itemClicked(param1:MouseEvent) : void{}
      
      public function setMode(param1:int) : void{}
      
      public function get enabled() : Boolean{return false;}
      
      public function set enabled(param1:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
