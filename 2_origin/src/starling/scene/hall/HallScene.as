package starling.scene.hall
{
   import starling.scene.Scene;
   
   public class HallScene extends Scene
   {
       
      
      private var _playerView:HallPlayerView;
      
      public function HallScene()
      {
         super();
         _playerView = new HallPlayerView();
         addChild(_playerView);
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
         _playerView = null;
      }
      
      public function get playerView() : HallPlayerView
      {
         return _playerView;
      }
   }
}
