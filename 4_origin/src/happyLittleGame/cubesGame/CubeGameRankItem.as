package happyLittleGame.cubesGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import funnyGames.cubeGame.data.CubeGameRankData;
   
   public class CubeGameRankItem extends Sprite implements Disposeable
   {
       
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      public function CubeGameRankItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.rankTxt");
         addChild(_rankTxt);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.nameTxt");
         addChild(_nameTxt);
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.scoreTxt");
         addChild(_scoreTxt);
      }
      
      public function set data(param1:CubeGameRankData) : void
      {
         var _loc2_:* = true;
         _scoreTxt.visible = _loc2_;
         _loc2_ = _loc2_;
         _nameTxt.visible = _loc2_;
         _rankTxt.visible = _loc2_;
         if(param1.rank == 1)
         {
            _loc2_ = "cubeGameRankView.rank1TF";
            _rankTxt.textFormatStyle = _loc2_;
            _loc2_ = _loc2_;
            _scoreTxt.textFormatStyle = _loc2_;
            _nameTxt.textFormatStyle = _loc2_;
         }
         else if(param1.rank == 2)
         {
            _loc2_ = "cubeGameRankView.rank2TF";
            _rankTxt.textFormatStyle = _loc2_;
            _loc2_ = _loc2_;
            _scoreTxt.textFormatStyle = _loc2_;
            _nameTxt.textFormatStyle = _loc2_;
         }
         else
         {
            _loc2_ = "cubeGameRankView.commonTF";
            _rankTxt.textFormatStyle = _loc2_;
            _loc2_ = _loc2_;
            _scoreTxt.textFormatStyle = _loc2_;
            _nameTxt.textFormatStyle = _loc2_;
         }
         _rankTxt.text = param1.rank.toString();
         _nameTxt.text = param1.name;
         _scoreTxt.text = param1.score.toString();
      }
      
      public function clear() : void
      {
         var _loc1_:* = false;
         _scoreTxt.visible = _loc1_;
         _loc1_ = _loc1_;
         _nameTxt.visible = _loc1_;
         _rankTxt.visible = _loc1_;
         _rankTxt.text = "";
         _nameTxt.text = "";
         _scoreTxt.text = "";
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _rankTxt = null;
         _nameTxt = null;
         _scoreTxt = null;
      }
   }
}
