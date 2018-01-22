package com.pickgliss.ui.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCellFactory;
   import com.pickgliss.ui.controls.list.IListModel;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.utils.ClassUtils;
   
   public class ListPanel extends ScrollPanel
   {
      
      public static const P_backgound:String = "backgound";
      
      public static const P_backgoundInnerRect:String = "backgoundInnerRect";
      
      public static const P_factory:String = "factory";
       
      
      protected var _factory:IListCellFactory;
      
      protected var _factoryStrle:String;
      
      protected var _listStyle:String;
      
      public function ListPanel()
      {
         super(false);
      }
      
      override public function dispose() : void
      {
         _factory = null;
         super.dispose();
      }
      
      public function set factoryStyle(param1:String) : void
      {
         if(_factoryStrle == param1)
         {
            return;
         }
         _factoryStrle = param1;
         var _loc4_:Array = param1.split("|");
         var _loc3_:String = _loc4_[0];
         var _loc2_:Array = ComponentFactory.parasArgs(_loc4_[1]);
         _factory = ClassUtils.CreatInstance(_loc3_,_loc2_);
         onPropertiesChanged("factory");
      }
      
      public function get list() : List
      {
         return _viewSource as List;
      }
      
      public function get listModel() : IListModel
      {
         return list.model;
      }
      
      public function set listStyle(param1:String) : void
      {
         if(_listStyle == param1)
         {
            return;
         }
         _listStyle = param1;
         viewPort = ComponentFactory.Instance.creat(_listStyle);
      }
      
      public function get vectorListModel() : VectorListModel
      {
         if(list == null)
         {
            return null;
         }
         return list.model as VectorListModel;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["factory"] || _changedPropeties["viewSource"])
         {
            if(list)
            {
               list.cellFactory = _factory;
            }
         }
      }
   }
}
