package petsBag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   import petsBag.PetsBagManager;
   import petsBag.data.PetAtlasInfo;
   import petsBag.view.item.PetAtlasItemButton;
   import road7th.data.DictionaryData;
   
   public class PetAtlasBagFrame extends Frame
   {
      
      private static const MIN_PAGE:int = 1;
      
      private static const COUNT:int = 15;
       
      
      private var _propertyTextList:Array;
      
      private var _prevBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _currentPage:int = 1;
      
      private var _maxPage:int;
      
      private var _cellList:Vector.<PetAtlasItemButton>;
      
      public function PetAtlasBagFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc10_:int = 0;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc9_:* = null;
         var _loc1_:int = 0;
         var _loc4_:* = null;
         super.init();
         _propertyTextList = [];
         _maxPage = int(PetsBagManager.instance().petModel.petsAtlas.length / 15) || 1;
         titleText = LanguageMgr.GetTranslation("ddt.pets.atlasTitle");
         _loc10_ = 0;
         while(_loc10_ < 3)
         {
            _loc7_ = ComponentFactory.Instance.creat("petsBag.benchBG.bottomBg0");
            addToContent(_loc7_);
            _loc6_ = ComponentFactory.Instance.creat("petsBag.benchBG.bottomBg");
            addToContent(_loc6_);
            _loc7_.x = 22;
            _loc7_.y = 47 + _loc10_ * 98;
            _loc6_.x = _loc7_.x + 2;
            _loc6_.y = _loc7_.y + 2;
            _loc10_++;
         }
         addToContent(ComponentFactory.Instance.creatComponentByStylename("petsBag.atlas.propertyBg"));
         var _loc3_:Array = LanguageMgr.GetTranslation("ddt.pets.propertyStr").split(",");
         _loc8_ = 0;
         while(_loc8_ < 4)
         {
            _loc5_ = ComponentFactory.Instance.creat("petsBag.atlas.propertyCellBg");
            _loc2_ = ComponentFactory.Instance.creat("petsBag.text.propName");
            _loc2_.text = _loc3_[_loc8_];
            _loc9_ = ComponentFactory.Instance.creat("petsBag.text.propValue");
            _propertyTextList.push(_loc9_);
            addToContent(_loc5_);
            addToContent(_loc2_);
            addToContent(_loc9_);
            PositionUtils.setPos(_loc2_,"petsBag.atlasPropertyPos" + _loc8_);
            _loc5_.x = _loc2_.x + 42;
            _loc5_.y = _loc2_.y - 2;
            _loc9_.x = _loc5_.x - 22;
            _loc9_.y = _loc5_.y + 3;
            _loc8_++;
         }
         _prevBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.benchBag.prevBtn");
         PositionUtils.setPos(_prevBtn,"petsBag.atlas.prevBtnPos");
         addToContent(_prevBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.benchBag.nextBtn");
         PositionUtils.setPos(_nextBtn,"petsBag.atlas.nextBtnPos");
         addToContent(_nextBtn);
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("petsBag.benchBag.pageBG");
         PositionUtils.setPos(_pageBg,"petsBag.atlas.pageTextPos");
         addToContent(_pageBg);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.benchBag.pageTxt");
         PositionUtils.setPos(_pageTxt,"petsBag.atlas.pageBgPos");
         addToContent(_pageTxt);
         _cellList = new Vector.<PetAtlasItemButton>();
         _loc1_ = 0;
         while(_loc1_ < 15)
         {
            _loc4_ = new PetAtlasItemButton();
            _loc4_.setButtonStyleName("assets.petsBagCellLock");
            _loc4_.x = 34 + _loc1_ % 5 * 79;
            _loc4_.y = 55 + int(_loc1_ / 5) * 98;
            _cellList.push(_loc4_);
            addToContent(_loc4_);
            _loc1_++;
         }
         updateView();
         updateProperty();
         addEvent();
      }
      
      private function updateProperty() : void
      {
         var _loc3_:Array = [0,0,0,0];
         var _loc2_:DictionaryData = PetsBagManager.instance().petModel.getActivatePetAtlas();
         var _loc4_:DictionaryData = PetsBagManager.instance().petModel.petsAtlas;
         var _loc8_:int = 0;
         var _loc7_:* = _loc4_;
         for each(var _loc1_ in _loc4_)
         {
            if(_loc2_.hasKey(_loc1_.ID))
            {
               var _loc5_:* = 0;
               var _loc6_:* = _loc3_[_loc5_] + _loc1_.Attack;
               _loc3_[_loc5_] = _loc6_;
               _loc6_ = 1;
               _loc5_ = _loc3_[_loc6_] + _loc1_.Defence;
               _loc3_[_loc6_] = _loc5_;
               _loc5_ = 2;
               _loc6_ = _loc3_[_loc5_] + _loc1_.Agility;
               _loc3_[_loc5_] = _loc6_;
               _loc6_ = 3;
               _loc5_ = _loc3_[_loc6_] + _loc1_.Lucky;
               _loc3_[_loc6_] = _loc5_;
            }
         }
         _propertyTextList[0].text = _loc3_[0];
         _propertyTextList[1].text = _loc3_[1];
         _propertyTextList[2].text = _loc3_[2];
         _propertyTextList[3].text = _loc3_[3];
      }
      
      private function addEvent() : void
      {
         _prevBtn.addEventListener("click",__pageBtnClick);
         _nextBtn.addEventListener("click",__pageBtnClick);
      }
      
      private function removeEvent() : void
      {
         _prevBtn.removeEventListener("click",__pageBtnClick);
         _nextBtn.removeEventListener("click",__pageBtnClick);
      }
      
      private function __pageBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_maxPage <= 1)
         {
            return;
         }
         var _loc2_:* = param1.currentTarget;
         if(_prevBtn !== _loc2_)
         {
            if(_nextBtn === _loc2_)
            {
               _currentPage = _currentPage + 1;
               if(_currentPage + 1 > _maxPage)
               {
                  _currentPage = 1;
               }
               updateView();
            }
         }
         else
         {
            _currentPage = _currentPage - 1;
            if(_currentPage - 1 < 1)
            {
               _currentPage = _maxPage;
            }
            updateView();
         }
      }
      
      private function updateView() : void
      {
         var _loc1_:int = 0;
         _pageTxt.text = _currentPage + "/" + _maxPage;
         var _loc2_:DictionaryData = PetsBagManager.instance().petModel.getActivatePetAtlas();
         var _loc3_:Vector.<PetAtlasInfo> = PetsBagManager.instance().petModel.getPetAtlasSorted(_currentPage);
         _loc1_ = 0;
         while(_loc1_ < 15)
         {
            if(_loc3_[_loc1_])
            {
               _cellList[_loc1_].setAtlasInfo(_loc3_[_loc1_],_loc2_[_loc3_[_loc1_].ID]);
            }
            else
            {
               _cellList[_loc1_].setAtlasInfo(null,null);
            }
            _loc1_++;
         }
      }
      
      override protected function onResponse(param1:int) : void
      {
         super.onResponse(param1);
         if(param1 == 1 || param1 == 0)
         {
            SoundManager.instance.playButtonSound();
            ObjectUtils.disposeObject(this);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _cellList = null;
      }
   }
}
