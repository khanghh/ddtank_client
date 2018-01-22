package braveDoor.view
{
   import braveDoor.BraveDoorControl;
   import braveDoor.data.BraveDoorListModel;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   
   public class BraveDoorFrame extends Frame implements Disposeable
   {
       
      
      private var _control:BraveDoorControl;
      
      private var _data:BraveDoorListModel;
      
      private var _view:BraveDoorView;
      
      public function BraveDoorFrame(param1:BraveDoorControl, param2:BraveDoorListModel){super();}
      
      override protected function init() : void{}
      
      protected function initView() : void{}
      
      override public function dispose() : void{}
   }
}
