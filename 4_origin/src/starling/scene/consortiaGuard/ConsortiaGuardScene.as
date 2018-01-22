package starling.scene.consortiaGuard
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import starling.scene.Scene;
   
   public class ConsortiaGuardScene extends Scene
   {
       
      
      private var _playerView:ConsortiaGuardPlayerView;
      
      public function ConsortiaGuardScene()
      {
         super();
      }
      
      override public function enter() : void
      {
         super.enter();
         _playerView = new ConsortiaGuardPlayerView();
         _playerView.addSelfPlayer();
         _playerView.initPlayerView();
         addChild(_playerView);
      }
      
      override public function leaving() : void
      {
         super.leaving();
         dispose();
      }
      
      override public function dispose() : void
      {
         StarlingObjectUtils.disposeObject(_playerView);
         _playerView = null;
         super.dispose();
         removeChildren(0,-1,false);
         removeFromParent(false);
      }
      
      public function get playerView() : ConsortiaGuardPlayerView
      {
         return _playerView;
      }
   }
}
