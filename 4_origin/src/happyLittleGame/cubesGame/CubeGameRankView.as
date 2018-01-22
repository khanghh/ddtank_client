package happyLittleGame.cubesGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import funnyGames.FunnyGamesManager;
   import funnyGames.cubeGame.CubeGameManager;
   import funnyGames.cubeGame.data.CubeGameRankData;
   import funnyGames.cubeGame.event.CubeGameEvent;
   import funnyGames.event.FunnyGamesEvent;
   
   public class CubeGameRankView extends Sprite implements Disposeable
   {
      
      private static const _ROW_CNT:uint = 10;
       
      
      private var _totalBtn:SimpleBitmapButton;
      
      private var _todayBtn:SimpleBitmapButton;
      
      private var _list:VBox;
      
      private var _items:Vector.<CubeGameRankItem>;
      
      private var _restartBtn:SimpleBitmapButton;
      
      private var _returnBtn:SimpleBitmapButton;
      
      private var _myTotalRankTxt:FilterFrameText;
      
      private var _myTodayRankTxt:FilterFrameText;
      
      private var _historyScoreTxt:FilterFrameText;
      
      private var _todayScoreTxt:FilterFrameText;
      
      private var _pagerightBtn:BaseButton;
      
      private var _pageleftBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageEndBtn:BaseButton;
      
      private var _pageFirstBtn:BaseButton;
      
      private var _pageIdx:int = 1;
      
      private var _isTotalRank:Boolean = false;
      
      public function CubeGameRankView()
      {
         _items = new Vector.<CubeGameRankItem>();
         super();
         initView();
         initListener();
      }
      
      private function initView() : void
      {
         var _loc3_:* = 0;
         var _loc1_:* = null;
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.cubeGameRankView.bg");
         addChild(_loc2_);
         _todayBtn = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.todayBtn");
         addChild(_todayBtn);
         _totalBtn = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.totalBtn");
         addChild(_totalBtn);
         _list = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.list");
         addChild(_list);
         _loc3_ = uint(0);
         while(_loc3_ < 10)
         {
            _loc1_ = new CubeGameRankItem();
            _list.addChild(_loc1_);
            _items.push(_loc1_);
            _loc3_++;
         }
         _restartBtn = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.restartBtn");
         _restartBtn.addEventListener("click",__onClick);
         addChild(_restartBtn);
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.returnBtn");
         _returnBtn.addEventListener("click",__onClick);
         addChild(_returnBtn);
         _myTotalRankTxt = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.myTotalRankTxt");
         addChild(_myTotalRankTxt);
         _myTodayRankTxt = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.myTodayRankTxt");
         addChild(_myTodayRankTxt);
         _historyScoreTxt = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.historyScoreTxt");
         addChild(_historyScoreTxt);
         _todayScoreTxt = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.todayScoreTxt");
         addChild(_todayScoreTxt);
         _pagerightBtn = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.rightPageBtn");
         addChild(_pagerightBtn);
         _pageleftBtn = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.leftPageBtn");
         addChild(_pageleftBtn);
         _pageEndBtn = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.endBtn");
         addChild(_pageEndBtn);
         _pageFirstBtn = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.firstBtn");
         addChild(_pageFirstBtn);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("cubeGameRankView.pageTxt");
         addChild(_pageTxt);
         updateGameInfo();
         updateView();
      }
      
      private function initListener() : void
      {
         _todayBtn.addEventListener("click",__onClick);
         _totalBtn.addEventListener("click",__onClick);
         _restartBtn.addEventListener("click",__onClick);
         _pagerightBtn.addEventListener("click",__pageClick);
         _pageleftBtn.addEventListener("click",__pageClick);
         _pageFirstBtn.addEventListener("click",__pageClick);
         _pageEndBtn.addEventListener("click",__pageClick);
         FunnyGamesManager.getInstance().addEventListener("rankUpdate",updateView);
         CubeGameManager.getInstance().addEventListener("gameStart",updateGameInfo);
      }
      
      private function setPageMaxCnt() : void
      {
         var _loc1_:Vector.<CubeGameRankData> = CubeGameManager.getInstance().getRankDataList(0,16777215,_isTotalRank);
         var _loc2_:uint = Math.ceil(_loc1_.length / 10);
         _loc2_ = _loc2_ == 0?1:_loc2_;
         _pageTxt.text = _pageIdx + "/" + _loc2_;
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleBitmapButton = param1.currentTarget as SimpleBitmapButton;
         var _loc3_:* = _loc2_;
         if(_totalBtn !== _loc3_)
         {
            if(_todayBtn !== _loc3_)
            {
               if(_restartBtn !== _loc3_)
               {
                  if(_returnBtn === _loc3_)
                  {
                     CubeGameManager.getInstance().endGame();
                     StateManager.back();
                  }
               }
               else
               {
                  CubeGameManager.getInstance().requestRestartGame();
               }
            }
            else
            {
               _isTotalRank = false;
               _pageIdx = 1;
               updateView();
            }
         }
         else
         {
            _isTotalRank = true;
            _pageIdx = 1;
            updateView();
         }
         SoundManager.instance.playButtonSound();
      }
      
      private function __pageClick(param1:MouseEvent) : void
      {
         var _loc3_:BaseButton = param1.currentTarget as BaseButton;
         var _loc2_:Vector.<CubeGameRankData> = CubeGameManager.getInstance().getRankDataList(0,16777215,_isTotalRank);
         var _loc4_:uint = Math.ceil(_loc2_.length / 10);
         var _loc5_:* = _loc3_;
         if(_pagerightBtn !== _loc5_)
         {
            if(_pageleftBtn !== _loc5_)
            {
               if(_pageEndBtn !== _loc5_)
               {
                  if(_pageFirstBtn === _loc5_)
                  {
                     _pageIdx = 1;
                  }
               }
               else
               {
                  _pageIdx = _loc4_;
               }
            }
            else
            {
               if(_pageIdx <= 1)
               {
                  §§push(1);
               }
               else
               {
                  _pageIdx = _pageIdx - 1;
                  §§push(_pageIdx - 1);
               }
               _pageIdx = §§pop();
            }
         }
         else
         {
            if(_pageIdx >= _loc4_)
            {
               §§push(_loc4_);
            }
            else
            {
               _pageIdx = _pageIdx + 1;
               §§push(_pageIdx + 1);
            }
            _pageIdx = §§pop();
         }
         updateView();
         SoundManager.instance.playButtonSound();
      }
      
      private function updateView(param1:FunnyGamesEvent = null) : void
      {
         var _loc8_:int = 0;
         var _loc5_:* = null;
         setPageMaxCnt();
         var _loc3_:uint = (_pageIdx - 1) * 10;
         var _loc7_:uint = this._pageIdx * 10;
         var _loc6_:Vector.<CubeGameRankData> = CubeGameManager.getInstance().getRankDataList(_loc3_,_loc7_,_isTotalRank);
         _loc8_ = 0;
         while(_loc8_ < 10)
         {
            _loc5_ = _items[_loc8_];
            if(_loc5_)
            {
               _loc5_.clear();
               if(_loc8_ < _loc6_.length)
               {
                  _loc5_.data = _loc6_[_loc8_];
               }
            }
            _loc8_++;
         }
         _list.arrange();
         var _loc2_:int = CubeGameManager.getInstance().getSelfRank(true);
         _myTotalRankTxt.text = _loc2_ == -1?LanguageMgr.GetTranslation("ddt.simpleGameRank.frame.noRank"):_loc2_.toString();
         var _loc4_:int = CubeGameManager.getInstance().getSelfRank();
         _myTodayRankTxt.text = _loc4_ == -1?LanguageMgr.GetTranslation("ddt.simpleGameRank.frame.noRank"):_loc4_.toString();
      }
      
      private function updateGameInfo(param1:CubeGameEvent = null) : void
      {
         _historyScoreTxt.text = CubeGameManager.getInstance().gameInfo.historyHgihScore.toString();
         _todayScoreTxt.text = CubeGameManager.getInstance().gameInfo.dailyHighScore.toString();
      }
      
      private function removeListener() : void
      {
         _todayBtn.removeEventListener("click",__onClick);
         _totalBtn.removeEventListener("click",__onClick);
         _restartBtn.removeEventListener("click",__onClick);
         _pagerightBtn.addEventListener("click",__pageClick);
         _pageleftBtn.addEventListener("click",__pageClick);
         _pageFirstBtn.addEventListener("click",__pageClick);
         _pageEndBtn.addEventListener("click",__pageClick);
         FunnyGamesManager.getInstance().removeEventListener("rankUpdate",updateView);
         CubeGameManager.getInstance().removeEventListener("gameStart",updateGameInfo);
      }
      
      public function dispose() : void
      {
         removeListener();
         while(_items.length > 0)
         {
            _items.pop();
         }
         _items = null;
         ObjectUtils.disposeAllChildren(this);
         _todayBtn = null;
         _totalBtn = null;
         _restartBtn = null;
         _myTodayRankTxt = null;
         _myTotalRankTxt = null;
      }
   }
}
