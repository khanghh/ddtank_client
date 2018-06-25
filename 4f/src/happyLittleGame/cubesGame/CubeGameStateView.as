package happyLittleGame.cubesGame{   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.states.BaseStateView;   import ddt.utils.PositionUtils;   import funnyGames.cubeGame.CubeGameManager;   import funnyGames.cubeGame.event.CubeGameEvent;      public class CubeGameStateView extends BaseStateView   {                   private var _mianSceneView:CubeGameSceneView;            private var _rankView:CubeGameRankView;            public function CubeGameStateView() { super(); }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            override public function getType() : String { return null; }
            override public function getBackType() : String { return null; }
            override public function leaving(next:BaseStateView) : void { }
   }}