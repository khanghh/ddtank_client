package petsBag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PetExperience;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   
   public class PetFoodNumberSelectFrame extends BaseAlerFrame
   {
       
      
      private var _foodInfo:InventoryItemInfo;
      
      private var _alertInfo:AlertInfo;
      
      private var _petInfo:PetInfo;
      
      private var _numberSelecter:NumberSelecter;
      
      private var _text:FilterFrameText;
      
      private var _needFoodText:FilterFrameText;
      
      private var maxFood:int = 0;
      
      private var neededFoodAmount:int;
      
      public function PetFoodNumberSelectFrame(){super();}
      
      public function set petInfo(param1:PetInfo) : void{}
      
      public function set foodInfo(param1:InventoryItemInfo) : void{}
      
      public function get foodInfo() : InventoryItemInfo{return null;}
      
      public function get amount() : int{return 0;}
      
      private function initView() : void{}
      
      private function __seleterChange(param1:Event) : void{}
      
      public function show(param1:int, param2:int = 1) : void{}
      
      private function needMaxFood(param1:int, param2:int) : int{return 0;}
      
      override public function dispose() : void{}
      
      private function removeView() : void{}
   }
}
