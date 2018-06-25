package labyrinth.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.events.Event;
   import labyrinth.LabyrinthControl;
   import labyrinth.LabyrinthManager;
   
   public class RankingListFrame extends BaseAlerFrame
   {
       
      
      private var _bg:Bitmap;
      
      private var _rankingTitle:FilterFrameText;
      
      private var _rankingTitleI:FilterFrameText;
      
      private var _rankingTitleII:FilterFrameText;
      
      private var _list:ListPanel;
      
      private var _selectType:int;
      
      public function RankingListFrame(selectType:int = 0)
      {
         _selectType = selectType;
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         var titleName:String = _selectType == 0?LanguageMgr.GetTranslation("ddt.labyrinth.RankingListFrame.title0"):LanguageMgr.GetTranslation("ddt.labyrinth.RankingListFrame.title1");
         var alerInfo:AlertInfo = new AlertInfo(titleName);
         info = alerInfo;
         _bg = ComponentFactory.Instance.creatBitmap("ddt.labyrinth.RankingListFrame.BG");
         addToContent(_bg);
         _rankingTitle = ComponentFactory.Instance.creatComponentByStylename("labyrinth.rankingListFrame.titleText");
         _rankingTitle.text = LanguageMgr.GetTranslation("labyrinth.rankingListFrame.titleText");
         addToContent(_rankingTitle);
         _rankingTitleI = ComponentFactory.Instance.creatComponentByStylename("labyrinth.rankingListFrame.titleTextI");
         _rankingTitleI.text = LanguageMgr.GetTranslation("labyrinth.rankingListFrame.titleTextI");
         addToContent(_rankingTitleI);
         _rankingTitleII = ComponentFactory.Instance.creatComponentByStylename("labyrinth.rankingListFrame.titleTextII");
         _rankingTitleII.text = LanguageMgr.GetTranslation("labyrinth.rankingListFrame.titleTextII");
         addToContent(_rankingTitleII);
         _list = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.RankingListFrame.List");
         addToContent(_list);
         initEvent();
         LabyrinthControl.Instance.loadRankingList(_selectType);
      }
      
      private function initEvent() : void
      {
         LabyrinthControl.Instance.addEventListener("rankingLoadComplete",__updateList);
      }
      
      protected function __updateList(event:Event) : void
      {
         var list:Array = LabyrinthManager.Instance.model.rankingList;
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(list);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      override public function dispose() : void
      {
         LabyrinthControl.Instance.removeEventListener("rankingLoadComplete",__updateList);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rankingTitle);
         _rankingTitle = null;
         ObjectUtils.disposeObject(_rankingTitleI);
         _rankingTitleI = null;
         ObjectUtils.disposeObject(_rankingTitleII);
         _rankingTitleII = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         super.dispose();
      }
   }
}
