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
         var i:int = 0;
         var bg1:* = null;
         var bg2:* = null;
         var j:int = 0;
         var cellBg:* = null;
         var text:* = null;
         var propertyText:* = null;
         var v:int = 0;
         var cell:* = null;
         super.init();
         _propertyTextList = [];
         _maxPage = int(PetsBagManager.instance().petModel.petsAtlas.length / 15) || 1;
         titleText = LanguageMgr.GetTranslation("ddt.pets.atlasTitle");
         for(i = 0; i < 3; )
         {
            bg1 = ComponentFactory.Instance.creat("petsBag.benchBG.bottomBg0");
            addToContent(bg1);
            bg2 = ComponentFactory.Instance.creat("petsBag.benchBG.bottomBg");
            addToContent(bg2);
            bg1.x = 22;
            bg1.y = 47 + i * 98;
            bg2.x = bg1.x + 2;
            bg2.y = bg1.y + 2;
            i++;
         }
         addToContent(ComponentFactory.Instance.creatComponentByStylename("petsBag.atlas.propertyBg"));
         var propertyStr:Array = LanguageMgr.GetTranslation("ddt.pets.propertyStr").split(",");
         for(j = 0; j < 4; )
         {
            cellBg = ComponentFactory.Instance.creat("petsBag.atlas.propertyCellBg");
            text = ComponentFactory.Instance.creat("petsBag.text.propName");
            text.text = propertyStr[j];
            propertyText = ComponentFactory.Instance.creat("petsBag.text.propValue");
            _propertyTextList.push(propertyText);
            addToContent(cellBg);
            addToContent(text);
            addToContent(propertyText);
            PositionUtils.setPos(text,"petsBag.atlasPropertyPos" + j);
            cellBg.x = text.x + 42;
            cellBg.y = text.y - 2;
            propertyText.x = cellBg.x - 22;
            propertyText.y = cellBg.y + 3;
            j++;
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
         for(v = 0; v < 15; )
         {
            cell = new PetAtlasItemButton();
            cell.setButtonStyleName("assets.petsBagCellLock");
            cell.x = 34 + v % 5 * 79;
            cell.y = 55 + int(v / 5) * 98;
            _cellList.push(cell);
            addToContent(cell);
            v++;
         }
         updateView();
         updateProperty();
         addEvent();
      }
      
      private function updateProperty() : void
      {
         var addProperty:Array = [0,0,0,0];
         var data:DictionaryData = PetsBagManager.instance().petModel.getActivatePetAtlas();
         var list:DictionaryData = PetsBagManager.instance().petModel.petsAtlas;
         var _loc8_:int = 0;
         var _loc7_:* = list;
         for each(var item in list)
         {
            if(data.hasKey(item.ID))
            {
               var _loc5_:* = 0;
               var _loc6_:* = addProperty[_loc5_] + item.Attack;
               addProperty[_loc5_] = _loc6_;
               _loc6_ = 1;
               _loc5_ = addProperty[_loc6_] + item.Defence;
               addProperty[_loc6_] = _loc5_;
               _loc5_ = 2;
               _loc6_ = addProperty[_loc5_] + item.Agility;
               addProperty[_loc5_] = _loc6_;
               _loc6_ = 3;
               _loc5_ = addProperty[_loc6_] + item.Lucky;
               addProperty[_loc6_] = _loc5_;
            }
         }
         _propertyTextList[0].text = addProperty[0];
         _propertyTextList[1].text = addProperty[1];
         _propertyTextList[2].text = addProperty[2];
         _propertyTextList[3].text = addProperty[3];
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
      
      private function __pageBtnClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_maxPage <= 1)
         {
            return;
         }
         var _loc2_:* = e.currentTarget;
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
         var v:int = 0;
         _pageTxt.text = _currentPage + "/" + _maxPage;
         var data:DictionaryData = PetsBagManager.instance().petModel.getActivatePetAtlas();
         var list:Vector.<PetAtlasInfo> = PetsBagManager.instance().petModel.getPetAtlasSorted(_currentPage);
         for(v = 0; v < 15; )
         {
            if(list[v])
            {
               _cellList[v].setAtlasInfo(list[v],data[list[v].ID]);
            }
            else
            {
               _cellList[v].setAtlasInfo(null,null);
            }
            v++;
         }
      }
      
      override protected function onResponse(type:int) : void
      {
         super.onResponse(type);
         if(type == 1 || type == 0)
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
