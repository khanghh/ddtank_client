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
      
      protected function __prevBtnClick(param1:MouseEvent) : void
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
      
      protected function __nextBtnClick(param1:MouseEvent) : void
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
      
      public function set curPage(param1:int) : void
      {
         _curPage = param1;
         _pageTxt.text = _curPage + "/" + 3;
      }
      
      protected function __onHideView(param1:UpdatePetInfoEvent) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      protected function onUpdatePet(param1:CEvent) : void
      {
         update();
      }
      
      protected function __onPetCellUnlock(param1:UpdatePetInfoEvent) : void
      {
         update();
      }
      
      override protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:* = null;
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
         _loc2_ = _cellTotalCount;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new PetSmallItemButton();
            _loc1_.setButtonStyleName("assets.petsBagCellLock");
            _loc1_.place = _loc3_ + 3;
            _loc1_.x = 30 + _loc3_ % 5 * 79;
            _loc1_.y = 80 + int(_loc3_ / 5) * 95;
            _content.addChild(_loc1_);
            _loc1_.doubleClickEnabled = true;
            _loc1_.addEventListener("doubleClick",onCellDoubleClick);
            _loc1_.addEventListener("click",onClick);
            _cellList.push(_loc1_);
            _loc3_++;
         }
         addEventListener("response",_response);
         update();
      }
      
      private function addBG() : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creat("petsBag.benchBG.bottomBg0");
            _content.addChild(_loc1_);
            _loc2_ = ComponentFactory.Instance.creat("petsBag.benchBG.bottomBg");
            _content.addChild(_loc2_);
            _loc1_.x = 18;
            _loc1_.y = 71 + _loc3_ * 95;
            _loc2_.x = 20;
            _loc2_.y = 73 + _loc3_ * 95;
            _loc3_++;
         }
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:PetSmallItemButton = param1.target as PetSmallItemButton;
         PetsBagManager.instance().onBenchBagPetCellClick(_loc2_.place + _cellTotalCount * (curPage - 1));
      }
      
      protected function onCellDoubleClick(param1:MouseEvent) : void
      {
         var _loc2_:PetSmallItemButton = param1.target as PetSmallItemButton;
         PetsBagManager.instance().onBenchBagPetCellDoubleClick(_loc2_.info);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         updateEmptyCells(0);
         var _loc2_:Array = PetsBagManager.instance().petModel.petsListInBenchBag;
         var _loc1_:int = _cellTotalCount * (curPage - 1);
         _loc4_ = 0;
         while(_loc4_ < _cellTotalCount)
         {
            _loc3_ = _loc4_ + _loc1_;
            if(_loc2_.length > _loc3_)
            {
               _cellList[_loc4_].info = _loc2_[_loc3_];
            }
            else
            {
               _cellList[_loc4_].info = null;
            }
            _loc4_++;
         }
      }
      
      private function updateEmptyCells(param1:int) : void
      {
         var _loc2_:int = PetsBagManager.instance().petModel.unlockedCellNum - _cellTotalCount * (curPage - 1);
         while(param1 < _cellTotalCount)
         {
            if(param1 >= _loc2_)
            {
               _cellList[param1].setButtonStyleName("assets.petsBagCellLock");
            }
            else
            {
               _cellList[param1].setButtonStyleName(null);
            }
            param1++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         removeEventListener("response",_response);
         removeEvents();
         _loc1_ = _cellList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            ObjectUtils.disposeObject(_cellList[_loc2_]);
            _cellList[_loc2_].removeEventListener("doubleClick",onCellDoubleClick);
            _cellList[_loc2_] = null;
            _loc2_++;
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
