package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import flash.display.Sprite;
   import flash.geom.Point;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   
   public class TofflistOrderList extends Sprite implements Disposeable
   {
       
      
      private var _currenItem:TofflistOrderItem;
      
      private var _items:Vector.<TofflistOrderItem>;
      
      private var _list:VBox;
      
      public function TofflistOrderList()
      {
         super();
         init();
         addEvent();
      }
      
      public function dispose() : void
      {
         clearList();
         _items = null;
         ObjectUtils.disposeObject(_currenItem);
         _currenItem = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
      }
      
      public function items($list:Array, page:int = 1) : void
      {
         var i:int = 0;
         var item:* = null;
         var currentItem:* = null;
         clearList();
         if(!$list || $list.length == 0)
         {
            return;
         }
         var length:int = $list.length > page * 8?page * 8:$list.length;
         for(i = (page - 1) * 8; i < length; )
         {
            item = ComponentFactory.Instance.creatCustomObject("tofflist.orderItem");
            item.index = i + 1;
            item.info = $list[i];
            _list.addChild(item);
            _items.push(item);
            if(TofflistModel.firstMenuType == "teams" || TofflistModel.firstMenuType == "crossServerTeams")
            {
               item.addEventListener("tofflistitemselect",__itemChange2);
            }
            else
            {
               item.addEventListener("tofflistitemselect",__itemChange);
            }
            i++;
         }
         if(_list.getChildAt(0) is TofflistOrderItem)
         {
            currentItem = _list.getChildAt(0) as TofflistOrderItem;
            currentItem.isSelect = true;
         }
         else
         {
            TofflistModel.currentText = "";
            TofflistModel.currentIndex = 0;
            TofflistModel.currentPlayerInfo = null;
         }
      }
      
      protected function __itemChange2(evt:TofflistEvent) : void
      {
         if(_currenItem)
         {
            _currenItem.isSelect = false;
         }
         _currenItem = evt.data as TofflistOrderItem;
         TofflistModel.currentIndex = _currenItem.index;
         TofflistModel.currentTeamInfo = _currenItem.teamRankinfo;
      }
      
      public function showHline(points:Vector.<Point>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var item in _items)
         {
            item.showHLine(points);
         }
      }
      
      private function __itemChange(evt:TofflistEvent) : void
      {
         if(_currenItem)
         {
            _currenItem.isSelect = false;
         }
         _currenItem = evt.data as TofflistOrderItem;
         TofflistModel.currentConsortiaInfo = _currenItem.consortiaInfo;
         TofflistModel.currentText = _currenItem.currentText;
         TofflistModel.currentIndex = _currenItem.index;
         TofflistModel.mountsLevelInfo = _currenItem.MountsLevel;
         TofflistModel.currentPlayerInfo = _currenItem.info as PlayerInfo;
      }
      
      private function addEvent() : void
      {
      }
      
      public function clearList() : void
      {
         var i:int = 0;
         var item:* = null;
         for(i = 0; i < _items.length; )
         {
            item = _items[i] as TofflistOrderItem;
            item.removeEventListener("tofflistitemselect",__itemChange);
            ObjectUtils.disposeObject(item);
            item = null;
            i++;
         }
         _items = new Vector.<TofflistOrderItem>();
         _currenItem = null;
         TofflistModel.currentText = "";
         TofflistModel.currentIndex = 0;
         TofflistModel.currentPlayerInfo = null;
      }
      
      private function init() : void
      {
         _list = ComponentFactory.Instance.creatComponentByStylename("tofflist.orderlist.vboxContainer");
         addChild(_list);
         _items = new Vector.<TofflistOrderItem>();
      }
   }
}
