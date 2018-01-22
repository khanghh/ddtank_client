package starling.scene.hall
{
   import starling.scene.Scene;
   
   public class HallScene extends Scene
   {
       
      
      private var _playerView:HallPlayerView;
      
      public function HallScene(){super();}
      
      override public function enter() : void{}
      
      override public function leaving() : void{}
      
      override public function dispose() : void{}
      
      public function get playerView() : HallPlayerView{return null;}
   }
}
