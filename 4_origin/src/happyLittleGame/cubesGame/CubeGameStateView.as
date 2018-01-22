package happyLittleGame.cubesGame
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import funnyGames.cubeGame.CubeGameManager;
   import funnyGames.cubeGame.event.CubeGameEvent;
   
   public class CubeGameStateView extends BaseStateView
   {
       
      
      private var _mianSceneView:CubeGameSceneView;
      
      private var _rankView:CubeGameRankView;
      
      public function CubeGameStateView()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         this._mianSceneView = new CubeGameSceneView();
         this.addChild(this._mianSceneView);
         _rankView = new CubeGameRankView();
         PositionUtils.setPos(_rankView,"cubeGame.rankViewPos");
         addChild(_rankView);
         if(CubeGameManager.DEBUG)
         {
            this.swapChildren(_mianSceneView,_rankView);
         }
         CubeGameManager.getInstance().dispatchEvent(new CubeGameEvent("cooldown"));
         SoundManager.instance.playMusic("wenquan_1");
      }
      
      override public function getType() : String
      {
         return "minGameCubes";
      }
      
      override public function getBackType() : String
      {
         return "hotSpringRoom";
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         ObjectUtils.disposeAllChildren(this);
         this._mianSceneView = null;
         _rankView = null;
         StateManager.lastStateType = getType();
         super.leaving(param1);
      }
   }
}
