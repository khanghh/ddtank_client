package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PetInfoManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import pet.data.PetTemplateInfo;
   import petsBag.PetsBagManager;
   import petsBag.data.PetStarExpData;
   import petsBag.petsAdvanced.event.PetsAdvancedEvent;
   import petsBag.view.item.StarBar;
   import road7th.comm.PackageIn;
   
   public class PetsRisingStarView extends PetsAdvancedView
   {
       
      
      private var _starBar:StarBar;
      
      private var _maxStarTxt:FilterFrameText;
      
      private var _helpTxt1:FilterFrameText;
      
      private var _helpTxt2:FilterFrameText;
      
      private var _helpTxt3:FilterFrameText;
      
      private var _petStarInfo:PetStarExpData;
      
      private var _oldPropArr:Array;
      
      private var _oldGrowArr:Array;
      
      private var _propLevelArr_one:Array;
      
      private var _propLevelArr_two:Array;
      
      private var _propLevelArr_three:Array;
      
      private var _growLevelArr_one:Array;
      
      private var _growLevelArr_two:Array;
      
      private var _growLevelArr_three:Array;
      
      public function PetsRisingStarView(){super(null);}
      
      override protected function initView() : void{}
      
      override protected function initData() : void{}
      
      private function updateData() : void{}
      
      private function getAddedPropArr(param1:int, param2:Array) : Array{return null;}
      
      override protected function __enterFrame(param1:Event) : void{}
      
      private function updateView() : void{}
      
      override protected function addEvent() : void{}
      
      protected function __risingStarHandler(param1:PkgEvent) : void{}
      
      override protected function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
