package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CEvent;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import totem.TotemManager;
   import totem.data.TotemChapterTipInfo;
   
   public class TotemItemTabView extends Sprite implements Disposeable
   {
      
      public static const CHANGE_CHAPTER:String = "changeChapter";
      
      private static const MAX_ITEM:int = 5;
      
      private static const EFF_OFFSETY:int = 0;
      
      private static const TAB_SPACING:int = 70;
      
      public static const BAG:int = 2;
      
      public static const Search:int = 1;
       
      
      private var _chaptersSpri:Sprite;
      
      private var _borEff:Bitmap;
      
      private var _oldPage:int = -1;
      
      private var _chapters:Array;
      
      private var _isSelf:Boolean = false;
      
      private var _playerInfo:PlayerInfo;
      
      private var _fromType:int = -1;
      
      public function TotemItemTabView(playerInfo:PlayerInfo, fromType:*)
      {
         _playerInfo = playerInfo;
         _fromType = fromType;
         _isSelf = _playerInfo == null?false:Boolean(_playerInfo.isSelf);
         super();
         initView();
         addEvent();
      }
      
      protected function initView() : void
      {
         var index:int = 0;
         _chapters = [];
         _chaptersSpri = new Sprite();
         addChild(_chaptersSpri);
         _borEff = ComponentFactory.Instance.creat("asset.totem.leftView.cellSelectedEff");
         for(index = 1; index <= 5; )
         {
            createChapter(index);
            index++;
         }
         if(_isSelf && _fromType == 2)
         {
            _chaptersSpri.addChild(_borEff);
         }
      }
      
      private function addEvent() : void
      {
         TotemManager.instance.addEventListener("updateUpGrade",__updateChapterTip);
      }
      
      private function removeEvent() : void
      {
         TotemManager.instance.removeEventListener("updateUpGrade",__updateChapterTip);
      }
      
      private function set curItem(index:int) : void
      {
         var yOffset:int = -12;
         var xOffset:int = (index - 1) * 70 - 10;
         setBorPos(xOffset,yOffset);
      }
      
      public function set selectedPage(page:int) : void
      {
         _borEff.visible = page > 0;
         curItem = page;
      }
      
      public function set curTotemPagePrecess(page:int) : void
      {
         var temChapter:* = null;
         var index:int = 0;
         if(_chapters && _chapters.length > 0)
         {
            for(index = 0; index < _chapters.length; )
            {
               temChapter = _chapters[index] as TotemLeftWindowChapterIcon;
               if(temChapter.page > page)
               {
                  temChapter.disable = true;
               }
               else
               {
                  temChapter.disable = false;
               }
               index++;
            }
         }
      }
      
      private function setBorPos($x:int, $y:int) : void
      {
         _borEff.y = $y;
         _borEff.x = $x;
      }
      
      protected function createChapter(chapterId:int) : void
      {
         var chapter:TotemLeftWindowChapterIcon = new TotemLeftWindowChapterIcon(chapterId,_playerInfo,_fromType);
         chapter.x = (chapterId - 1) * 70;
         chapter.y = 0;
         chapter.addEventListener("click",__chapterClickHandler);
         chapter.tipData = createTipInfo(chapterId);
         _chaptersSpri.addChild(chapter);
         _chapters.push(chapter);
      }
      
      private function __updateChapterTip(evt:CEvent) : void
      {
         var chapterID:int = evt.data;
         updateTipsByChapterID(chapterID);
      }
      
      public function updateTipsByChapterID(chapterID:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _chapters;
         for each(var chapter in _chapters)
         {
            if(chapter.page == chapterID)
            {
               chapter.tipData = createTipInfo(chapterID);
               chapter.updateQuality();
            }
         }
      }
      
      private function createTipInfo(chapterID:int) : TotemChapterTipInfo
      {
         var info:TotemChapterTipInfo = new TotemChapterTipInfo();
         info.totemId = _playerInfo.totemId;
         info.chapterId = chapterID;
         info.grade = !!_isSelf?getSelfTotemGrade(chapterID):int(getOtherTotemGrade(chapterID));
         return info;
      }
      
      private function getSelfTotemGrade(chapterID:int) : int
      {
         return TotemManager.instance.getGradeByTotemPage(chapterID);
      }
      
      private function getOtherTotemGrade(chapterID:int) : int
      {
         return _playerInfo.getTotemGradeByID(chapterID);
      }
      
      private function __chapterClickHandler(evt:MouseEvent) : void
      {
         var temIndex:int = 0;
         if(!_isSelf || _fromType == 1)
         {
            return;
         }
         SoundManager.instance.playButtonSound();
         var selectedtem:TotemLeftWindowChapterIcon = evt.currentTarget as TotemLeftWindowChapterIcon;
         if(selectedtem)
         {
            temIndex = selectedtem.page;
            if(temIndex == _oldPage)
            {
               return;
            }
            selectedPage = temIndex;
            _oldPage = temIndex;
            dispatchEvent(new CEvent("changeChapter",temIndex));
         }
      }
      
      public function dispose() : void
      {
         var temChapter:* = null;
         while(_chapters.length > 0)
         {
            temChapter = _chapters.shift() as TotemLeftWindowChapterIcon;
            if(temChapter)
            {
               temChapter.removeEventListener("click",__chapterClickHandler);
            }
            ObjectUtils.disposeObject(temChapter);
         }
         ObjectUtils.disposeAllChildren(_chaptersSpri);
         _chaptersSpri = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _chaptersSpri = null;
      }
   }
}
