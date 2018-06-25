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
      
      public function BraveDoorView(control:BraveDoorControl, model:BraveDoorListModel)
      {
         _control = control;
         _data = model;
         super();
         initView();
      }
      
      protected function initView() : void
      {
         if(_dmapView != null)
         {
            ObjectUtils.disposeObject(_dmapView);
            _dmapView = null;
         }
         if(_dlistView != null)
         {
            ObjectUtils.disposeObject(_dlistView);
            _dlistView = null;
         }
         _bg = ComponentFactory.Instance.creatBitmap("asset.braveDoor.bgIcon");
         addChild(_bg);
         var info:Vector.<BraveDoorDuplicateInfo> = BraveDoorManager.instance.getDuplicateTemInfo();
         var page:int = BraveDoorManager.instance.currentPage;
         _dmapView = ComponentFactory.Instance.creatCustomObject("ddt.braveDoor.duplicateMapView");
         _dmapView.initView(_control,info[page]);
         _dlistView = ComponentFactory.Instance.creatCustomObject("ddt.braveDoor.DuplicateListView");
         _dlistView.initView(_control,_data);
         addChild(_dmapView);
         addChild(_dlistView);
      }
      
      public function dispose() : void
      {
         _control = null;
         _data = null;
         if(_dmapView)
         {
            ObjectUtils.disposeObject(_dmapView);
         }
         _dmapView = null;
         if(_dlistView)
         {
            ObjectUtils.disposeObject(_dlistView);
         }
         _dlistView = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
      }
   }
}
