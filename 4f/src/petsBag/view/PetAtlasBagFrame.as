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
      
      public function PetAtlasBagFrame(){super();}
      
      override protected function init() : void{}
      
      private function updateProperty() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __pageBtnClick(param1:MouseEvent) : void{}
      
      private function updateView() : void{}
      
      override protected function onResponse(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
