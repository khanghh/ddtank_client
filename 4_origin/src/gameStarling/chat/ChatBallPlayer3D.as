package gameStarling.chat
{
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameStarling.objects.GameLiving3D;
   import gameStarling.view.GameView3D;
   
   public class ChatBallPlayer3D extends ChatBallPlayer
   {
       
      
      public var player:GameLiving3D;
      
      public function ChatBallPlayer3D()
      {
         super();
      }
      
      override public function show() : void
      {
         (GameControl.Instance.gameView as GameView3D).mapSprite.addChild(this);
         super.show();
      }
      
      override public function set direction(value:Point) : void
      {
      }
      
      override public function set directionX(value:Number) : void
      {
      }
      
      override public function set directionY(value:Number) : void
      {
      }
      
      public function setPos(x:Number, y:Number) : void
      {
         if(player)
         {
            this.x = x + player.pos.x;
            this.y = y + player.pos.y;
         }
      }
   }
}
