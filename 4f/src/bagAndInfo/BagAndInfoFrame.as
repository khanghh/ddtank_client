package bagAndInfo
{
   import bagAndInfo.bag.BagView;
   import bagAndInfo.info.PlayerInfoView;
   import beadSystem.beadSystemManager;
   import cardSystem.data.CardInfo;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.CellEvent;
   import ddt.manager.DraftManager;
   import ddt.manager.PlayerManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.Sprite;
   import flash.events.Event;
   import petsBag.PetsBagManager;
   import petsBag.view.PetsBagOutView;
   import playerDress.PlayerDressManager;
   import playerDress.event.PlayerDressEvent;
   import texpSystem.controller.TexpManager;
   
   public class BagAndInfoFrame extends Sprite implements Disposeable
   {
       
      
      private var _info:SelfInfo;
      
      public var _infoView:PlayerInfoView;
      
      public var bagView:BagView;
      
      private var _petsView:PetsBagOutView;
      
      private var _beadInfoView:Sprite;
      
      private var _playerDressView:Sprite;
      
      private var _currentType:int;
      
      private var _visible:Boolean = false;
      
      private var _isFirstOpenBead:Boolean = true;
      
      private var _isLoadBeadComplete:Boolean = false;
      
      private var _isLoadStoreComplete:Boolean = false;
      
      public function BagAndInfoFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      public function set isScreenFood(param1:Boolean) : void{}
      
      public function switchShow(param1:int, param2:int = 0) : void{}
      
      public function clearTexpInfo() : void{}
      
      private function showTexpView() : void{}
      
      private function showPetsView() : void{}
      
      private function __createPets(param1:UIModuleEvent) : void{}
      
      private function __onPetsSmallLoadingClose(param1:Event) : void{}
      
      private function __onPetsUIProgress(param1:UIModuleEvent) : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      private function showPlayerDressView(param1:PlayerDressEvent) : void{}
      
      private function showBeadInfoView() : void{}
      
      private function __onCreateComplete(param1:CEvent) : void{}
      
      private function __stopShine(param1:CellEvent) : void{}
      
      private function __startShine(param1:CellEvent) : void{}
      
      public function dispose() : void{}
      
      public function get info() : SelfInfo{return null;}
      
      public function set info(param1:SelfInfo) : void{}
      
      public function set bagType(param1:int) : void{}
      
      public function show() : void{}
      
      public function get currentType() : int{return 0;}
      
      public function checkGuide() : void{}
   }
}
