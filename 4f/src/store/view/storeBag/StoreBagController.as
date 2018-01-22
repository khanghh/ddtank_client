package store.view.storeBag
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import store.data.StoreModel;
   import store.fineStore.view.pageBringUp.evolution.FineEvolutionBagView;
   
   public class StoreBagController
   {
       
      
      private var _model:StoreModel;
      
      private var _view:StoreBagView;
      
      private var _viewII:FineEvolutionBagView;
      
      private var _currentType:int;
      
      public function StoreBagController(param1:StoreModel){super();}
      
      public function getView(param1:int) : DisplayObject{return null;}
      
      public function getPropCell(param1:int) : BagCell{return null;}
      
      public function getEquipCell(param1:int) : BagCell{return null;}
      
      public function loadList() : void{}
      
      public function setList(param1:StoreModel) : void{}
      
      public function changeMsg(param1:int) : void{}
      
      public function get currentPanel() : int{return 0;}
      
      public function get model() : StoreModel{return null;}
      
      public function getEnabled() : Boolean{return false;}
      
      public function setEnabled(param1:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
