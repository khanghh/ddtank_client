package petsBag.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import petsBag.PetsBagManager;
   import petsBag.event.UpdatePetInfoEvent;
   import petsBag.view.item.PetSmallItemButton;
   
   public class PetBenchBagView extends Frame implements Disposeable
   {
      
      private static const PAGE_COUNT:int = 3;
       
      
      private var _cellList:Vector.<PetSmallItemButton>;
      
      private var _detailTxt:FilterFrameText;
      
      private var _cellTotalCount:Number = 20;
      
      private var _content:Sprite;
      
      private var _pageSp:Sprite;
      
      private var _prevBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _curPage:int;
      
      public function PetBenchBagView()
      {
         super();
         addEvents();
      }
      
      private function addEvents() : void
      {
         PetsBagManager.instance().addEventListener("ptm_unlock_update",__onPetCellUnlock);
         PlayerManager.Instance.addEventListener("updatePet",onUpdatePet);
         PetsBagManager.instance().addEventListener("petsBagHideView",__onHideView);
         _prevBtn.addEventListener("click",__prevBtnClick);
         _nextBtn.addEventListener("click",__nextBtnClick);
      }
      
      private function removeEvents() : void
      {
         PetsBagManager.instance().removeEventListener("ptm_unlock_update",__onPetCellUnlock);
         PlayerManager.Instance.removeEventListener("updatePet",onUpdatePet);
         PetsBagManager.instance().removeEventListener("petsBagHideView",__onHideView);
         _prevBtn.removeEventListener("click",__prevBtnClick);
         _nextBtn.removeEventListener("click",__nextBtnClick);
      }
      
      protected function __prevBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(curPage > 1)
         {
            curPage = Number(curPage) - 1;
         }
         else
         {
            curPage = 3;
         }
         update();
      }
      
      protected function __nextBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(curPage < 3)
         {
            curPage = Number(curPage) + 1;
         }
         else
         {
            curPage = 1;
         }
         update();
      }
      
      public function get curPage() : int
      {
         return _curPage;
      }
      
      public function set curPage(value:int) : void
      {
         _curPage = value;
         _pageTxt.text = _curPage + "/" + 3;
      }
      
      protected function __onHideView(event:UpdatePetInfoEvent) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      protected function onUpdatePet(e:CEvent) : void
      {
         update();
      }
      
      protected function __onPetCellUnlock(e:UpdatePetInfoEvent) : void
      {
         update();
      }
      
      override protected function init() : void
      {
         var len:int = 0;
         var i:int = 0;
         var cell:* = null;
         super.init();
         titleText = LanguageMgr.GetTranslation("ddt.pets.bench.bag.titleTxt");
         _content = new Sprite();
         PositionUtils.setPos(_content,"petsBagView.bagViewContentPos");
         addToContent(_content);
         _pageSp = new Sprite();
         PositionUtils.setPos(_pageSp,"petsBagView.bagViewPagePos");
         addToContent(_pageSp);
         _prevBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.benchBag.prevBtn");
         _pageSp.addChild(_prevBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.benchBag.nextBtn");
         _pageSp.addChild(_nextBtn);
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("petsBag.benchBag.pageBG");
         _pageSp.addChild(_pageBg);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.benchBag.pageTxt");
         _pageSp.addChild(_pageTxt);
         curPage = 1;
         addBG();
         _detailTxt = ComponentFactory.Instance.creat("benchBag.detailText");
         _detailTxt.text = LanguageMgr.GetTranslation("ddt.pets.bench.bag.detail");
         addToContent(_detailTxt);
         _cellList = new Vector.<PetSmallItemButton>();
         len = _cellTotalCount;
         for(i = 0; i < len; )
         {
            cell = new PetSmallItemButton();
            cell.setButtonStyleName("assets.petsBagCellLock");
            cell.place = i + 3;
            cell.x = 30 + i % 5 * 79;
            cell.y = 80 + int(i / 5) * 95;
            _content.addChild(cell);
            cell.doubleClickEnabled = true;
            cell.addEventListener("doubleClick",onCellDoubleClick);
            cell.addEventListener("click",onClick);
            _cellList.push(cell);
            i++;
         }
         addEventListener("response",_response);
         update();
      }
      
      private function addBG() : void
      {
         var _petBg:* = null;
         var _petBg2:* = null;
         var _petBg0:* = null;
         var i:int = 0;
         for(i = 0; i < 4; )
         {
            _petBg0 = ComponentFactory.Instance.creat("petsBag.benchBG.bottomBg0");
            _content.addChild(_petBg0);
            _petBg2 = ComponentFactory.Instance.creat("petsBag.benchBG.bottomBg");
            _content.addChild(_petBg2);
            _petBg0.x = 18;
            _petBg0.y = 71 + i * 95;
            _petBg2.x = 20;
            _petBg2.y = 73 + i * 95;
            i++;
         }
      }
      
      protected function onClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var btn:PetSmallItemButton = e.target as PetSmallItemButton;
         PetsBagManager.instance().onBenchBagPetCellClick(btn.place + _cellTotalCount * (curPage - 1));
      }
      
      protected function onCellDoubleClick(e:MouseEvent) : void
      {
         var btn:PetSmallItemButton = e.target as PetSmallItemButton;
         PetsBagManager.instance().onBenchBagPetCellDoubleClick(btn.info);
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            close();
         }
      }
      
      private function close() : void
      {
         SoundManager.instance.play("008");
         ObjectUtils.disposeObject(this);
      }
      
      public function update() : void
      {
         var i:int = 0;
         var len:int = 0;
         updateEmptyCells(0);
         var list:Array = PetsBagManager.instance().petModel.petsListInBenchBag;
         var index:int = _cellTotalCount * (curPage - 1);
         for(i = 0; i < _cellTotalCount; )
         {
            len = i + index;
            if(list.length > len)
            {
               _cellList[i].info = list[len];
            }
            else
            {
               _cellList[i].info = null;
            }
            i++;
         }
      }
      
      private function updateEmptyCells(i:int) : void
      {
         var cellUnlockNum:int = PetsBagManager.instance().petModel.unlockedCellNum - _cellTotalCount * (curPage - 1);
         while(i < _cellTotalCount)
         {
            if(i >= cellUnlockNum)
            {
               _cellList[i].setButtonStyleName("assets.petsBagCellLock");
            }
            else
            {
               _cellList[i].setButtonStyleName(null);
            }
            i++;
         }
      }
      
      override public function dispose() : void
      {
         var len:int = 0;
         var i:int = 0;
         removeEventListener("response",_response);
         removeEvents();
         len = _cellList.length;
         for(i = 0; i < len; )
         {
            ObjectUtils.disposeObject(_cellList[i]);
            _cellList[i].removeEventListener("doubleClick",onCellDoubleClick);
            _cellList[i] = null;
            i++;
         }
         _cellList.length = 0;
         _cellList = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeAllChildren(_pageSp);
         ObjectUtils.disposeObject(_pageSp);
         _pageSp = null;
         super.dispose();
      }
   }
}
