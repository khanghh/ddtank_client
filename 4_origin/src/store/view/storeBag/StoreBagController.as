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
      
      public function StoreBagController(param1:StoreModel)
      {
         super();
         _model = param1;
      }
      
      public function getView(param1:int) : DisplayObject
      {
         _currentType = param1;
         if(param1 == StoreModel.STORE_BAG)
         {
            _view = ComponentFactory.Instance.creat("ddtstore.StoreBagView");
            _view.setup(this);
            loadList();
            return _view;
         }
         if(param1 == StoreModel.EVOLUTION_BAG)
         {
            _viewII = ComponentFactory.Instance.creat("ddtstore.FineEvolutionBagView");
            _viewII.setup(this);
            loadList();
            return _viewII;
         }
         return null;
      }
      
      public function getPropCell(param1:int) : BagCell
      {
         if(param1 < 0)
         {
            return null;
         }
         return null;
      }
      
      public function getEquipCell(param1:int) : BagCell
      {
         if(param1 < 0)
         {
            return null;
         }
         return null;
      }
      
      public function loadList() : void
      {
         setList(_model);
      }
      
      public function setList(param1:StoreModel) : void
      {
         if(_currentType == StoreModel.STORE_BAG)
         {
            if(_view)
            {
               _view.setData(param1);
            }
         }
         if(_currentType == StoreModel.EVOLUTION_BAG)
         {
            if(_viewII)
            {
               _viewII.setData(param1);
            }
         }
      }
      
      public function changeMsg(param1:int) : void
      {
      }
      
      public function get currentPanel() : int
      {
         return _model.currentPanel;
      }
      
      public function get model() : StoreModel
      {
         return this._model;
      }
      
      public function getEnabled() : Boolean
      {
         return false;
      }
      
      public function setEnabled(param1:Boolean) : void
      {
      }
      
      public function dispose() : void
      {
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         _model = null;
         if(_viewII)
         {
            ObjectUtils.disposeObject(_viewII);
         }
         _viewII = null;
      }
   }
}
