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
      
      public function CubeGameInfoView()
      {
         super();
         initView();
         initListener();
      }
      
      private function initView() : void
      {
         var leftWoodImg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.cubeGameInfoView.leftWoodBg");
         PositionUtils.setPos(leftWoodImg,"cubeGameInfoView.leftWoodBgPos");
         addChild(leftWoodImg);
         var rightWoodImg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.cubeGameInfoView.rightWoodBg");
         PositionUtils.setPos(rightWoodImg,"cubeGameInfoView.rightWoodBgPos");
         addChild(rightWoodImg);
         var waveImg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.cubeGameInfoView.waveImg");
         PositionUtils.setPos(waveImg,"cubeGameInfoView.waveImgPos");
         addChild(waveImg);
         var scoreImg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.cubeGameInfoView.scoreImg");
         PositionUtils.setPos(scoreImg,"cubeGameInfoView.scoreImgPos");
         addChild(scoreImg);
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("cubeGameInfoView.levelTxt");
         addChild(_levelTxt);
         _waveTxt = ComponentFactory.Instance.creatComponentByStylename("cubeGameInfoView.waveTxt");
         addChild(_waveTxt);
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("cubeGameInfoView.scoreTxt");
         addChild(_scoreTxt);
         updateView();
      }
      
      private function initListener() : void
      {
         CubeGameManager.getInstance().addEventListener("cubeDeath",updateView);
         CubeGameManager.getInstance().addEventListener("gameStart",updateView);
         CubeGameManager.getInstance().addEventListener("cubeGenerate",updateWave);
         CubeGameManager.getInstance().addEventListener("gameResult",updateScore);
         CubeGameManager.getInstance().addEventListener("clearMap",__resetInfo);
      }
      
      private function removeListener() : void
      {
         CubeGameManager.getInstance().removeEventListener("cubeDeath",updateView);
         CubeGameManager.getInstance().removeEventListener("gameStart",updateView);
         CubeGameManager.getInstance().removeEventListener("cubeGenerate",updateWave);
         CubeGameManager.getInstance().removeEventListener("clearMap",__resetInfo);
         CubeGameManager.getInstance().removeEventListener("gameResult",updateScore);
      }
      
      private function updateWave(evt:CubeGameEvent) : void
      {
         _waveTxt.text = CubeGameManager.getInstance().gameInfo.curWaveNum + "/" + CubeGameManager.getInstance().gameInfo.totalWaveNum;
      }
      
      private function updateScore(evt:CubeGameEvent = null) : void
      {
         _scoreTxt.text = CubeGameManager.getInstance().gameInfo.curScore.toString();
      }
      
      private function __resetInfo(evt:CubeGameEvent) : void
      {
         CubeGameManager.getInstance().gameInfo.level = 0;
         _levelTxt.text = CubeGameManager.getInstance().gameInfo.level.toString();
         CubeGameManager.getInstance().gameInfo.curWaveNum = 1;
         _waveTxt.text = CubeGameManager.getInstance().gameInfo.curWaveNum + "/" + CubeGameManager.getInstance().gameInfo.totalWaveNum;
         CubeGameManager.getInstance().gameInfo.curScore = 0;
         _scoreTxt.text = CubeGameManager.getInstance().gameInfo.curScore.toString();
      }
      
      private function updateView(evt:CubeGameEvent = null) : void
      {
         if(!evt || evt.type != "cubeDeath")
         {
            _levelTxt.text = CubeGameManager.getInstance().gameInfo.level.toString();
            _waveTxt.text = CubeGameManager.getInstance().gameInfo.curWaveNum + "/" + CubeGameManager.getInstance().gameInfo.totalWaveNum;
         }
         updateScore();
      }
      
      public function dispose() : void
      {
         removeListener();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
