package braveDoor.view
{
   import BraveDoor.BraveDoorManager;
   import BraveDoor.data.BraveDoorDuplicateInfo;
   import braveDoor.BraveDoorControl;
   import braveDoor.data.BraveDoorListModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BraveDoorView extends Sprite implements Disposeable
   {
       
      
      private var _dmapView:DuplicateMapView = null;
      
      private var _dlistView:DuplicateListView = null;
      
      private var _bg:Bitmap = null;
      
      private var _control:BraveDoorControl;
      
      private var _data:BraveDoorListModel;
      
      public function BraveDoorView(param1:BraveDoorControl, param2:BraveDoorListModel){super();}
      
      protected function initView() : void{}
      
      public function dispose() : void{}
   }
}
