package happyLittleGame.cubesGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import funnyGames.cubeGame.CubeGameManager;
   import funnyGames.cubeGame.event.CubeGameEvent;
   
   public class CubeGameInfoView extends Sprite implements Disposeable
   {
       
      
      private var _levelTxt:FilterFrameText;
      
      private var _waveTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      public function CubeGameInfoView(){super();}
      
      private function initView() : void{}
      
      private function initListener() : void{}
      
      private function removeListener() : void{}
      
      private function updateWave(param1:CubeGameEvent) : void{}
      
      private function updateScore(param1:CubeGameEvent = null) : void{}
      
      private function __resetInfo(param1:CubeGameEvent) : void{}
      
      private function updateView(param1:CubeGameEvent = null) : void{}
      
      public function dispose() : void{}
   }
}
