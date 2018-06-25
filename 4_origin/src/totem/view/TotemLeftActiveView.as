package totem.view
{
   import ddt.events.CEvent;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import totem.TotemManager;
   import totem.data.TotemDataVo;
   import totem.mornUI.TotemLeftActiveViewUI;
   
   public class TotemLeftActiveView extends TotemLeftActiveViewUI
   {
       
      
      private var _windowView:TotemLeftWindowActiveView;
      
      private var _tabIndex:int = -1;
      
      private var _chapterIcon:TotemItemTabView;
      
      public function TotemLeftActiveView()
      {
         super();
         initData();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _windowView = new TotemLeftWindowActiveView();
         PositionUtils.setPos(_windowView,"totem.leftWindowActiveViewPos");
         addChild(_windowView);
         _chapterIcon = new TotemItemTabView(PlayerManager.Instance.Self,2);
         PositionUtils.setPos(_chapterIcon,"totem.leftView.chapterBgPos");
         addChild(_chapterIcon);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(_chapterIcon)
         {
            _chapterIcon.addEventListener("changeChapter",__changeChapterHandler);
         }
      }
      
      protected function __changeChapterHandler(evt:CEvent) : void
      {
         var temIndex:int = evt.data;
         showPage(temIndex);
      }
      
      protected function initData() : void
      {
         var tmpNextInfo:TotemDataVo = TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId);
         _tabIndex = !tmpNextInfo?5:tmpNextInfo.Page;
         _chapterIcon.selectedPage = _tabIndex;
         _chapterIcon.curTotemPagePrecess = _tabIndex;
         showPage(_tabIndex);
      }
      
      protected function showPage(index:int) : void
      {
         _windowView.show(index,TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId),true);
      }
      
      public function refreshView(isSuccess:Boolean) : void
      {
         var nextInfo:* = null;
         var nextInfo2:* = null;
         if(isSuccess)
         {
            nextInfo = TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId);
            if(nextInfo && nextInfo.Page != 1 && nextInfo.Layers == 1 && nextInfo.Location == 1)
            {
               _windowView.refreshView(nextInfo,openSuccessAutoNextPage);
            }
            else
            {
               _windowView.refreshView(nextInfo);
            }
            if(nextInfo)
            {
               _chapterIcon.updateTipsByChapterID(nextInfo.Page);
            }
         }
         else
         {
            nextInfo2 = TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId);
            _windowView.openFailHandler(nextInfo2);
         }
      }
      
      private function openSuccessAutoNextPage() : void
      {
         _tabIndex = Number(_tabIndex) + 1;
         _chapterIcon.selectedPage = _tabIndex;
         _chapterIcon.curTotemPagePrecess = _tabIndex;
         showPage(_tabIndex);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_chapterIcon)
         {
            _chapterIcon.removeEventListener("changeChapter",__changeChapterHandler);
            _chapterIcon.dispose();
         }
         _chapterIcon = null;
         if(_windowView)
         {
            _windowView.dispose();
         }
         _windowView = null;
      }
   }
}
