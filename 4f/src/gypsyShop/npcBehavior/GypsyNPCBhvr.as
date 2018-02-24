package gypsyShop.npcBehavior
{
   import com.pickgliss.ui.core.Component;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import hall.HallStateView;
   import road7th.StarlingMain;
   import starling.scene.hall.HallScene;
   import starling.scene.hall.StaticLayer;
   
   public class GypsyNPCBhvr implements IGypsyNPCBehavior
   {
       
      
      private var _hall:HallStateView;
      
      private var _container:Sprite;
      
      private var _hotArea:Component;
      
      private var _gypsyNPC:MovieClip;
      
      public function GypsyNPCBhvr(param1:Sprite){super();}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      public function dispose() : void{}
      
      public function set container(param1:Sprite) : void{}
      
      public function set hotArea(param1:InteractiveObject) : void{}
      
      public function set hallView(param1:HallStateView) : void{}
   }
}
