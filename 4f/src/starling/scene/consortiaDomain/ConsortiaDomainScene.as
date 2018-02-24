package starling.scene.consortiaDomain
{
   import consortiaDomain.ConsortiaDomainManager;
   import starling.scene.Scene;
   import starlingui.core.components.UVImage;
   
   public class ConsortiaDomainScene extends Scene
   {
       
      
      private var _playerView:PlayerView;
      
      public function ConsortiaDomainScene(){super();}
      
      override public function enter() : void{}
      
      override public function leaving() : void{}
      
      override public function dispose() : void{}
      
      public function get playerView() : PlayerView{return null;}
   }
}
