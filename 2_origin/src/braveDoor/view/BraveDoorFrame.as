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
      
      public function BraveDoorFrame(param1:BraveDoorControl, param2:BraveDoorListModel)
      {
         _control = param1;
         _data = param2;
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("game.braveDoor.titleTxt");
         _view = new BraveDoorView(_control,_data);
         if(_view)
         {
            addToContent(_view);
         }
      }
      
      protected function initView() : void
      {
      }
      
      override public function dispose() : void
      {
         if(_control)
         {
            _control.dispose();
         }
         _control = null;
         _data = null;
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
      }
   }
}
