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
      
      public function set factoryStyle(value:String) : void
      {
         if(_factoryStrle == value)
         {
            return;
         }
         _factoryStrle = value;
         var factoryAndArgs:Array = value.split("|");
         var classname:String = factoryAndArgs[0];
         var args:Array = ComponentFactory.parasArgs(factoryAndArgs[1]);
         _factory = ClassUtils.CreatInstance(classname,args);
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
      
      public function set listStyle(stylename:String) : void
      {
         if(_listStyle == stylename)
         {
            return;
         }
         _listStyle = stylename;
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
