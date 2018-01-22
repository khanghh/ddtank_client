package gameStarling.view.scene
{
   import starling.scene.Scene;
   
   public class GameViewScene extends Scene
   {
       
      
      public function GameViewScene()
      {
         super();
      }
      
      override public function enter() : void
      {
         super.enter();
      }
      
      override public function leaving() : void
      {
         super.leaving();
         dispose();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeChildren(0,-1,false);
         removeFromParent(false);
      }
   }
}
