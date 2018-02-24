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
      
      public function ListPanel(){super(null);}
      
      override public function dispose() : void{}
      
      public function set factoryStyle(param1:String) : void{}
      
      public function get list() : List{return null;}
      
      public function get listModel() : IListModel{return null;}
      
      public function set listStyle(param1:String) : void{}
      
      public function get vectorListModel() : VectorListModel{return null;}
      
      override protected function onProppertiesUpdate() : void{}
   }
}
