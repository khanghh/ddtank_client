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
      
      public function StoreBagController(model:StoreModel)
      {
         super();
         _model = model;
      }
      
      public function getView(index:int) : DisplayObject
      {
         _currentType = index;
         if(index == StoreModel.STORE_BAG)
         {
            _view = ComponentFactory.Instance.creat("ddtstore.StoreBagView");
            _view.setup(this);
            loadList();
            return _view;
         }
         if(index == StoreModel.EVOLUTION_BAG)
         {
            _viewII = ComponentFactory.Instance.creat("ddtstore.FineEvolutionBagView");
            _viewII.setup(this);
            loadList();
            return _viewII;
         }
         return null;
      }
      
      public function getPropCell(pos:int) : BagCell
      {
         if(pos < 0)
         {
            return null;
         }
         return null;
      }
      
      public function getEquipCell(pos:int) : BagCell
      {
         if(pos < 0)
         {
            return null;
         }
         return null;
      }
      
      public function loadList() : void
      {
         setList(_model);
      }
      
      public function setList(storeModel:StoreModel) : void
      {
         if(_currentType == StoreModel.STORE_BAG)
         {
            if(_view)
            {
               _view.setData(storeModel);
            }
         }
         if(_currentType == StoreModel.EVOLUTION_BAG)
         {
            if(_viewII)
            {
               _viewII.setData(storeModel);
            }
         }
      }
      
      public function changeMsg(msg:int) : void
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
      
      public function setEnabled(value:Boolean) : void
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
