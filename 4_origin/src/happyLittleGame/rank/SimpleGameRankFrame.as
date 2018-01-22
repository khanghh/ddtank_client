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
         var _loc2_:* = 0;
         var _loc1_:* = null;
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
         _loc2_ = uint(0);
         while(_loc2_ < 10)
         {
            _loc1_ = new SimpleGameRankItem(_loc2_);
            this._itemList.push(_loc1_);
            this._list.addChild(_loc1_);
            _loc2_++;
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
      
      private function onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("store.view.HelpButtonText"),"ddt.littlegame.rankHelp",410,490,false);
      }
      
      private function onPageChange(param1:Event) : void
      {
         _pageIdx = this._selectPageUI.currentPage;
         this.updateView();
      }
      
      private function __updateView(param1:FunnyGamesEvent) : void
      {
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc1_:int = HappyLittleGameManager.instance.getSelfRank();
         this._noRankTxt.text = _loc1_ == -1?LanguageMgr.GetTranslation("ddt.simpleGameRank.frame.noRank"):(_loc1_ + 1).toString();
         var _loc2_:Vector.<HappyMiniGameRankData> = HappyLittleGameManager.instance.getRankDataList();
         var _loc7_:uint = _loc2_.length / 10;
         if(_loc7_ * 10 < _loc2_.length)
         {
            _loc7_ = _loc7_ + 1;
         }
         this._selectPageUI.maxPage = _loc7_;
         var _loc3_:uint = (this._pageIdx - 1) * 10;
         var _loc6_:uint = this._pageIdx * 10;
         var _loc5_:Vector.<HappyMiniGameRankData> = HappyLittleGameManager.instance.getRankDataList(_loc3_,_loc6_);
         this.clearItemList();
         _loc8_ = 0;
         while(_loc8_ < _loc5_.length)
         {
            if(_loc8_ < this._itemList.length)
            {
               _loc4_ = this._itemList[_loc8_];
               if(_loc4_)
               {
                  _loc4_.data = _loc5_[_loc8_];
               }
            }
            _loc8_++;
         }
      }
      
      private function clearItemList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = this._itemList;
         for each(var _loc1_ in this._itemList)
         {
            if(_loc1_)
            {
               _loc1_.clear();
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
      
      override protected function onResponse(param1:int) : void
      {
         SoundManager.instance.play("008");
         this.dispose();
      }
   }
}
