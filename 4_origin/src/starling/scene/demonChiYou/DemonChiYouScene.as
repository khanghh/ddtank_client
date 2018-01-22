package starling.scene.demonChiYou
{
   import demonChiYou.DemonChiYouManager;
   import starling.scene.Scene;
   
   public class DemonChiYouScene extends Scene
   {
       
      
      private var _playerView:PlayerView;
      
      public function DemonChiYouScene()
      {
         super();
      }
      
      override public function enter() : void
      {
         super.enter();
         DemonChiYouManager.instance.initEvent();
         _playerView = new PlayerView();
         addChild(_playerView);
      }
      
      override public function leaving() : void
      {
         super.leaving();
         DemonChiYouManager.instance.removeEvent();
         dispose();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeChildren(0,-1,false);
         removeFromParent(false);
         _playerView = null;
      }
      
      public function get playerView() : PlayerView
      {
         return _playerView;
      }
   }
}
