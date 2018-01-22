package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import worldboss.WorldBossManager;
   
   public class WorldBossHPScript extends Sprite implements Disposeable
   {
       
      
      private var _bloodStrip:MovieClip;
      
      private var _bloodWidth:int;
      
      private var _hp_text:TextField;
      
      private var _bossName_text:TextField;
      
      private var _scale:Number;
      
      private var _iscuting:Boolean;
      
      private var speed:Number = 1.0;
      
      public function WorldBossHPScript(){super();}
      
      private function init() : void{}
      
      public function refreshBossName() : void{}
      
      public function refreshBlood() : void{}
      
      private function addEvent() : void{}
      
      private function showBloodText() : void{}
      
      private function updateBloodStrip(param1:Event) : void{}
      
      private function playCutHpMC(param1:Number) : void{}
      
      private function cutHpred2(param1:Event) : void{}
      
      private function __showCutHp() : void{}
      
      private function offset(param1:int = 30) : int{return 0;}
      
      public function dispose() : void{}
   }
}
