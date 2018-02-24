package gypsyShop.npcBehavior
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import hall.HallStateView;
   
   public interface IGypsyNPCBehavior
   {
       
      
      function dispose() : void;
      
      function show() : void;
      
      function hide() : void;
      
      function set container(param1:Sprite) : void;
      
      function set hotArea(param1:InteractiveObject) : void;
      
      function set hallView(param1:HallStateView) : void;
   }
}
