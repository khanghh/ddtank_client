package happyLittleGame.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import funnyGames.FunnyGamesManager;
   import funnyGames.event.FunnyGamesEvent;
   import happyLittleGame.rank.items.SimpleGameRankItem;
   import uiModeManager.bombUI.HappyLittleGameManager;
   import uiModeManager.bombUI.model.rank.HappyMiniGameRankData;
   import uiUtils.SelectPageUI;
   
   public class SimpleGameRankFrame extends Frame
   {
      
      private static const COLUMN_CNT:uint = 10;
       
      
      private var _bg:Bitmap;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _selectPageUI:SelectPageUI;
      
      private var _list:VBox;
      
      private var _noRankTxt:FilterFrameText;
      
      private var _pageIdx:uint = 1;
      
      private var _itemList:Vector.<SimpleGameRankItem>;
      
      public function SimpleGameRankFrame()
      {
         super();
         _itemList = new Vector.<SimpleGameRankItem>();
         initView();
         initListener();
      }
      
      private function initView() : void
      {
         var i:* = 0;
         var item:* = null;
         this.titleText = LanguageMgr.GetTranslation("ddt.simpleGameRank.frame.title");
         this._bg = ComponentFactory.Instance.creatBitmap("assets.simpleGame.rankBg");
         this.addToContent(this._bg);
         PositionUtils.setPos(_bg,"happygame.rankBg.pos");
         this._helpBtn = ComponentFactory.Instance.creatComponentByStylename("simpleGameRank.frame.helpbtn");
         this.addToContent(this._helpBtn);
         this._list = ComponentFactory.Instance.creatComponentByStylename("simpleGameRank.frame.list");
         this.addToContent(this._list);
         this._selectPageUI = ComponentFactory.Instance.creatComponentByStylename("simpleGameRank.selectPageUI");
         this.addToContent(this._selectPageUI);
         for(i = uint(0); i < 10; )
         {
            item = new SimpleGameRankItem(i);
            this._itemList.push(item);
            this._list.addChild(item);
            i++;
         }
         this._list.arrange();
         this._noRankTxt = ComponentFactory.Instance.creatComponentByStylename("simpleGameRank.noRankTxt");
         this.addToContent(this._noRankTxt);
         this._noRankTxt.text = LanguageMgr.GetTranslation("ddt.simpleGameRank.frame.noRank");
         this.updateView();
      }
      
      private function initListener() : void
      {
         this._selectPageUI.addEventListener("change",onPageChange);
         this._helpBtn.addEventListener("click",onHelpClick);
         FunnyGamesManager.getInstance().addEventListener("rankRewardUpdate",__updateView);
      }
      
      private function removeListener() : void
      {
         this._selectPageUI.removeEventListener("change",onPageChange);
         this._helpBtn.removeEventListener("click",onHelpClick);
         FunnyGamesManager.getInstance().removeEventListener("rankRewardUpdate",__updateView);
      }
      
      private function onHelpClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("store.view.HelpButtonText"),"ddt.littlegame.rankHelp",410,490,false);
      }
      
      private function onPageChange(evt:Event) : void
      {
         _pageIdx = this._selectPageUI.currentPage;
         this.updateView();
      }
      
      private function __updateView(evt:FunnyGamesEvent) : void
      {
         updateView();
      }
      
      private function updateView() : void
      {
         var i:int = 0;
         var item:* = null;
         var selfRank:int = HappyLittleGameManager.instance.getSelfRank();
         this._noRankTxt.text = selfRank == -1?LanguageMgr.GetTranslation("ddt.simpleGameRank.frame.noRank"):(selfRank + 1).toString();
         var totalRankDataList:Vector.<HappyMiniGameRankData> = HappyLittleGameManager.instance.getRankDataList();
         var pageCnt:uint = totalRankDataList.length / 10;
         if(pageCnt * 10 < totalRankDataList.length)
         {
            pageCnt = pageCnt + 1;
         }
         this._selectPageUI.maxPage = pageCnt;
         var startIndex:uint = (this._pageIdx - 1) * 10;
         var endIndex:uint = this._pageIdx * 10;
         var rankDataList:Vector.<HappyMiniGameRankData> = HappyLittleGameManager.instance.getRankDataList(startIndex,endIndex);
         this.clearItemList();
         for(i = 0; i < rankDataList.length; )
         {
            if(i < this._itemList.length)
            {
               item = this._itemList[i];
               if(item)
               {
                  item.data = rankDataList[i];
               }
            }
            i++;
         }
      }
      
      private function clearItemList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = this._itemList;
         for each(var item in this._itemList)
         {
            if(item)
            {
               item.clear();
            }
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override public function dispose() : void
      {
         removeListener();
         super.dispose();
         this._bg = null;
         this._helpBtn = null;
         this._list = null;
         while(this._itemList.length > 0)
         {
            this._itemList.pop();
         }
         this._itemList = null;
         this._selectPageUI = null;
      }
      
      override protected function onResponse(type:int) : void
      {
         SoundManager.instance.play("008");
         this.dispose();
      }
   }
}
