package godCardRaise.view
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import godCardRaise.info.GodCardListGroupInfo;
   
   public class GodCardRaiseExchangeLeftView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _list:ListPanel;
      
      private var dataList:Array;
      
      private var _updateFun:Function;
      
      private var _selectedValue:GodCardListGroupInfo;
      
      private var _currentID:int;
      
      public function GodCardRaiseExchangeLeftView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.godCardRaiseExchangeLeftView.bg");
         addChild(_bg);
         _list = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseExchangeLeftView.unitCellList");
         addChild(_list);
      }
      
      private function initEvent() : void
      {
         _list.list.addEventListener("listItemClick",__itemClick);
      }
      
      public function setData(param1:Array, param2:Function) : void
      {
         dataList = param1;
         _updateFun = param2;
         initData();
         _list.list.currentSelectedIndex = 0;
      }
      
      public function initData() : void
      {
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(dataList);
         _list.list.updateListView();
      }
      
      public function updateView() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = null;
         if(_list && _list.list)
         {
            _loc1_ = _list.list.cell;
            var _loc5_:int = 0;
            var _loc4_:* = _loc1_;
            for each(var _loc3_ in _loc1_)
            {
               _loc2_ = _loc3_ as GodCardRaiseExchangeLeftCell;
               _loc2_.updateView();
            }
         }
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         _selectedValue = param1.cellValue as GodCardListGroupInfo;
         if(_selectedValue.GroupID == _currentID)
         {
            return;
         }
         _currentID = _selectedValue.GroupID;
         return;
         §§push(_updateFun(_selectedValue));
      }
      
      private function removeEvent() : void
      {
         if(_list)
         {
            _list.list.removeEventListener("listItemClick",__itemClick);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _list = null;
         dataList = null;
         _updateFun = null;
         _selectedValue = null;
         _currentID = 0;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
