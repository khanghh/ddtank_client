package gameCommon
{
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.events.CrazyTankSocketEvent;
   
   public interface IGameView
   {
       
      
      function playerBlood(param1:CrazyTankSocketEvent) : void;
      
      function updatePhysicObject(param1:CrazyTankSocketEvent) : void;
      
      function livingActionMapping(param1:CrazyTankSocketEvent) : void;
      
      function addMapThing(param1:CrazyTankSocketEvent) : void;
      
      function addliving(param1:CrazyTankSocketEvent) : void;
      
      function objectSetProperty(param1:CrazyTankSocketEvent) : void;
      
      function livingFalling(param1:CrazyTankSocketEvent) : void;
      
      function livingShowBlood(param1:CrazyTankSocketEvent) : void;
      
      function deleteAnimation(param1:int) : void;
      
      function get messageBtn() : BaseButton;
      
      function get map() : *;
      
      function addGameLivingToMap(param1:Array) : void;
   }
}
