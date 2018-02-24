package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import pet.data.PetInfo;
   import petsBag.petsAdvanced.event.PetsAdvancedEvent;
   import petsBag.view.item.PetBigItem;
   import petsBag.view.item.StarBar;
   
   public class PetsBasicInfoView extends Sprite implements Disposeable
   {
       
      
      private var _petName:FilterFrameText;
      
      private var _starBar:StarBar;
      
      private var _lv:Bitmap;
      
      private var _lvTxt:FilterFrameText;
      
      private var _petBigItem:PetBigItem;
      
      private var _advancedMc:MovieClip;
      
      private var _times:int = 0;
      
      public function PetsBasicInfoView(){super();}
      
      private function addEvent() : void{}
      
      protected function __movieHandler(param1:PetsAdvancedEvent) : void{}
      
      protected function __enterFrame(param1:Event) : void{}
      
      private function initView() : void{}
      
      public function setInfo(param1:PetInfo) : void{}
      
      public function updateStar(param1:int) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
