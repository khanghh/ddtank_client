package cityBattle.view
{
   import cityBattle.CityBattleManager;
   import cityBattle.event.CityBattleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ContentionView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _infoTxt:FilterFrameText;
      
      private var _currentSocreTxt:FilterFrameText;
      
      private var _currentRankTxt:FilterFrameText;
      
      private var blueTable:ContentionTable;
      
      private var redTable:ContentionTable;
      
      private var _inspireBtn:BaseButton;
      
      private var _blueTotalScore:FilterFrameText;
      
      private var _redTotalScore:FilterFrameText;
      
      public function ContentionView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.cityBattle.bg2");
         addChild(_bg);
         _infoTxt = ComponentFactory.Instance.creatComponentByStylename("contention.info.txt");
         addChild(_infoTxt);
         _infoTxt.text = LanguageMgr.GetTranslation("ddt.cityBattle.inspire.introduce");
         _currentSocreTxt = ComponentFactory.Instance.creatComponentByStylename("contention.currentSocre.txt");
         addChild(_currentSocreTxt);
         _currentRankTxt = ComponentFactory.Instance.creatComponentByStylename("contention.currentRank.txt");
         addChild(_currentRankTxt);
         _blueTotalScore = ComponentFactory.Instance.creatComponentByStylename("contention.totalScore.txt");
         addChild(_blueTotalScore);
         _redTotalScore = ComponentFactory.Instance.creatComponentByStylename("contention.totalScore.txt");
         addChild(_redTotalScore);
         PositionUtils.setPos(_redTotalScore,"contention.redTotalScore.txtPos");
         blueTable = new ContentionTable(0);
         addChild(blueTable);
         redTable = new ContentionTable(1);
         addChild(redTable);
         _inspireBtn = ComponentFactory.Instance.creatComponentByStylename("contention.inspireBtn");
         addChild(_inspireBtn);
         _inspireBtn.addEventListener("click",_inspireBtnHandler);
         if(CityBattleManager.instance.now > 0 && CityBattleManager.instance.now < 8)
         {
            if(CityBattleManager.instance.castellanList[CityBattleManager.instance.now - 1].side == CityBattleManager.instance.winnerExchangeInfo[CityBattleManager.instance.now - 1])
            {
               if(CityBattleManager.instance.castellanList[CityBattleManager.instance.now - 1].side == 0)
               {
                  _inspireBtn.mouseEnabled = true;
                  _inspireBtn.filters = null;
               }
               else
               {
                  _inspireBtn.mouseEnabled = false;
                  _inspireBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               }
            }
            else
            {
               _inspireBtn.mouseEnabled = true;
               _inspireBtn.filters = null;
            }
         }
         else
         {
            _inspireBtn.mouseEnabled = false;
            _inspireBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         CityBattleManager.instance.addEventListener("score_rank",_scoreChange);
         SocketManager.Instance.out.cityBattleScore();
      }
      
      private function _scoreChange(param1:CityBattleEvent) : void
      {
         _currentSocreTxt.text = String(CityBattleManager.instance.myRankScore);
         _currentRankTxt.text = CityBattleManager.instance.myRank == -1?LanguageMgr.GetTranslation("ddt.cityBattle.noHaveRank"):String(CityBattleManager.instance.myRank);
         _blueTotalScore.text = String(CityBattleManager.instance.blueTotalScore);
         _redTotalScore.text = String(CityBattleManager.instance.redTotalScore);
      }
      
      private function _inspireBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:ContentionInspireFrame = ComponentFactory.Instance.creatComponentByStylename("contention.inspireFrame");
         LayerManager.Instance.addToLayer(_loc2_,3,true,2);
      }
      
      public function dispose() : void
      {
         _inspireBtn.removeEventListener("click",_inspireBtnHandler);
         CityBattleManager.instance.removeEventListener("score_rank",_scoreChange);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_infoTxt);
         _infoTxt = null;
         ObjectUtils.disposeObject(_currentSocreTxt);
         _currentSocreTxt = null;
         ObjectUtils.disposeObject(_currentRankTxt);
         _currentRankTxt = null;
         ObjectUtils.disposeObject(_inspireBtn);
         _inspireBtn = null;
         ObjectUtils.disposeObject(_blueTotalScore);
         _blueTotalScore = null;
         ObjectUtils.disposeObject(_redTotalScore);
         _redTotalScore = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
