package gameStick
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.CoreController;
   import ddt.CoreManager;
   import gameStick.view.GameStickDetailBoard;
   import gameStick.view.GameStickGameOverBoard;
   import gameStick.view.GameStickRankFrame;
   import gameStick.view.GameStickShareFrame;
   
   public class GameStickManager extends CoreController
   {
      
      private static var instance:GameStickManager;
       
      
      private var _mgr:CoreManager;
      
      private var _frameDetail:GameStickDetailBoard;
      
      private var _frameGameOver:GameStickGameOverBoard;
      
      private var _frameShare:GameStickShareFrame;
      
      private var _frameRank:GameStickRankFrame;
      
      public function GameStickManager(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : GameStickManager
      {
         if(!instance)
         {
            instance = new GameStickManager(new inner());
         }
         return instance;
      }
      
      public function setup() : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      public function showDetail() : void
      {
         _frameDetail = new GameStickDetailBoard();
         LayerManager.Instance.addToLayer(_frameDetail,3,true,1);
      }
      
      public function showGameOver() : void
      {
         _frameGameOver = new GameStickGameOverBoard();
         LayerManager.Instance.addToLayer(_frameGameOver,3,true,1);
      }
      
      public function showShare() : void
      {
         _frameShare = ComponentFactory.Instance.creatComponentByStylename("gamestick.GameStickShareFrame");
         LayerManager.Instance.addToLayer(_frameShare,3,true,1);
      }
      
      public function showRank() : void
      {
         _frameRank = ComponentFactory.Instance.creatComponentByStylename("gamestick.GameStickRankFrame");
         LayerManager.Instance.addToLayer(_frameRank,3,true,1);
      }
      
      public function startGame() : void
      {
      }
      
      public function restart() : void
      {
      }
      
      public function exit() : void
      {
      }
      
      public function share() : void
      {
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
