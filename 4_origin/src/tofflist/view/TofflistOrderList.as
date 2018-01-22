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
      
      public function items(param1:Array, param2:int = 1) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         clearList();
         if(!param1 || param1.length == 0)
         {
            return;
         }
         var _loc4_:int = param1.length > param2 * 8?param2 * 8:param1.length;
         _loc6_ = (param2 - 1) * 8;
         while(_loc6_ < _loc4_)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("tofflist.orderItem");
            _loc3_.index = _loc6_ + 1;
            _loc3_.info = param1[_loc6_];
            _list.addChild(_loc3_);
            _items.push(_loc3_);
            if(TofflistModel.firstMenuType == "teams" || TofflistModel.firstMenuType == "crossServerTeams")
            {
               _loc3_.addEventListener("tofflistitemselect",__itemChange2);
            }
            else
            {
               _loc3_.addEventListener("tofflistitemselect",__itemChange);
            }
            _loc6_++;
         }
         if(_list.getChildAt(0) is TofflistOrderItem)
         {
            _loc5_ = _list.getChildAt(0) as TofflistOrderItem;
            _loc5_.isSelect = true;
         }
         else
         {
            TofflistModel.currentText = "";
            TofflistModel.currentIndex = 0;
            TofflistModel.currentPlayerInfo = null;
         }
      }
      
      protected function __itemChange2(param1:TofflistEvent) : void
      {
         if(_currenItem)
         {
            _currenItem.isSelect = false;
         }
         _currenItem = param1.data as TofflistOrderItem;
         TofflistModel.currentIndex = _currenItem.index;
         TofflistModel.currentTeamInfo = _currenItem.teamRankinfo;
      }
      
      public function showHline(param1:Vector.<Point>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc2_ in _items)
         {
            _loc2_.showHLine(param1);
         }
      }
      
      private function __itemChange(param1:TofflistEvent) : void
      {
         if(_currenItem)
         {
            _currenItem.isSelect = false;
         }
         _currenItem = param1.data as TofflistOrderItem;
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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            _loc1_ = _items[_loc2_] as TofflistOrderItem;
            _loc1_.removeEventListener("tofflistitemselect",__itemChange);
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
            _loc2_++;
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
