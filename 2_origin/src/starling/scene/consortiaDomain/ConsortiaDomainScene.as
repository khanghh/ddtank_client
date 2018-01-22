package starling.scene.consortiaDomain
{
   import consortiaDomain.ConsortiaDomainManager;
   import starling.scene.Scene;
   import starlingui.core.components.UVImage;
   
   public class ConsortiaDomainScene extends Scene
   {
       
      
      private var _playerView:PlayerView;
      
      public function ConsortiaDomainScene()
      {
         super();
      }
      
      override public function enter() : void
      {
         super.enter();
         ConsortiaDomainManager.instance.onEnterScene();
         _playerView = new PlayerView();
         addChild(_playerView);
      }
      
      override public function leaving() : void
      {
         super.leaving();
         ConsortiaDomainManager.instance.onLeaveScene();
         dispose();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeChildren(0,-1,false);
         removeFromParent(false);
         _playerView = null;
         ConsortiaDomainManager.instance.disposeBuildViewBtn();
      }
      
      public function get playerView() : PlayerView
      {
         return _playerView;
      }
   }
}
